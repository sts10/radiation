#!/usr/bin/env ruby
require_relative '../config/environment'
 
current_version = "0.3.5"

if File.exist?('../radiation_posts') && File.exist?('../radiation_templates') && File.exist?($my_template_location)

  choice = ''
  while choice != 'q'
    system "clear"
    puts ""
    puts "   ☢                 ☢   "
    puts "  ☢☢☢               ☢☢☢  "
    puts " ☢☢☢☢☢             ☢☢☢☢☢ "
    puts "☢☢☢☢☢☢☢ RADIATION ☢☢☢☢☢☢☢"
    puts "           ☢☢☢  v. %s " %current_version
    puts "          ☢☢☢☢☢          "
    puts "         ☢☢☢☢☢☢☢         "
    puts "        ☢☢☢☢☢☢☢☢☢        "

    puts ""
    puts "Main Menu"
    puts "========="
    puts ""
    puts "What do you want to do?"
    puts ""
    puts "p - publish your blog"
    puts "n - create a new blog post"
    puts "e - edit a post"
    puts "d - delete a post"
    puts "u - update timestamp on a post"

    puts ""
    puts "s - edit my user settings"
    puts "b - add radiation function to your bash_profile" if open('../.bash_profile').grep(/function radiation/) == []
    puts "r - restore my user settings to the Radiation defaults"
    puts "t - edit my blog template"
    puts "h - get help"
    puts "q - quit"
    puts ""
    choice = gets.chomp.strip.downcase

    if choice == "p"
      system "clear"
      
      this_blog = Blog.new
      this_blog.publish!('../radiation_posts/')

      puts "Press ENTER to continue..."
      gets

    elsif choice == 'n'
      system "clear"
      puts "Would you like to write this new post in HTML or Markdown?"
      puts "h - HTML"
      puts "m - Markdown"
      post_type = gets.chomp.strip.downcase

      if post_type == 'm' || post_type == '2'
        post_type = "markdown"
      else
        post_type = "html"
      end


      puts "Please enter a file name for your new post (Example: My First Post). (Enter 'q' to return to main menu.)"
      new_post_name = gets.chomp.strip.downcase
      
      if new_post_name != 'q'
        new_post = Post.new
        new_post.create(new_post_name, post_type)

        new_post.edit

        system "clear"
        puts "Awesome post!"
        puts ""
        puts "Note: You must publish your blog for your new post to appear."
        puts "Would you like to publish your blog now? (y/N)"

        p_choice = gets.chomp.strip.downcase

        if p_choice == 'y' || p_choice == "p"
          this_blog = Blog.new
          this_blog.publish!('../radiation_posts/')
        else
          puts "OK I'll save your post but won't publish right now. You can always publish from the main menu."
        end

        puts "Press ENTER to continue..."
        gets
      end

    elsif choice == 'e'
      system "clear"

      this_blog = Blog.new 
      post_was_edited = this_blog.present_edit_menu('../radiation_posts/')

      if post_was_edited
        system "clear"
        puts "You edited a post!"
        puts ""
        puts "Note: You must publish your blog for your changes to the post to appear."
        puts "Would you like to publish your blog now? (y/N)"

        p_choice = gets.chomp.strip.downcase

        if p_choice == 'y' || p_choice == "p"
          this_blog = Blog.new
          this_blog.publish!('../radiation_posts/')
        else
          puts "OK I'll save your changes to the post, but I won't publish right now. You can always publish from the main menu."
        end
      else 
        puts "OK no worries. Let's head back to the main menu."
      end

      puts "Press ENTER to continue..."
      gets

    elsif choice == 'd'
      system "clear"

      this_blog = Blog.new 
      post_was_deleted = this_blog.present_delete_menu('../radiation_posts/')

      if post_was_deleted
        system "clear"
        puts "You deleted a post."
        puts ""
        puts "To remove this post from your site, you'll need to publish your blog."
        puts "Would you like to publish your blog now? (y/N)"

        p_choice = gets.chomp.strip.downcase

        if p_choice == 'y' || p_choice == "p"
          this_blog = Blog.new
          this_blog.publish!('../radiation_posts/')
        else
          puts "OK, that post was deleted, but I won't publish right now. You can always publish from the main menu."
        end
      else 
        puts "OK no worries. Let's head back to the main menu."
      end

      puts "Press ENTER to continue..."
      gets
  
    elsif choice == 'u'
      system "clear"

      this_blog = Blog.new 
      post_was_updated = this_blog.present_update_menu('../radiation_posts/')

      if post_was_updated
        system "clear"
        puts "You updated the timestamp on a post."
        puts ""
        puts "Note: You must publish your blog for your changes to the post to appear."
        puts "Would you like to publish your blog now? (y/N)"

        p_choice = gets.chomp.strip.downcase

        if p_choice == 'y' || p_choice == "p"
          this_blog = Blog.new
          this_blog.publish!('../radiation_posts/')
        else
          puts "OK I'll save your changes to the post, but I won't publish right now. You can always publish from the main menu."
        end
      else 
        puts "OK no worries. Let's head back to the main menu."
      end

      puts "Press ENTER to continue..."
      gets

    elsif choice == 's'
      system "clear"

      if File.exist?('../radiation_user_settings.rb') == false
        system "cp default_settings.rb ../radiation_user_settings.rb"
      end

      puts "Opening your user settings now"
      system "#{$my_text_editor_command} ../radiation_user_settings.rb"

      system "clear"
      puts "For changes to take effect, Radiation has to restart."
      puts "I'll quit now. Just launch Radiation again."
      puts ""
      puts "Press ENTER to continue..."
      gets

      choice = 'q'

    elsif choice == 'r'
      system "clear"
      puts "I'm about to overwrite your user settings with the defualts from v #{current_version}."
      puts "Your user setting will be overwritten. Is that OK? (y/N)"
      r_choice = gets.chomp.strip.downcase

      if r_choice == 'y'
        system "rm ../radiation_user_settings.rb"
        system "cp default_settings.rb ../radiation_user_settings.rb"
        
        system "clear"
        puts "User settings restored to defaults for v #{current_version}. Edit them through the main menu."
        puts ""
        puts "For changes to take effect, Radiation has to restart."
        puts "I'll quit now. Just launch Radiation again."
        puts ""
        puts "Press ENTER to continue..."
        gets

        choice = 'q'
      else
        puts "OK, I'll leave your user settings alone."
        puts ""
        puts "Press ENTER to continue..."
        gets  
      end

    elsif choice == 't'
      puts "Opening your blog template now"
      system "#{$my_text_editor_command} #{$my_template_location}"
    elsif choice == 'b'
      system "clear"

      has_function = open('../.bash_profile').grep(/function radiation/)
      if has_function != []
        puts "It look like you already have a radiation function in your bash_profile."
        puts "I strongly recommend you do NOT add another radiation fucntion at this time,"
        puts "and instead go check your bash_profile by running vim ~/.bash_profile"
        puts ""
        puts "Add a radiation function to your .bash_profile? (y/N)"
      else
        puts "I'm about to edit your .bash_profile in order to make Radiation easier to run."
        puts "Once the function is inserted you'll be able to run Radiation by just typing radiation and pressing enter anywhere in your box."
        puts "If you have already done this, or you have your own method of callind Radiation,"
        puts "don't run this."
        puts ""
        puts "Add a radiation function to your .bash_profile? (y/N)"
      end

      b_choice = gets.chomp.strip.downcase

      if b_choice == 'y'
        puts "Adding a radiation function to your .bash_profile."
        File.open('../.bash_profile', "a") do |f|
          f.puts("")
          f.puts("# This function lets you call Radiation from anywhere in your box by")
          f.puts("# simply typing radiation and pressing enter.")
          f.puts("function radiation {")
          f.puts("    cwd=$(pwd)")
          f.puts("    cd ~/radiation")
          f.puts("    ruby bin/runner.rb")
          f.puts("    cd $cwd")
          f.puts("}")
          f.puts("")
          # f.close
        end

        system "source ../.bash_profile"

        system "clear"
        puts "Cool. You should be good to go."
        puts "Now, whenever you want to run Radiation, just type radiation and press enter."
        puts ""
        puts "If you'd like to check your .bash_profile for youself, quit Radiation"
        puts "and run vim ~/.bash_profile"
        puts ""
        puts "Press ENTER to continue..."
        gets
      end

    elsif choice == 'h'
      puts ""
      puts "For help, please visit https://github.com/sts10/radiation or consult the readme in ~/radiation"
      puts ""
      puts "Press ENTER to continue..."
      gets
    end
  end # ends while loop
