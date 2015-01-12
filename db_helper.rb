module DatabaseHelper

  def create_mumble(mumble)
    id = $db.incr "mumble_id"

    data = set_defaults_for(mumble)

    $db.mapped_hmset "mumble:#{id}", data

    $db.rpush "mumble_list", id
    id
  end

  def get_mumbles
    ids = $db.lrange "mumble_list", 0, -1

    ids.map do |id|
        $db.hgetall "mumble:#{id}"
    end
  end

  def get_mumble(id)
    $db.hgetall "mumble:#{id}"
  end

  def set_defaults_for(params)

      gravatar_info = get_gravatar(params["author_email"])

      unless gravatar_info.nil?
        params["author_handle"] = gravatar_info[:username]
        params["author_thumbnail"] = gravatar_info[:image]
      end

      params["date"]= Time.new.strftime("%Y-%m-%d") if params["date"]== ""
      params["author_handle"] = "anonymous" if params["author_handle"] == ""
      params["author_thumbnail"] = "http://goo.gl/KQUfGE" if params["author_thumbnail"] == ""
      params["likes"] = 0
      params
  end

end
