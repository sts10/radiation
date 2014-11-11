
class Blog   

  def compile(directory_location_of_posts)
  
    user_files = directory_location_of_posts + '*' #.html'

    # sort files in reverse chron order by creation time
    user_files_sorted = Dir[user_files].sort_by{ |f| 
      File.basename(f)
    }.reverse

    post_id = 0
    posts_array = []

    Dir.glob(user_files_sorted) do |file_location|
      html = false
      mdown = false

      if file_location[-5..-1] == ".html"
        html = true
      elsif file_location[-6..-1] == ".mdown"
        mdown = true
      else  # if some unrecognized file extension try rendering in html
        html = true 
      end
   
        
      file = File.new(file_location, "r")

  
      this_post = Post.new
      this_post.file_location = file_location

      if html 
        this_post.permalink = file_location[19..-6]
      elsif mdown
        this_post.permalink = file_location[19..-7]
      end
        

      # the following two lines could probably be refactored
      this_post.creation_datetime_obj = this_post.get_datetime_object(file_location)

      this_post.formatted_time = this_post.get_formatted_timestamp(this_post.creation_datetime_obj) #  .strftime "%l:%M%P, %A, %b %d, %Y"

      while (line = file.gets)
        if this_post.content
          this_post.content = this_post.content + line
        else 
          this_post.content = line
        end
      end

      if mdown && this_post.content != nil
        this_post.content = Kramdown::Document.new(this_post.content, :input => "GFM", :smart_quotes => ["lsquo", "rsquo", "ldquo", "rdquo"]).to_html
        this_post.content = this_post.content.gsub("“", "&ldquo;").gsub("”", "&rdquo;").gsub("‘", "&lsquo;").gsub("’", "&rsquo;").gsub("–", "&mdash;")
      end

      posts_array << this_post

      file.close

      post_id = post_id + 1
    end

    posts_array.each do |post|
      puts "Re-publishing #{post.file_location}"
    end

    return posts_array
  end

  def make_blog!(posts_array)
    @posts_array = posts_array

    puts "Creating new blog..."
    template_doc= File.open($my_template_location, "r")

    template = ERB.new(template_doc.read)
    
    File.open($my_blog_location, "w") do |f|
        f.write(
          template.result(binding) # result is an ERB method. `binding` here means we're passing all local variables to the template. 
        )
      f.close
    end
    
  end

  def publish!(directory_location_of_posts)
    posts_array = self.compile(directory_location_of_posts)

    self.make_blog!(posts_array)

    puts "☢☢☢ Publishing was (probably) successful! ☢☢☢"
    puts ""

  end
  
  def present_edit_menu(directory_location_of_posts)
    user_files = directory_location_of_posts + '*'

    # sort post files in reverse chron order by creation time
    user_files_sorted = Dir[user_files].sort_by{ |f| 
      File.basename(f)
    }.reverse

    post_id = 1    
    puts "Enter the number of the post you wish to edit (enter q to return to main menu):"

    Dir.glob(user_files_sorted) do |file_location|
      puts "#{post_id} - #{file_location}"
      post_id = post_id + 1
    end

    number_to_edit = gets.chomp.strip

    if number_to_edit == 'q'
      return false
    end

    file_name_to_edit = user_files_sorted[number_to_edit.to_i - 1]

    system "#{$my_text_editor_command} #{file_name_to_edit}"
  end

end