else
  # user is not setup
  puts "It looks like you haven't FULLY setup Radiation yet."
  puts "Would you like to setup Radiation now? (y/N)"

  confirm = gets.chomp.downcase.strip

  if confirm == 'y'
    system "mkdir ../radiation_posts"
    
    if File.exist?($my_template_location)
      puts "It looks like you already have a template in place. I'll leave it alone."
    else
      puts "Creating radiation_templates folder and putting a sample template in there with the proper file name."
      system "mkdir ../radiation_templates"
      system "cp sample_templates/blog.html.erb #{$my_template_location}"
    end

    if File.exist?('../radiation_user_settings.rb')
      puts "It looks like you already have a radiation_user_settings.rb file. Awesome!"
      puts "I'll leave it be, but you can check /radiation/default_settings.rb to see if there are any new settings for you to edit in this version (v #{current_version})"
    else 
      puts "Creating a radiation_user_settings.rb file for you. You can edit it later or not, no worries."
      system "cp default_settings.rb ../radiation_user_settings.rb"
    end

    puts ""
    puts ""
    puts "Radiation is now setup and ready to go!"
    puts ""
    puts ""

    puts "What now?"
    puts "You can run Radiation again and do a number of things:"
    puts "- create a new blog post"
    puts "- edit your blog template"
    puts "- edit your user settings"
    puts "See ReadMe for more information. Also, we strongly suggest editing your .bash_profile to be able to call Radiation from anywhere."
  else 
    puts "OK maybe later"
  end
end

  

 
