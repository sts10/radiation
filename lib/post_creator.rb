class PostCreator
  def initialize(new_post_name)
    @new_post_name = new_post_name
    puts "running initialize"
    
    new_post = File.new("../posts/#{new_post_name}", 'w')
    new_post.close

    system "vim ../posts/#{new_post_name}"

  end



end

