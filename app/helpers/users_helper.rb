module UsersHelper
  exp_mul = 1.15
  # Returns the Gravatar for the given user.
  def gravatar_for(user)
    gravatar_id = Digest::MD5::hexdigest(user.email.downcase)
    gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}"
    image_tag(gravatar_url, alt: user.first_name, class: "gravatar")
  end

  def full_name(user)
  	 return user.first_name + " " + user.last_name
  end

  def total_exp_level(lvl)
  	return 100 #(100(1 - exp_mul ** (lvl - 1)) / (1 - exp_mul))
  end

  def exp_remain(user)
  	next_lvl = 100 * (1.2 ** (user.lvl - 1))
  	return (user.exp - total_exp_level) / next_lvl 
  end
end
