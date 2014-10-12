
class SiteGenerator 

  def initialize(posts_array)
    @posts_array = posts_array
  end
  def make_page!
    puts "we called make page!"
    template_doc= File.open("lib/templates/example.html.erb", "r")

    template = ERB.new(template_doc.read)
    
    File.open("../public_html/blog.html", "w") do |f|
        f.write(
          template.result(binding) # result is an ERB method. bidning means we're passing all local variables to the template. 
        )
      f.close
    end

    # `open _site/ruby_file.rb` 
  end

end