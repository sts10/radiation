
class Post
  attr_accessor :file_location, :permalink, :creation_datetime_obj, :formatted_time, :content

  def create(new_post_name)

    # clean new_post_name

    if (new_post_name[-5..-1] == ".html")
      new_post_name = new_post_name[0..-5]
    elsif (new_post_name[-4..-1] == ".htm")
      new_post_name = new_post_name[0..-4]
    end
    new_post_name = new_post_name.strip.gsub(' ', '-').gsub('?', '').gsub('.', '').gsub('!', '').gsub(':', '').gsub('"', '').gsub("'", "")

    # Add file extension
    new_post_name = new_post_name + ".html"

    # Add current time

    current_time = Time.new
    
    @file_name = current_time.strftime "%Y-%m-%eT%H+%M+%S-" + new_post_name
    
    # create a blank file  
    new_post = File.new("../radiation_posts/#{@file_name}", 'w')
    new_post.close
  end

  def edit
    system "vim ../radiation_posts/#{@file_name}"
  end

  def get_datetime_object(file_location)
    # I just shove the full file_location into DateTime.parse, with a gsub for the time colons, and it works like magic
    DateTime.parse(file_location.gsub('+', ':'))
  end

  def get_formatted_timestamp(datetime_object)
    datetime_object.strftime "%l:%M%P, %A, %b %d, %Y"
  end
end 