class User < ActiveRecord::Base
  has_many :messages, dependent: :destroy
  has_many :comments, dependent: :destroy
  
  has_many :quest_assignments
  has_many :quests, :through => :quest_assignments

	attr_accessor :remember_token
  @@exp_mul = 1.15

	VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

	before_save { self.email = email.downcase } 
	before_save { self.identity_no = identity_no.upcase }

	validates :first_name, presence: true
	validates :last_name, presence: true
	validates :email, length: {maximum: 255}, 
	           format: { with: VALID_EMAIL_REGEX },
	           uniqueness: { case_sensitive: false }
  validates :identity_no, length: {maximum: 20}, presence: true,
	           uniqueness: { case_sensitive: false }
	validates :password, presence: true, length: { minimum: 6 }, allow_nil: true
  validates :sp, :numericality => { :only_integer => true, :greater_than_or_equal_to => 0 }
  validates :job, inclusion: { in: %w(Apprentice Warrior Mage Thief Monk Magic_Knight Berserker), message: "%{value} is not a job class" }

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
    if self.job == "Apprentice"
      return self.str * 1.5
    elsif self.job == "Warrior"
      return self.total_stat("str") * 2.5 + self.total_stat("agi") * 0.5
    elsif self.job == "Mage"
      return self.total_stat("int") * 2.8 + self.total_stat("luck") * 0.2
    elsif self.job == "Thief"
      return self.total_stat("agi") * 2.5 + self.total_stat("vit") * 0.5
    elsif self.job == "Monk"
      return self.total_stat("str") * 1.5 + self.total_stat("vit") * 1.5
    elsif self.job == "Magic_Knight"
      return self.total_stat("str") * 2 + self.total_stat("int") * 2
    elsif self.job == "Berserker"
      return self.total_stat("int") + self.total_stat("vit") * 3
    end
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
    if self.job == "Warrior"
      self.str_job += 2
      self.agi_job += 1
    elsif self.job == "Mage"
      self.add_int(3, "job")
    elsif self.job == "Thief"
      self.agi_job += 2
      self.add_vit(1, "job")
    elsif self.job == "Monk"
      self.str_job += 2
      self.add_vit(1, "job") 
    elsif self.job == "Magic_Knight"
      self.str += 3
      self.add_int(3, "job")
    elsif self.job == "Berserker"
      self.add_vit(4, "job")
      self.int += 2
    else
    end 
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

    self.curr_hp = self.hp + self.hp_job + self.hp_eqp
    self.curr_mp = self.mp + self.mp_job + self.mp_eqp
    
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

# ---------------------------------------------------------------------------------------------------
# -------- methods for rolling luck for wishing well --------------------------------------
  def roll_luck
    self.luck = rand(100)
    #self.gold -= 100
    self.save
  end  
end
