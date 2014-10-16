#!/usr/bin/env ruby
require_relative '../config/environment'
 
if ARGV[0] == "publish"
  this_blog = Blog.new
  this_blog.publish!('../radiation_posts/')
elsif ARGV[0] == "setup"
  puts "OK, we'll create a posts folder and a templates folder in the right place for you."

  system "mkdir ../radiation_posts"
  if File.exist?('../radiation_templates/blog.html.erb')
    puts "It looks like you already have a template in place. I'll leave it alone."
  else
    puts "Creating radiation_templates folder and putting a sample template in there with the proper file name."
    system "mkdir ../radiation_templates"
    system "cp sample_templates/blog.html.erb ../radiation_templates/blog.html.erb"
  end

  puts ""
  puts ""
  puts "Radiation is now installed!"
  puts ""
  puts ""

  puts "You may want to go to ~/radiation_templates/blog.html.erb to fill in your personal information."
  puts "See ReadMe for more information. We strongly suggest editing your .bash_profile to be able to call Radiation from anywhere."
  
else
  if File.exist?('../radiation_posts') && File.exist?('../radiation_templates') && File.exist?('../radiation_templates/blog.html.erb')

    puts ""
    puts "   ☢                 ☢   "
    puts "  ☢☢☢               ☢☢☢  "
    puts " ☢☢☢☢☢             ☢☢☢☢☢ "
    puts "☢☢☢☢☢☢☢ RADIATION ☢☢☢☢☢☢☢"
    puts "           ☢☢☢           "
    puts "          ☢☢☢☢☢          "
    puts "         ☢☢☢☢☢☢☢         "
    puts "        ☢☢☢☢☢☢☢☢☢        "


    choice = ''
    while choice != 'q'
      puts ""
      puts "Main Menu"
      puts ""
      puts "What do you want to do?"
      puts "p - publish your blog"
      puts "n - create new blog post"
      puts "e - edit a published post"
      puts "t - edit my blog template"
      puts "q - quit"
      
      choice = gets.chomp.strip.downcase

      if choice == "p"
        this_blog = Blog.new
        this_blog.publish!('../radiation_posts/')

      elsif choice == 'n'
        puts "Please enter a file name for your new post (Example: My First Post). (Enter 'q' to return to main menu.)"
        new_post_name = gets.chomp.strip.downcase
        
        if new_post_name != 'q'
          new_post = Post.new
          new_post.create(new_post_name)

          new_post.edit

          system "clear"
          puts "Awesome post!"
          puts "Note: You must publish your blog for your new post to appear."
          puts ""
        end
      elsif choice == 't'
        puts "Opening your blog template now"
        system "vim ../radiation_templates/blog.html.erb"
      elsif choice == 'e'
        this_blog = Blog.new 
        this_blog.present_edit_menu('../radiation_posts/')
      
      end
    end # ends while loop
  else
    # not setup
    puts "It looks like you haven't setup Radiation yet."
    puts "Would you like to setup Radiation now? (y/n)"

    confirm = gets.chomp.downcase.strip

    if confirm == 'y'

      system "mkdir ../radiation_posts"
      
      if File.exist?('../radiation_templates/blog.html.erb')
        puts "It looks like you already have a template in place. I'll leave it alone."
      else
        puts "Creating radiation_templates folder and putting a sample template in there with the proper file name."
        system "mkdir ../radiation_templates"
        system "cp sample_templates/blog.html.erb ../radiation_templates/blog.html.erb"
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

end
  

 