#!/usr/bin/env ruby
require_relative '../config/environment'
 
if ARGV[0] == "publish"
  this_blog = Blog.new
  this_blog.publish!('../posts/')
else

  choice = ''
  while choice != 'q'
    puts ""
    puts "   ☢                 ☢   "
    puts "  ☢☢☢               ☢☢☢  "
    puts " ☢☢☢☢☢             ☢☢☢☢☢ "
    puts "☢☢☢☢☢☢☢ RADIATION ☢☢☢☢☢☢☢"
    puts "           ☢☢☢           "
    puts "          ☢☢☢☢☢          "
    puts "         ☢☢☢☢☢☢☢         "
    puts "        ☢☢☢☢☢☢☢☢☢        "

    puts ""
    puts "What do you want to do?"
    puts "p - publish your blog"
    puts "n - create new blog post"
    puts "q - quit"
    
    choice = gets.chomp

    if choice == "p" || choice == "P"
      this_blog = Blog.new
      this_blog.publish!('../posts/')

    elsif choice == 'n' || choice == "N"
      puts "Please enter an html file name for your new post (Example: a-laid-back-sunday.html)"
      new_post_name = gets.chomp
      new_post = PostCreator.new(new_post_name)
      new_post.edit
    end
  end

end
  

 