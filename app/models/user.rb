class User < ActiveRecord::Base
  has_many :messages, dependent: :destroy
  has_many :comments, dependent: :destroy
  
  has_many :bugreports
  has_many :bugcomments

  has_many :quest_assignments, dependent: :destroy
  has_many :quests, :through => :quest_assignments


  has_many :item_assignments, dependent: :destroy
  has_many :items, :through => :item_assignments
  has_one :jobclass
  
  has_many :conversations, :foreign_key => :sender_id, dependent: :destroy
	attr_accessor :remember_token
  @@exp_mul = 1.15

	VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

	before_save { self.email = email.downcase } 
	before_save { self.identity_no = identity_no.upcase }

	validates :first_name, presence: true
	validates :last_name, presence: true
  validates :class_no, presence: true
  validates :year, presence: true

	validates :email, length: {maximum: 255}, 
	           format: { with: VALID_EMAIL_REGEX },
	           uniqueness: { case_sensitive: false }
  validates :identity_no, length: {maximum: 20}, presence: true,
	           uniqueness: { case_sensitive: false }
	validates :password, presence: true, length: { minimum: 6 }, allow_nil: true
  validates :sp, :numericality => { :only_integer => true, :greater_than_or_equal_to => 0 }

	has_secure_password

	def User.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                  BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end

  # Returns a random token.
  def User.new_token
    SecureRandom.urlsafe_base64
  end
    
  # Remembers a user in the database for use in persistent sessions.
  def remember
    self.remember_token = User.new_token
    update_attribute(:remember_digest, User.digest(remember_token))
  end

  # Forgets a user.
  def forget
    update_attribute(:remember_digest, nil)
  end
    
  # Returns true if the given token matches the digest.
  def authenticated?(remember_token)
    return false if remember_digest.nil?
    BCrypt::Password.new(remember_digest).is_password?(remember_token)
  end

  def full_name
    return "Class " + self.class_no.to_s + " | " + self.identity_no + " | " + self.first_name + " " + self.last_name
  end 

  def first_last_name
    return self.first_name + " " + self.last_name
  end

# ---------------------------------------------------------------------------------------------------
# The following methods are for Stats calculation

  def stat_long(string)
    if string == "vit"
      return "Vitality"
    elsif string == "int"
      return "Intelligence"
    elsif string == "agi"
      return "Agility"
    elsif string == "str"
      return "Strength"
    else
      return "String given is not a Stat!"
    end
  end

  def total_stat(stat)
    return self[stat] + self[stat + "_job"] + self[stat + "_eqp"]
  end

  def att_value
    job = Job.find(self.job_id)
    
    return self.total_stat("hp") * job.hp + 
           self.total_stat("mp") * job.mp + 
           self.total_stat("vit") * job.vit + 
           self.total_stat("int") * job.int + 
           self.total_stat("agi") * job.agi + 
           self.total_stat("str") * job.str +
           self.luck * job.luck
  end

  #Since HP and MP are dependant on Vit and Int respective, individual methods are used to calculate the total HP and MP at every increase
  # HP = Vit * 10
  # MP = Int * 3
  def add_vit(amt, loc)
    if loc == ""
      self.vit += amt
      self.hp = self.vit * 10
    elsif loc == "job" || loc == "eqp"
      self["vit_" + loc] += amt
      self["hp_" + loc] = self["vit_" + loc] * 10
    end

    self.save
  end

  def add_int(amt, loc)
    if loc == ""
      self.int += amt
      self.mp = self.int * 3
    elsif loc == "job" || loc == "eqp"
      self["int_" + loc] += amt
      self["mp_" + loc] = self["int_" + loc] * 3
    end

    self.save
  end

  def minus_vit(amt, loc)
    if loc == ""
      self.vit -= amt
      self.hp = self.vit * 10
    elsif loc == "job" || loc == "eqp"
      self["vit_" + loc] -= amt
      self["hp_" + loc] = self["vit_" + loc] * 10
    end

    self.save
  end

  def minus_int(amt, loc)
    if loc == ""
      self.int -= amt
      self.mp = self.int * 3
    elsif loc == "job" || loc == "eqp"
      self["int_" + loc] -= amt
      self["mp_" + loc] = self["int_" + loc] * 3
    end

    self.save
  end

