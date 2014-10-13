# ☢ Radiation v 0.0.4 ☢

Radiation is a simple blog CMS for [totallynuclear.club](http://totallynuclear.club/) pages. 

### Installation

1. Clone this directory into `~/` (so it's next to your public_html directory). To do this, run `cd ~` and then `git clone https://github.com/sts10/radiation.git`
2. Next, you'll need to create a `posts` directory for your posts. This needs to be in `~/` as well. To do this, you can run `mkdir ~/posts`
3. By default, Radiation creates your blog at `~/public_html/blog.html`. If you have a file called blog.html in your public_html directory, Radiation will overwrite it. So if it's important to you, back it up somewhere safe! 

### Usage 

As of Radiation v 0.0.4, you're still going to need to `cd` into the `radiation` directory to use Radiation. To do this, you can just run `cd ~/radiation`.

Once you're in the `radiation` directory, simple run `ruby bin/runner.rb` to run Radiation. You'll be greeted by a menu. Note that Radiation is currently hard-coded to open newly-created posts in Vim. 

To edit posts just go into `~/posts` and edit the post you want to edit in whatever text editor you like. Then call Radiation and run the publish command from the menu. (Note the bugs section below though.)

### Where do my Posts Get Saved to? 

They're always save and sound in `~/posts`. You can edit and/or delete them there. Afterward you're done editing or deleting posts, just run Radiation's publish command to publish those changes. 

Note: If you use git feel free to run `git init` in the posts directory. 

### Editing the Blog Template 

Radiation uses ERB for templating. If you don't know ERB, you can probably figure it out. Head on over to `radiation/lib/templates/blog.html.erb` and take a look. 

### How Do I Write CSS or JavaScript for my Blog?

The key here is that your template will look for files relative to `public_html/blog.html`. So if you put `<link rel="stylesheet" type="text/css" href="css/styles.css">` in the `blog.html.erb` template, it will look for a file at `public_html/css/styles.css`. Same thing goes for JavaScript-- I'd recommend createing a `js` directory folder at `public_html/js/` and then putting `<script src="js/app.js"></script>` in the head of your `blog.html.erb` template. 

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

### Git Stuff

If you're really buying into Radiation's ability to re-create your blog from your posts directory whenever you want, and you have your `public_html` directory git initialized, you might want to consider gitignoring `blog.html`. 

### Need Help?

Radiation is super new and untested, so don't feel bad if it's fucking up. It's almost certainly not your fault! Hit me up [on Twitter](http://www.twitter.com/sts10) with any questions or ideas.

### Changelog

0.0.4
To solve the problem of not being able to store post creation times, I decided to store that information in the names of new posts when they are created. See `Post#create` for how that works. 

I then added two one-line methods to the `Post` model whose job it is to exact a datetime object from this filename, and a nicely-formatted version for printing to the blog.html. Both are called in the `Blog#compile`. Definitely could stand some refactoring, but I wrote how I saw it in my mind. 

Since newly-created posts now get their creation time put into the filename, in a way this version is a **breaking change** for older users. You'll need to either add the timestamp to your post filenames by hand, or re-create them using Radiate. Sorry about that. 

0.0.3 
I greatly simplified model structure. Where there was post_compiler and site_generator, etc. there are now only two models: `post` and `blog`. `blog`, a new model, has a simple method called `publish!` that re-writes the `blog.html` file from the posts directory, using the `blog.html.erb` template.

### Bugs!

- Post Creation Time bug has been fixed as of v 0.0.4. See Changelog for more information. 

### Hopefully Coming Soon

- Permalinks for each post.
- Pagination
- Support for multiple text editors
- Easier way to edit existing posts
- Export to JSON
- A way to save and store drafts

