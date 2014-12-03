
class Blog   

  def compile(directory_location_of_posts)
  
    user_files = directory_location_of_posts + '*' #.html'

    # sort files in reverse chron order by creation time
    user_files_sorted = Dir[user_files].sort_by{ |f| 
      File.basename(f)
    }.reverse

    post_id = 0
    posts_array = []
    drafts = 0

    Dir.glob(user_files_sorted) do |file_location|
      html = false
      mdown = false
      draft = false

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
        else # this must be the first line of the post
          line.strip.downcase == "draft" ? draft = true : draft = false
          this_post.content = line
        end
      end

      if mdown && this_post.content != nil
        this_post.content = Kramdown::Document.new(this_post.content, :input => "GFM", :smart_quotes => ["lsquo", "rsquo", "ldquo", "rdquo"]).to_html
        this_post.content = this_post.content.gsub("“", "&ldquo;").gsub("”", "&rdquo;").gsub("‘", "&lsquo;").gsub("’", "&rsquo;").gsub("–", "&mdash;").gsub('…', '...')
      end

      posts_array << this_post if !draft

      file.close

      post_id = post_id + 1

      if draft
        drafts = drafts + 1
      end
      
    end

    posts_array.each do |post|
      puts "Re-publishing #{post.file_location}"
    end

    drafts_string = "drafts"
    if drafts == 1
      drafts_string = "draft"
    end
    puts ""
    puts "You have #{drafts} #{drafts_string}"
    puts ""

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
    
    file_to_edit = present_menu_of_posts(directory_location_of_posts, "edit")

    if file_to_edit
      system "#{$my_text_editor_command} #{file_to_edit}"
    else
      return false
    end
  end

  def present_delete_menu(directory_location_of_posts)
    file_to_delete = present_menu_of_posts(directory_location_of_posts, "delete")

    if file_to_delete
      puts "Are you sure you wish to delete the post #{file_to_delete}? (y/N)"
      d_choice = gets.chomp.downcase

      if d_choice == 'y'
        puts "Deleting post #{file_to_delete}"
        system "rm #{file_to_delete}"
      end
    else
      return false
    end
  end

  def present_update_menu(directory_location_of_posts)
    file_to_update = present_menu_of_posts(directory_location_of_posts, "update")

    if file_to_update
      puts "Are you sure you wish to update the timestamp to now on the post #{file_to_update}? This action cannot be undone. (y/N)"
      u_choice = gets.chomp.downcase

      if u_choice == 'y'
        # Add current time
        current_time = Time.new.in_timezone($my_timezone)

        # get the filename part of the file location (../radiation_posts/file.html)
        old_file_name = file_to_update.split('/')[2]

        # This removes the timestamp from the filename.
        # Since the filename is "YYYY-MM-DDTHH+MM+SS-post-name.html" we split the name into an array
        # and remove the first 3 values (YYYY, MM, DDTHH+MM+SS). Then we join the array back into a string.
        post_name = old_file_name.split('-').pop(2).join('-')
        
        file_name = current_time.strftime "%Y-%m-%dT%H+%M+%S-" + post_name
        
        # rename the file  
        File.rename(file_to_update, "../radiation_posts/#{file_name}",)
      end
    else
      return false
    end
  end

  def present_menu_of_posts(directory_location_of_posts, verb)
    user_files = directory_location_of_posts + '*'

    # sort post files in reverse chron order by creation time
    user_files_sorted = Dir[user_files].sort_by{ |f| 
      File.basename(f)
    }.reverse

    post_id = 1    
    puts "Enter the number of the post you wish to #{verb} (enter q to return to main menu):"

    Dir.glob(user_files_sorted) do |file_location|
      line = File.open(file_location, &:readline).strip.downcase
      if line 
        draft = line == "draft" ? "- DRAFT" : ""
      end
      puts "#{post_id} - #{file_location} #{draft}"
      post_id = post_id + 1
    end

    file_number = gets.chomp.strip

    if file_number == 'q'
      return false
    end

    file_name = user_files_sorted[file_number.to_i - 1]
  end
end
