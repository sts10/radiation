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

  def get_created_at_time(file_object)
    File.ctime(file_object) # this doesn't work for some buggy reason
  end
end 