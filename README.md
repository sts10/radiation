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

Radiation is super new and untested, so don't feel bad if it's fucking up. It's almost certainly not your fault! Hit me up [http://www.twitter.com/sts10](on Twitter) with any questions or ideas.

### Bugs!

If you have two posts, first_post and second_post, second_post should be displayed on top on first_post since it's newer. Even if first_post is modified after second_post is created, second_post should still be on top, since I want then order in reverse chronological order by CREATION TIME. 

With this current version of Radiation that's not the case. When first_post is modified (and then the user publishes using Radiation) the first_post all of sudden sits on top of second_post. Clearly I'm getting modified time when I want created time. 

In `post_compiler.rb` I use `File.ctime` to try to get the time that a post was created (as opposed to modified, which I thought was `.mtime`). However when I go and modify an old post, then use Radiation to publish, the posts appear to be sorted in reverse order by MODIFIED time rather than created time. I like it so that you can go back and modify old posts without the posts on the blog re-ordering themselves. But like I said, I'm using `.ctime`. Not sure what the problem is.  

UPDATE: This seems to be a problem due to the fact that Mac's don't store creation time in `ctiem` for whatever reason. I did a  [Google search](https://www.google.com/webhp?sourceid=chrome-instant&ion=1&espv=2&ie=UTF-8#q=ruby+mac+creation+time+file&spell=1) but didn't find anything fool proof. Maybe [this](http://stream.btucker.org/post/65635235/file-creation-date-in-ruby-on-macs)? I'll play with it tomorrow hopefully.

### Hopefully Coming Soon

- Permalinks for each post.
- Pagination
- Support for multiple text editors
- Easier way to edit existing posts
- Export to JSON
- A way to save and store drafts

