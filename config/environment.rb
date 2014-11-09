require 'erb'
require 'date'
require 'tzinfo'
require 'active_support'

require_relative '../lib/time'
require_relative '../lib/post'
require_relative '../lib/blog'


$my_timezone = 'America/New_York'
$my_template_location = '../radiation_templates/blog.html.erb'
$my_blog_location = '../public_html/blog.html'
$my_text_editor_command = 'subl'