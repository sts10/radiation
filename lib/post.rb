class Post
  attr_accessor :filename, :timestamp, :formatted_time, :content

  def create(file_name)
    @file_name = file_name
    
    new_post = File.new("../posts/#{file_name}", 'w')
    new_post.close
  end
  def edit
    system "vim ../posts/#{@file_name}"
  end
end 