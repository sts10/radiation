require 'open3'
require 'time'

class Post
  attr_accessor :file_location, :timestamp, :formatted_time, :content

  def create(file_name)
    @file_name = file_name
    
    new_post = File.new("../posts/#{file_name}", 'w')
    new_post.close
  end

  def edit
    system "vim ../posts/#{@file_name}"
  end

  def get_created_at_time(file_location)
    # File.ctime(file_object) # this doesn't work for some buggy reason

    Time.parse(Open3.popen3("mdls", 
                            "-name",
                            "kMDItemContentCreationDate", 
                            "-raw", file_location)[1].read)
  end
end 