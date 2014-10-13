
class Post
  attr_accessor :file_location, :creation_datetime_obj, :formatted_time, :content

  def create(file_name)
    current_time = Time.new
    full_file_name = current_time.strftime "%Y-%m-%eT%H+%M+%S-" + file_name
    @file_name = full_file_name
    
    new_post = File.new("../posts/#{@file_name}", 'w')
    new_post.close
  end

  def edit
    system "vim ../posts/#{@file_name}"
  end

  def get_datetime_object(file_location)
    # I just shove the full file_location into DateTime.parse, with a gsub for the time colons, and it works like magic
    DateTime.parse(file_location.gsub('+', ':'))
  end

  def get_formatted_timestamp(datetime_object)
    datetime_object.strftime "%l:%M%P, %A, %b %d, %Y"
  end
end 