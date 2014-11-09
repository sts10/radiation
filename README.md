# ☢ Radiation v 0.2.0 ☢

Radiation is a simple blog CMS for [totallynuclear.club](http://totallynuclear.club/) pages. You can see a live example of a blog created with Radiation [on my page](http://totallynuclear.club/~schlink/#blog_header). 

### SPECIAL NOTE ON V 0.2.0

If you've upgrading Radiation from version 0.1.2 or lower I would recommend installing v 0.2.0 from scratch. v 0.2.0 has handles user settings much more cleanly and offers basic time zone support, however these changes were substantially enough that I recommend you start from scratch. 

This doesn't mean you'll lose your current posts or your radiation template! Remember `/radiation_posts` and `/radiation_templates` both sit out the `/radiation` directory where the application lives. 

To do this and upgrade to v 0.2.0, run `rm -rf ~/radiation`. Now run: 

```
git clone https://github.com/sts10/radiation.git ~/radiation; cd ~/radiation
```

and then run `ruby bin/runner.rb install`


# Getting Started

### Installation

**Step 1:** Clone this directory into `~/` by pasting the following into your terminal: 

```
git clone https://github.com/sts10/radiation.git ~/radiation; cd ~/radiation
```

then hit enter.

**Step 2:** Now paste or type this into your terminal `ruby bin/runner.rb` and hit enter. You should be asked if you'd like to setup Radiation. Answer in the affirmative!

You should be good to go! See the usage section below for how to use Radiation. 

_Note:_ By default, Radiation creates your blog at `~/public_html/blog.html`. If you have a file called blog.html in your public_html directory, Radiation will overwrite it. So if it's important to you, back it up somewhere safe! 

_Note 2:_ If you're upgrading from version 0.0.8 or lower of Radiation to v 0.1.0 or higher, you'll need to move your radiation posts from `~/posts` to `~/radiation_posts`. To do this, run `mv ~/posts ~/radiation_posts`.

### Usage 

As of Radiation v 0.2.0, running Radiation is still a little clunky.

From anywhere in your box you can run `cd ~/radiation; ruby bin/runner.rb`

You'll then be greeted by the main Radiation menu. 

From the main menu, you can choose optin `n` to create a new post. 
Currently you must write your new blog post **in HTML**. That means that each paragraphs should be wrapped in p tags or at least have < br >s between them. You'll also need to put a title for your post in the post. I'd recommend using an h2 tag.

Here's a quick example: 

```
<h2>Here's My Blog Post Title</h2>
<p>Here's the first paragraph of my new blog post</p>
<p>Here's another paragraph.</p>
<img src="URL">
```

Once you've saved your post, you then have to use the Radiation menu to "publish" your blog. Your new post should then be live.

**See section below on adding a `radiation` function to your `.bash_profile` if you want to make usage significantly easier.**

To edit posts you can use the 'e' option in the menu. Alternatively, you can go into `~/radiation_posts` and edit the post you want to edit in whatever text editor you like. 

When you're done editing, call Radiation and run the publish command from the menu. (Note the bugs section below though.)

### Editing User Settings

In the main menu you'll see option `s` for editing user settings. Here you can do things like set your local timezone (by default set to New York), change the text editor you use (I think on totally nuclear boxes there' sonly `vim` or `nano`), and change what file your blog gets printed to (default is `public_html/blog.html`). 

Just save this file and the new settings should be made immediately. 

### Where do my Posts Get Saved to? 

They're always safe and sound in `~/radiation_posts`. You can edit and/or delete them there as you would any `.html` file. After you're done editing or deleting posts, just run Radiation's publish command to publish those changes. 

Note: If you use Git feel free to run `git init` in the posts directory. 

### Editing the Blog Template 

Radiation uses ERB for templating. If you don't know ERB, you can probably figure it out. Once you've setup Radiation, you can head on over to `~/radiation_templates/blog.html.erb` and take a look at the sample template. 

