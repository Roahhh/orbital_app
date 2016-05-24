module UsersHelper

  # Returns the Gravatar for the given user.
  def gravatar_for(user, options = { size: 80 })
    gravatar_id = Digest::MD5::hexdigest(user.email.downcase)
    size = options[:size]
    gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}?s=#{size}"
    image_tag(gravatar_url, alt: user.first_name, class: "gravatar")
  end
  def full_name(user)
  	 return user.first_name + " " + user.last_name
  end

  def total_exp_level(user)
 	  exp_mul = 1.15
  	lvl = user.lvl
  	return (100 * (1 - exp_mul ** (lvl - 1)) / (1 - exp_mul))
  end

  def exp_to_lvl(user)
  	next_lvl = 100 * (1.2 ** (user.lvl - 1))
  	return next_lvl - (user.exp - total_exp_level(user))
  end

  def exp_remain(user)
  	next_lvl = 100 * (1.2 ** (user.lvl - 1))
  	exp_percent = (user.exp - total_exp_level(user)) / next_lvl 
  	return exp_percent * 100
  end

  def add_exp(user, exp)
  	to_lvl_exp = exp_to_lvl(user)
  	if (exp < to_lvl_exp)
  		user.exp += exp
  		user.save
  	else 
  		user.exp += to_lvl_exp
  		user.lvl += 1
  		add_exp(user, exp - to_lvl_exp)
  	end
  end
end
