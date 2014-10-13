#  Radiation v 0.0.2

Radiation is a simple blog CMS for [totallynuclear.club](http://totallynuclear.club/) pages. 

### Installation

1. Clone this directory into `~/` (so it's next to your public_html directory). To do this, run `cd ~` and then `git clone https://github.com/sts10/radiation.git`
2. Next, you'll need to create a `posts` directory for your posts. This needs to be in `~/` as well. To do this, you can run `mkdir ~/posts`
3. By default, Radiation creates you blog at ~/public_html/blog.html. If you have a file called blog.html in your public_html directory, Radiation will overwrite it. So it it's important to you, back it up somewhere safe! 

### Usage 

At this point your going to need to `cd` to the `radiation` directory to issue commands to Radiation. 

Once you're in the `radiation`  directory, simple run `ruby bin/runner.rb` to run Radiation. You'll be greeted by a menu. Note that Radiation is currently hard-coded to open newly created posts in Vim. 

### Where do my Posts Get Saved to? 

They're always save and sound in `~/posts`. You can edit and/or delete them there. Afterward you're done editing or deleting posts, just run Radiation's publish command to publish those changes. 

Note: If you use git feel free to run `git init` in the posts directory. 

### Editing the Blog Template 

Radiation uses ERB for templating. If you don't know ERB, you can probably figure it out. Head on over to `radiation/lib/templates/blog.html.erb` and take a look. 

### How Do I Write CSS or JavaScript for my Blog?

The key here is that your template will look for files relative to `public_html/blog.html`. So if you put `<link rel="stylesheet" type="text/css" href="css/styles.css">` if the `blog.html.erb` template, it will look for a file at `public_html/css/styles.css`. Same thing goes for JavaScript-- I'd recommend createing a `js` directory folder at `public_html/js/` and then putting `<script src="js/app.js"></script>` in the head of your `blog.html.erb` template. 

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

Then you should be able to enter simply the word `radiation` from any directory and Radiation will run. When you quit Radiation you'll be returned to the directory you launched Radiation from.

### Need Help?

Radiation is super new and untested, so don't feel bad if it's fucking up. It's almost certainly not your fault! Hit me up [http://www.twitter.com/sts10](on Twitter) with any questions or ideas. 

### Hopefully Coming Soon

- Prettier Display of timestamp on posts
- Permalinks for each post.
- Pagination
- Support for multiple text editors
- Easier way to edit existing posts
- Export to JSON
- A way to save and store drafts

