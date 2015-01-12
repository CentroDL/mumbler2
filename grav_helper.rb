module GravatarHelper

  def hash(email)
    Digest::MD5.hexdigest(email.downcase)
  end

  def get_gravatar(email)
    grav_hash = HTTParty.get("http://www.gravatar.com/#{hash(email)}.json")
    return nil if grav_hash.nil?
    {
      username: grav_hash["entry"][0]["preferredUsername"],
      image: grav_hash["entry"][0]["thumbnailUrl"]
    }
  end

end

