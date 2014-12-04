# ☢ Radiation v 0.3.85 ☢

Radiation is a simple blog CMS for [totallynuclear.club](http://totallynuclear.club/) pages. You can see a live example of a blog created with Radiation [on my page](http://totallynuclear.club/~schlink/#blog_header). 

### What is Radiation? What Does it Do?

Radiation is a CLI (command line interface) that allows users to create, edit, delete and publish blog posts to an HTML file (like `public_html/index.html` for example). Users can write posts in either HTML or Markdown. Radiation also gives each post a timestamp and a permalink that makes sharing easier. 

Radiation was developed for use with [totallynuclear.club](http://totallynuclear.club/) sites, but I think it will work with other .club sites (see note below) or any situation where someone wants to produce a static HTML file with many posts. 

Radiation is written in Ruby and is (of course) totally open source. If you have ideas for improvements we'd love to hear them! Just submit a GitHub issue. 

### Upgrading Radiation

If you already have Radiation installed and want to upgrade to the current version, even if your version is just one iteration old, I strongly recommend doing a complete re-install. When you re-install Radiation you won't lose your current posts or your radiation template! That's because in v 0.3.X `/radiation_posts` and `/radiation_templates` both sit outside the `/radiation` directory where the application lives. 

To re-install Radiation, first uninstall it by running `rm -rf ~/radiation`. Now follow the NEW installation instructions below. 

# Getting Started With Radiation

### Installation

**Step 1:** Clone this directory into `~/` by pasting the following into your terminal: 

```
git clone https://github.com/sts10/radiation.git ~/radiation; cd ~/radiation
```

then hit enter.

**Step 2:** Now paste or type this into your terminal `ruby bin/install.rb` and hit enter. This may take a second. 

**Step 3:** Now paste or type `ruby bin/runner.rb` and hit enter. You should be asked if you'd like to setup Radiation. Answer in the affirmative!

You should now be good to go! See the usage section below for how to use Radiation. 

_Note:_ By default, Radiation creates your blog at `~/public_html/blog.html`. If you have a file called blog.html in your public_html directory, Radiation will overwrite it when you publish your blog for the first time. You can either move your old blog.html somewhere else, or change where your Radiation blog is printed to in your user settings (see below)

_Note 2:_ If you're upgrading from version 0.0.8 or lower of Radiation to v 0.1.0 or higher, you'll need to move your radiation posts from `~/posts` to `~/radiation_posts`. To do this, run `mv ~/posts ~/radiation_posts`.

### Basic Usage 

#### Running Radiation
As of Radiation v 0.3.x, running Radiation is still a little clunky.

From anywhere in your box you can run `cd ~/radiation; ruby bin/runner.rb`. You'll then be greeted by the main Radiation menu. 

**See section below on adding a `radiation` function to your `.bash_profile` if you want to make usage significantly easier.**

#### Creating a New Blog Post 
From the main menu, you can choose option `n` to create a new post. 

You'll then be given a choice of whether you want to write this new post in HTML or [Markdown](http://daringfireball.net/projects/markdown/).

If you choose to write HTML, here's a quick example of what it should look like: 

```
<h2>Here's My Blog Post Title</h2>
<p>Here's the first paragraph of my new blog post</p>
<p>Here's another paragraph.</p>
<img src="URL">
```

If you choose to use [Markdown](http://daringfireball.net/projects/markdown/), know that Radiation uses GFM or GitHub flavored Markdown. Multi-line code blocks should be delineated with triple backticks (\`\`\`). You can also specify a programming language for syntax highlighting. 

#### Publishing Your New Blog Post
Once you've saved your post in your text editor and quit your text editor, you'll be asked if you want to publish your changes. If you enter 'y', your blog will be published and your new post should be live in a few seconds. If you select 'n', your post will be saved but not pushed to your blog. 

#### Editing Posts
To edit posts you can use the 'e' option in the menu. Alternatively, you can go into `~/radiation_posts` and edit the post you want to edit in whatever text editor you like. 

When you're done editing, run Radiation and run the publish command from the menu. 

#### Managing Drafts
Thanks to [gunnarhafdal](https://github.com/gunnarhafdal), Radiation v 0.3.6+ supports drafts. A draft is simply a post that Radiation will save for you but won't publish. 

To save a post as a draft, simply make the first line of the post the word "draft". Posts marked in this way won't be published. However you will be able to access them in the edit menu (described above). To publish a draft, simply edit the draft, remove the word "draft" from the first line, and publish your blog. 

If you'd like to update the timestamp on your post (say before publishing a draft you've been work on for a while), use the `u` option from the main menu. This will change the post's timestamp to the current time in your specified timezone. 

### Making Radiation Easier to Run by Editing Your Bash Profile

As you may have noticed, entering `cd ~/radiation; ruby bin/runner.rb` every time you want to run Radiation sucks. So let's make it so you can just type `radiation` and hit enter from any directory and Radiation will launch. 

To add a radiation function to your bash_profile, simply use the `b - Add radiation function to your bash_profile` option in the main menu (if you don't see that option, see below). It will ask you to confirm. 

**NOTE: You only want to do this once! Even if you remove radiation this function will still be in your bash_profile.**

FYI This menu option adds the following function to the end of your bash_profile:

```
function radiation {
    cwd=$(pwd)
    cd ~/radiation
    ruby bin/runner.rb
    cd $cwd
}
```

If you do not see option `b - Add radiation function to your bash_profile` in your Radiation main menu, that means you already have a function called `radiation` in your bash_profile. You most likely do NOT want to add another one, but Radiation will let you if you confirm. Either way, at this point you'll want to see what's going on in your bash_profile by running `vim ~/.bash_profile`.

### Editing User Settings

In the main menu you'll see option `s` for editing user settings. Here you can do things like set your local timezone (by default set to New York), change the text editor you use (I think on totally nuclear boxes there's only `vim` or `nano`-- default is `vim`), and change what file your blog gets printed to (default is `public_html/blog.html`). 

Once you make your changes, save the file and then restart Radiation for the changes to take effect.

### Where do my Posts Get Saved to? 

They're always safe and sound in `~/radiation_posts`. You can edit and/or delete them etiher through the Radiation menu or in that directory as you would any file. After you're done editing or deleting posts, just run Radiation's publish command to publish those changes. 

Note: If you use Git feel free to run `git init` in the posts directory. However this is certainly not necessary. 

### Editing the Blog Template 

Radiation uses ERB for templating. If you don't know ERB, you can probably figure it out. Once you've setup Radiation, you can head on over to `~/radiation_templates/blog.html.erb` or use the `t` option in the main menu and take a look at the sample template. 

You can change where Radiation finds its template in user settings (see above).

### How Do I Write CSS or JavaScript for my Blog?

You obviously can write both CSS and JavaScript for your blog. If you want to write CSS or JavaScript in external files (`.css` and `.js` respectively), that's totally cool. Let go over where you'd put those files: 

The key here is that your template will look for files relative to `~/public_html/blog.html`. So if you put `<link rel="stylesheet" type="text/css" href="css/styles.css">` in the `blog.html.erb` template, it will look for a file at `~/public_html/css/styles.css`. 

Same thing goes for JavaScript-- I'd recommend creating a `js` directory folder at `~/public_html/js/`. You can then create a `.js` file there, like `apps.js` for example, and then put `<script src="js/app.js"></script>` in the head of your `blog.html.erb` template. 

### Changing Your Radiation Settings 

Just use the `s - edit my user settings` option from the main menu to change the defaults that are available to change. If you ever want to restore the default user settings, just choose the `r` option in the main menu.

To change other settings you'll have to dive into the code in `/radiation` itself. If you screw something up, no worries-- just `rm -rf` the radiation directory and re-install the latest version. 

### Why Do Posts and Templates Live Outside of the Radiation Directory?

Once you allow Radiation to set itself up, as described in the installation instructions above, Radiation will have the following directory structure:

```
~/public_html/
~/radiation/
~/radiation_user_settings.rb
~/radiation_templates/
~/radiation_posts/
```

The reason that `/radiation_posts/`, `/radiation_templates/`, and `/radiation_user_settings`  sit outside of the `/radiation` directory is so that when users re-install Radiation or update to a newer version of Radiation it doesn't overwrite their posts, their personalized `blog.html.erb` template, or their user settings


### Does Radiation Work On Other Clubs like Tilde Club? 

To be honest, I don't know yet! This is because I don't have a Tilde Club account so I can't test it. BUT judging by this [Tilde Club Primer](http://tilde.club/~anthonydpaul/primer.html) it looks like the directory structure of a fresh Tilde Club account is exactly the same as the directory structure of a fresh Totallynuclear Club account (i.e. in `~/` there's a `public_html` directory for things to go on your site). So if that's all true, then yes, Radiation should work for Tilde Club sites.
 
### Need Help?

Radiation is super new and untested, so don't feel bad if it's fucking up. It's almost certainly not your fault! Hit me up [on Twitter](http://www.twitter.com/sts10), at sschlinkert ]at[ gmail, or at schlink@totallynuclear.club with any questions or ideas.



# Development

### I Know Some Ruby/ERB/Shell. How Can I Help? 

Awesome! Radiation, as of v 0.2.2 at least, consists of 3 Ruby classes (or models), `Post`, `Blog` and `Time`. These are located in the `lib`  directory. `Time` just adds a method to the Time objects for setting the user's timezone from the user_settings file. The meat of the app is in the `Post` and `Blog` models.

It also has a `runner.rb` which is what the user executes. `runner.rb` is in `bin`. 

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

I really don't like how I currently require new users to paste that clunky bash function into their `.bash_profile`, even if I have partially automated the process for users. 

I know there's a better way to have users install Radiation-- something with the `ln` bash command and setting up an alias for `ruby bin/runner.rb`. I have tried to get this working a few times but can't quite figure out which paths to make relative and which to make absolute. Would love any hints/ideas on how to get this done. 

# Changelog

#### What's New in v 0.3.8

Improved handling of completely blank posts. Now you can call the edit menu and a completely blank post won't cause Radiation to error out. This is hopefully a successful attempt at solving [this issue](https://github.com/sts10/radiation/issues/10) submitted by [cena](https://github.com/cena).

#### What's New in v 0.3.7

I've merged another one of [gunnar](https://github.com/gunnarhafdal) pull requests! Users can now update the timestamp on a post to the current time (in their specified timezone). This involves some nice splitting methods that gunnar wrote in order to rename the post's filename. So cool to have outside help, and from folks I've never met, living on a different continent! 

[Read my blog post on this version](http://totallynuclear.club/~schlink/#2014-12-02T16+45+13-radiation-v-036-draft-support)

#### What's New in v 0.3.6 

Draft support from new contributor [gunnar](https://github.com/gunnarhafdal). Reads first line of all posts to see if the first line is the word "draft". Knows not to publish these posts, and to label them as posts in all menus. 

#### What's New in v 0.3.5 

Added `<div class="post_content">` wrapper around the post content in the sample template. 

Also gsubbed out smart ellipses in blog model. 

#### What's New in v 0.3.4 

Changed the HTML-or-Markdown choice to use 'h' or 'm', rather than 1 or 2, which fits with the main menu better.

I also altered the sample ERB template so that the post title is used as the post div's id and not the "name" of the date a tag. This just makes more semantic sense and allows for easier CSS manipulation. 

#### What's New in v 0.3.3

Adds a new menu option to delete posts. This required a new method and some refactoring in `blog.rb`, in addition to adding the new menu choice in the ever-expanding `runner.rb`. 

I really don't like that `runner.rb` is at 300 lines, but it seems to be working at this point. 

[Read my blog post on this version](http://totallynuclear.club/~schlink/#2014-11-11T16+20+22-radiation-033)

#### What's New in v 0.3.2

Added a new main menu option "b - Add radiation function to your bash_profile" that appends a simple BASH function to the user's bash_profile for calling radiation from anywhere in their box. Some nifty `.grep` use makes it difficult for users to add the function multiple times. 

#### What's New in v 0.3.1

Replaces semi-colons, colons, and parentheses in new post titles. Also no longer errors when trying to publish a blank Markdown post. 

### What's New in v 0.3.0

Another big improvement to how Radiation handles user settings. User settings are now stored in a file outside of `~/radiation`, just like `/radiation_posts` and `/radiation_templates` do. The purpose is so that when users re-install Radiation or update to a new version using `fit pull`, their user settings are preserved. 

You can get a good idea of how this works by looking at `config/environment.rb`

[Read my blog post on this version](http://totallynuclear.club/~schlink/#2014-11-10T18+08+45-radiation-030)

#### What's New in v 0.2.3

Display version number in main menu logo. Also better main menu user flow all around, including more screen clears (thanks to [bobbylama](https://github.com/bobbyllama/) for the idea). 

The Edit post menu now offers a 'q' option to return to main menu. Also, users are explicitly asked after saving a new post or editing a published one whether they would like to publish. 

#### What's New in v 0.2.2

Adds Markdown support using the kramdown Ruby gem. I also created a `/bin/install.rb` as a ghetto bundler installation. This is because Radiation now requires 3 Ruby gems not included with Ruby. 

Users now can choose, when creating a new post, whether they want it to be HTML or Markdown. the Markdown flavor if GFM, or GitHub flavored. Code blocks are delineated with triplet backticks, and syntax highlighting is supported through coderay. 

**NOTE:** Posts created in older versions of Radiation will still render in HTML, because the post file extension is `.html`. Also, users can continue to write posts in HTML by simply choosing HTML every time they create a new post. 

[Read my blog post on this version](http://totallynuclear.club/~schlink/#2014-11-09T22+46+58-v-022-with-markdown-support)

#### What's New in v 0.2.1

As per [a comment by bobblyllama](https://github.com/sts10/radiation/issues/3#issuecomment-62322602), v 0.2.1 allows user to not specify a timezone in their user_settings.

#### What's New in v 0.2.0

Time-zone support, thanks to a kernel of code [provided by ~erik himself](https://github.com/sts10/radiation/issues/3). Note that this is a pretty big update in that Radiation now uses a `user_settings.rb` file for 4 important settings that users can change, including timezone. For this reason, if upgrading from v 0.1.x to v 0.2.x that you un-install and re-install Radiation as per the note on top of this README. 

[Read my blog post on this version](http://totallynuclear.club/~schlink/#2014-11-09T14+13+30-radiation-020)

#### What's New in v 0.1.1

Emergency bug fix for new posts created in first 9 days of a month. The day of the month was " 3" rather than "03" and the space was finding its way into the .html name, which caused a lot of problems. v 0.1.1 applies a fix where I use `%d` instead of `%e` in `post.rb`. 

[Read my blog post on this version](http://totallynuclear.club/~schlink/#2014-11-04T04+40+44-test-post)

#### What's New in v 0.1.0

Now saves new posts and pulls posts to publish from `/radiation_posts` rather than `/posts`. I made this change for name-spacing reasons-- in case users already have a directory at `~/posts`, and for symmetry of the naming structure. 

[Read my blog post on this version](http://totallynuclear.club/~schlink/#2014-10-21T20+27+04-v-010-a-working-product)

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

[Read my blog post on this version](http://totallynuclear.club/~schlink/#2014-10-14T00+14+16-radiation0-0-5)

#### What's New in v 0.0.4
To solve the problem of not being able to store post creation times, I decided to store that information in the names of new posts when they are created. See `Post#create` for how that works. 

I then added two one-line methods to the `Post` model whose job it is to exact a datetime object from this filename, and a nicely-formatted version for printing to the blog.html. Both are called in the `Blog#compile`. Definitely could stand some refactoring, but I wrote how I saw it in my mind. 

Since newly-created posts now get their creation time put into the filename, in a way this version is a **breaking change** for older users. You'll need to either add the timestamp to your post filenames by hand, or re-create them using Radiate. Sorry about that. 

#### What's New in v 0.0.3
I greatly simplified model structure. Where there was post_compiler and site_generator, etc. there are now only two models: `post` and `blog`. `blog`, a new model, has a simple method called `publish!` that re-writes the `blog.html` file from the posts directory, using the `blog.html.erb` template.

#### v 0.0.2

[Read my blog post on this (very early) version](http://totallynuclear.club/~schlink/#2014-10-12T17+22+12-hello_world)

# Hopefully Coming Soon

- Smoother installation and usage processes. 
- Individual HTML pages for each post.
- Pagination
- Export to JSON


