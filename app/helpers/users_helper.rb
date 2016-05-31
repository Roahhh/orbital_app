module UsersHelper
  @@exp_mul = 1.15

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
  	lvl = user.lvl
  	return (100 * (1 - @@exp_mul ** (lvl - 1)) / (1 - @@exp_mul))
  end

  def exp_to_lvl(user)
  	next_lvl = 100 * (@@exp_mul ** (user.lvl - 1))
  	return next_lvl - (user.exp - total_exp_level(user))
  end

  def exp_percent(user)
  	next_lvl = 100 * (@@exp_mul ** (user.lvl - 1))
  	exp_percent_now = (user.exp - total_exp_level(user)) / next_lvl 
  	return exp_percent_now * 100
  end

  def total_stat(user, stat)
    return user[stat] + user[stat + "_job"] + user[stat + "_eqp"]
  end

  def hp_percent(user)
    return (user.curr_hp.to_f / total_stat(user, "hp").to_f) * 100
  end

  def mp_percent(user)
    return (user.curr_mp.to_f / total_stat(user, "mp").to_f) * 100
  end
end
