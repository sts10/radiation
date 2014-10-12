#  Radiation v 0.0.1

Radiation is a simple blog CMS for totallynuclear.club pages. 

### Installation

1. Clone this directory into /~ (so it's next to your public_html directory)
2. By default, Radiation creates you blog at ~/public_html/blog.html. If you have a file called blog.html in your public_html directory, Radiation will overwrite it. So it it's important to you, back it up somewhere safe! 

### Usage 

At this point your going to need to `cd` to the `radiation` directory to issue commands to Radiation. 

Once you're in the `radiation`  directory, simple run `ruby bin/runner.rb` to run Radiation. You'll be greeted by a menu. 

### Changing Defaults 

If you don't want the Radiation-compiled blog to be located at `public_html/blog.html`, just change it in the Radiation file: `radiation/lib/site_generator.rb` in the following line: 

```
File.open("../public_html/blog.html", "w") do |f|
```

### Making Radiation Easier to Run by Editing Your Bash Profile. 

In `~/.bash_profile` you can add SOMETHING LIKE the following lines:

```
function radiation {
    cwd=$(pwd)
    cd ~/radiation
    ruby bin/runner.rb
    cd $cwd
}
```