You can change where Radiation finds its template in user settings (see above).

### How Do I Write CSS or JavaScript for my Blog?

The key here is that your template will look for files relative to `~/public_html/blog.html`. So if you put `<link rel="stylesheet" type="text/css" href="css/styles.css">` in the `blog.html.erb` template, it will look for a file at `~/public_html/css/styles.css`. 

Same thing goes for JavaScript-- I'd recommend creating a `js` directory folder at `~/public_html/js/`. You can then create a `.js` file there, like `apps.js` for example, and then put `<script src="js/app.js"></script>` in the head of your `blog.html.erb` template. 

### Changing Defaults 

Just use the `s - edit my user settings` option from the main menu to change the defaults that are available to change. To change other settings you'll have to dive into the code in `/radiation` itself. If you screw up, just `rm -rf` the radiation directory and re-install the latest version. 

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

To do this, first open your `.bash_profile` by running `vim ~/.bash_profile`. Now enter the function above. To do this you need need to first enter vim's "insert" mode by pressing `i`.

Once you've entered the function into your  bash_proifle, hit escape toe exit insert mode. Now save your `.bash_profile` with `:wq` in Vim's command mode. 

Finally,  once you're back in your terminal, run `source ~/.bash_profile` to refresh your bash profile.

Now you should be able to enter simply the word `radiation` from any directory and Radiation will run. When you quit Radiation you'll be returned to the directory you launched Radiation from.

### Git Ignore Suggestion

If you're really buying into Radiation's ability to re-create your blog from your posts directory whenever you want, and you have your `public_html` directory git initialized, you might want to consider gitignoring `blog.html`. 

### Why Do Posts and Templates Live Outside of the Radiation Directory?

If you use the setup command described in the installation instructions above, Radiation should give you the following directory structure:

```
~/public_html
~/radiation
~/radiation_templates
~/radiation_posts
```

The reason that both `/radiation_posts` and `/radiation_templates` sit outside of the `/radiation` directory is so that when users `git pull` a newer version of Radiation it doesn't overwrite their posts or their personalized `blog.html.erb` template.


### Does Radiation Work On Other Clubs like Tilde Club? 

To be honest I don't know! This is because I don't have a Tilde Club account so I can't test it. BUT judging by this [Tilde Club Primer](http://tilde.club/~anthonydpaul/primer.html) it looks like the directory structure of a fresh Tilde Club account is exactly the same as the directory structure for a fresh Totallynuclear Club account (i.e. in ~/ there's a `public_html` directory for things to go on your site). So if that's all true, then yes, Radiation should work for Tilde Club sites.
 
### Need Help?

Radiation is super new and untested, so don't feel bad if it's fucking up. It's almost certainly not your fault! Hit me up [on Twitter](http://www.twitter.com/sts10) or at schlink@totallynuclear.club with any questions or ideas.



# Development

### I Know Some Ruby/ERB/Shell. How Can I Help? 

Awesome! Radiation, as of v 0.1.0 at least, consists of 2 Ruby classes (or models), `post` and `blog`. These are located in the `lib`  directory. It then has a `runner.rb` which is what the user executes. `runner.rb` is in `bin`. 

**`bin/runner.rb` is a great place to start if you're new to the project.**

### Some things I could use help on:

#### RegEx

If you're good with Ruby and RegEx I need help with the `get_datetime_object` method in the `Post` class (`post.rb`). That method is supposed to take the filename string that is created in the `create` method above it and convert it into a DateTime object. Look at the corresponding code in the `compile` method of the Blog class (`blog.rb`) to get a better idea of what's going on. 

Currently I'm just shoving the full file_location, which a string that looks like `"../radiation_posts/2014-10-13T20+02+32-another-post.html"`, gsubbing the plus signs for colons, and then passing that beast into `DateTime.parse`. 

```ruby
def get_datetime_object(file_location)
  # I just shove the full file_location into DateTime.parse, with a gsub for the time colons, and it works like magic
  DateTime.parse(file_location.gsub('+', ':'))
end
```

