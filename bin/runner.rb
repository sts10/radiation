#!/usr/bin/env ruby
require_relative '../config/environment'
 
if ARGV[0] == "publish"
  posts = PostCompiler.new('posts/')
  posts_array = posts.compile 

  site_generator = SiteGenerator.new(posts_array)
  site_generator.make_page!
else

  choice = ''
  while choice != 'q'
    puts ""
    puts "                       "
    puts "   ☢☢               ☢☢☢  "
    puts "  ☢☢☢☢             ☢☢☢☢☢  "
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
      posts = PostCompiler.new('posts/')
      posts_array = posts.compile 

      site_generator = SiteGenerator.new(posts_array)
      site_generator.make_page!
    elsif choice == 'n' || choice == "N"
      puts "Please enter an html file name for your new post (Example: a-laid-back-sunday.html)"
      new_post_name = gets.chomp
      new_post = PostCreator.new(new_post_name)
      # new_post.add ?
    end
  end

end
  

 