# This method is specific for users to add their sp
  def add_stat(stat)
    if self.sp <= 0
    else
      if stat == "vit"
        add_vit(1, "")
      elsif stat == "int"
        add_int(1, "")
      else
        self[stat] += 1
      end

      self.sp -= 1
      self.save
    end
  end
# ---------- Level Up related methods -----------

  def total_exp_level
    lvl = self.lvl
    return (100 * (1 - @@exp_mul ** (lvl - 1)) / (1 - @@exp_mul))
  end
  
  def exp_to_lvl
    next_lvl = 100 * (@@exp_mul ** (self.lvl - 1))
    return next_lvl - (self.exp - self.total_exp_level)
  end

  def bonus_lvlup
    job = Job.find(self.job_id)

    self.str_job += job.str_bonus
    self.agi_job += job.agi_bonus
    self.add_vit(job.vit_bonus, "job")
    self.add_int(job.int_bonus, "job")
    self.hp_job += job.hp_bonus
    self.mp_job += job.mp_bonus
    
    self.save
  end

  def lvlup
    self.exp += self.exp_to_lvl
    self.lvl += 1
    self.hp += 50
    self.mp += 5
    self.str += 1
    self.agi += 1
    self.add_vit(1, "")
    self.add_int(1, "")
    self.luck = rand(100)
    self.sp += 3

    self.bonus_lvlup

    self.curr_hp = self.total_stat("hp")
    self.curr_mp = self.total_stat("mp")
    
    self.save
  end

  def add_exp(exp)
    to_lvl_exp = self.exp_to_lvl
    if (exp < to_lvl_exp)
      self.exp += exp
      self.save
    else # This is the case of level up
      self.lvlup
      self.add_exp(exp - to_lvl_exp)
    end
  end
# ---------- Equipping related methods -----------
  def equip(equipment)
    if equipment.shop != "Equipment"
      flash[:danger] = "Item is not an Equipment!"
    end

    if equipment.body_pt == "Head"
      self.eqp_head = equipment.id
    elsif equipment.body_pt == "Body"
      self.eqp_body = equipment.id
    elsif equipment.body_pt == "Boots"
      self.eqp_boots = equipment.id
    elsif equipment.body_pt == "Weapon"
      self.eqp_wpn = equipment.id
    else
      flash[:danger] = "Error equipping equipment. Please report this to the administrators. Thank you!"
    end


    self.str_eqp += equipment.str.to_i
    self.agi_eqp += equipment.agi.to_i
    self.add_vit(equipment.vit.to_i, "eqp")
    self.add_int(equipment.int.to_i, "eqp")
    self.hp_eqp += equipment.hp.to_i
    self.mp_eqp += equipment.mp.to_i
    self.save
  end

  def unequip(equipment)
    if equipment.shop != "Equipment"
      flash[:danger] = "Item is not an Equipment!"
    end

    if equipment.body_pt == "Head"
      self.eqp_head = nil
    elsif equipment.body_pt == "Body"
      self.eqp_body = nil
    elsif equipment.body_pt == "Boots"
      self.eqp_boots = nil
    elsif equipment.body_pt == "Weapon"
      self.eqp_wpn = nil
    else
      flash[:danger] = "Error equipping equipment. Please report this to the administrators. Thank you!"
    end

    self.str_eqp -= equipment.str.to_i
    self.agi_eqp -= equipment.agi.to_i
    self.minus_vit(equipment.vit.to_i, "eqp")
    self.minus_int(equipment.int.to_i, "eqp")
    self.hp_eqp -= equipment.hp.to_i
    self.mp_eqp -= equipment.mp.to_i
    self.save
  end
# ---------- Job Change methods -----------
  def changejob(job_id)
    job = Job.find(job_id)
    level = self.lvl - 1

    self.job_id = job_id
    self.str_job = job.str_bonus * level
    self.agi_job = job.agi_bonus * level
    self.hp_job = job.hp_bonus * level
    self.mp_job = job.mp_bonus * level
    self.vit_job = 0
    self.int_job = 0
    self.save

    self.add_vit(job.vit_bonus * level, "job")
    self.add_int(job.int_bonus * level, "job")
    self.curr_hp = self.total_stat("hp")
    self.curr_mp = self.total_stat("mp")
    self.save
  end
# -------- methods for rolling luck for wishing well --------------------------------------
  def roll_luck
    self.luck = rand(100)
    #self.gold -= 100
    self.save
  end  
end
# ---------------------------------------------------------------------------------------------------
