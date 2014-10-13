

class Post
  attr_accessor :file_location, :timestamp, :formatted_time, :content

  def create(file_name)
    current_time = Time.new
    full_file_name = current_time.strftime "%Y-%m-%e-%H-%M-%S-" + file_name
    @file_name = full_file_name
    
    new_post = File.new("../posts/#{@file_name}", 'w')
    new_post.close
  end

  def edit
    system "vim ../posts/#{@file_name}"
  end

  def get_datetime_object(file_location)
    # ../posts/2014-10-13-17-27-33-second-post.html
    file_name = /[^\/]+$/.match(file_location).string # everything after last /
  end

  def get_formatted_timestamp(file_location)
    File.ctime(file_object) # this doesn't work for some buggy reason
  end
end 