Miraculously this worked in irb and it works in program currently, but it seems shaky to me. I'd rather have some reg ex magic in that method to extract `"2014-10-13T20+02+32"` from `"../radiation_posts/2014-10-13T20+02+32-another-post.html"`. Does that make sense? 

#### Installation Process

I really don't like how I currently require new users to paste that clunky bash function into their `.bash_profile`. 

I know there's a better way to have users install Radiation--something with the `ln` bash command and setting up an alias for `ruby bin/runner.rb`. I have tried to get this working a few times but can't quite figure out which paths to make relative and which to make absolute. Would love any hints/ideas on how to get this done. 

# Changelog

#### What's New in v 0.2.0

Time-zone support, thanks to a kernel of code [provided by ~erik himself](https://github.com/sts10/radiation/issues/3). Note that this 

#### What's New in v 0.1.1

Emergency bug fix for new posts created in first 9 days of a month. The day of the month was " 3" rather than "03" and the space was finding its way into the .html name, which caused a lot of problems. v 0.1.1 applies a fix where I use `%d` instead of `%e` in `post.rb`. 

#### What's New in v 0.1.0

Now saves new posts and pulls posts to publish from `/radiation_posts` rather than `/posts`. I made this change for name-spacing reasons-- in case users already have a directory at `~/posts`, and for symmetry of the naming structure. 

#### What's New in v 0.0.8

Added the ability to include permalinks. See the new sample blog template for implementation.

Also adds ability to edit ('e') a published post from the main menu.

#### What's New in v 0.0.7

`runner.rb` now only presents the main menu if it verifies that the user has:
1. a `~/posts/` directory 
2. a `~/radiation_templates` directory
3. and a file `~/radiation_templates/blog.html.erb`

If the user doesn't, it assumes the user is not setup. It then asks the user y/n if he or she would like to run the setup now. Also, the setup script does not replace you blog.html.erb template if one already exists in `~/radiation_templates`.

#### What's New in v 0.0.6 

File names of new posts are cleaned and formatted by a handful of lines of Ruby in class `Post`'s `create` method. 

Users can now use spaces, questions, marks, uppercase letters, etc and, most importantly, they can add the '.html' file extension or not. Either way, the string will downcased, no spaces or other weird characters, and with a clean .html extension by the time the `File.new` is executed. 

Also, users can now abort the creation of new posts by entering 'q' for the name of a new post.

#### What's New in v 0.0.5

Significant changes. 

1. the blog.html.erb template that Radiation actually uses now lives **outside** of the `radiation` directory, like the `posts` directory. This is primarily so that current users will be able to "upgrade" to new versions of Radiation and not lose their blog.html.erb template. 

2. Partially as a result of this change, I decided to write a script for new users to setup Radiation. See the installation section above for more information. 

#### What's New in v 0.0.4
To solve the problem of not being able to store post creation times, I decided to store that information in the names of new posts when they are created. See `Post#create` for how that works. 

I then added two one-line methods to the `Post` model whose job it is to exact a datetime object from this filename, and a nicely-formatted version for printing to the blog.html. Both are called in the `Blog#compile`. Definitely could stand some refactoring, but I wrote how I saw it in my mind. 

Since newly-created posts now get their creation time put into the filename, in a way this version is a **breaking change** for older users. You'll need to either add the timestamp to your post filenames by hand, or re-create them using Radiate. Sorry about that. 

#### What's New in v 0.0.3
I greatly simplified model structure. Where there was post_compiler and site_generator, etc. there are now only two models: `post` and `blog`. `blog`, a new model, has a simple method called `publish!` that re-writes the `blog.html` file from the posts directory, using the `blog.html.erb` template.


# Hopefully Coming Soon

- Smoother installation and usage processes. 
- Individual HTML pages for each post.
- Pagination
- Support for multiple text editors
- Easier way to edit existing posts
- Export to JSON
- A way to save and store drafts

