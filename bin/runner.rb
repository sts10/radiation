#!/usr/bin/env ruby
require_relative '../config/environment'
 
if ARGV[0] == "publish"
  this_blog = Blog.new
  this_blog.publish!('../posts/')
elsif ARGV[0] == "setup"
  puts "OK, we'll create a posts folder and a templates folder in the right place for you."

  system "mkdir ../posts"
  system "mkdir ../radiation_templates"
  system "cp sample_templates/blog.html.erb ../radiation_templates/blog.html.erb"

  puts ""
  puts ""
  puts "Radiation is now installed!"
  puts ""
  puts ""

  puts "You may want to go to ~/templates/blog.html.erb to fill in your personal information."
  puts "See ReadMe for more information. We strongly suggest editing your .bash_profile to be able to call Radiation from anywhere."
  
else

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
    puts "t - edit my blog template"
    puts "q - quit"
    
    choice = gets.chomp

    if choice == "p" || choice == "P"
      this_blog = Blog.new
      this_blog.publish!('../posts/')

    elsif choice == 'n' || choice == "N"
      puts "Please enter an html file name for your new post (Example: My First Post). (Enter 'q' to return to main menu.)"
      new_post_name = gets.chomp.strip
      if new_post_name != 'q' && new_post_name != 'Q'

        # clean new_post_name
        new_post_name = new_post_name.downcase
        if (new_post_name[-5..-1] == ".html")
          new_post_name = new_post_name[0..-5]
        elsif (new_post_name[-4..-1] == ".htm")
          new_post_name = new_post_name[0..-4]
        end
        new_post_name = new_post_name.strip.gsub(' ', '-').gsub('?', '').gsub('.', '').gsub('!', '').gsub(':', '').gsub('"', '').gsub("'", "")
        new_post_name = new_post_name + ".html"

        new_post = Post.new
        new_post.create(new_post_name)

        new_post.edit
      end
    elsif choice == 't' || choice == 'T'
      puts "Opening your blog template now"
      system "vim ../radiation_templates/blog.html.erb"
    end
  end

end
  

 