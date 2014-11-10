#!/usr/bin/env ruby
require_relative '../config/environment'
 
current_version = "0.2.3"

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
    puts "What do you want to do?"
    puts "p - publish your blog"
    puts "n - create new blog post"
    puts "e - edit a published post"
    puts "s - edit my user settings"
    puts "t - edit my blog template"
    puts "h - get help"
    puts "q - quit"
    
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
      puts "1 - HTML"
      puts "2 - Markdown"
      post_type = gets.chomp.strip

      if post_type == '2'
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
        puts "Would you like to publish your blog now? (y/n)"

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
        puts ""
        puts "Would you like to publish your blog now? (y/n)"

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
      puts "Opening your user settings now"
      system "#{$my_text_editor_command} ../radiation/user_settings.rb"
    elsif choice == 't'
      puts "Opening your blog template now"
      system "#{$my_text_editor_command} #{$my_template_location}"
    elsif choice == 'h'
      puts ""
      puts "For help, please visit https://github.com/sts10/radiation or consult the readme in ~/radiation"
      puts ""
      puts "Press ENTER to continue..."
      gets
    end
  end # ends while loop
else
  # not setup
  puts "It looks like you haven't setup Radiation yet."
  puts "Would you like to setup Radiation now? (y/n)"

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

    puts ""
    puts ""
    puts "Radiation is now installed!"
    puts ""
    puts ""

    puts "You may want to go to ~/radiation_templates/blog.html.erb to fill in your personal information."
    puts "See ReadMe for more information. We strongly suggest editing your .bash_profile to be able to call Radiation from anywhere."
  else 
    puts "OK maybe later"
  end
end

  

 