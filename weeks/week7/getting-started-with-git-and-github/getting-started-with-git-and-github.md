### Introduction

In this lesson, you will follow some step-by-step instructions in order to get
one of your code projects up on GitHub.

Much of the content from this article is taken from the following resource on
GitHub: <https://help.github.com/articles/set-up-git/>


### Instructions

##### Step 1. Check for git on your machine:

In the terminal:

```no-highlight
$ which git
```

If you get something along the lines of `/usr/local/bin/git` you have git,
otherwise download and set up latest version: go to
<https://help.github.com/articles/set-up-git/> and follow the instructions.

##### Step 2. Get a GitHub account and setup in terminal

Sign up for a GitHub account. Keep your email address and password in mind for
setting up your local dev environment. Note, this only has to be done once.

```no-highlight
$ git config --global user.name "YOUR NAME"
$ git config --global user.email "YOUR EMAIL ADDRESS"
```

##### Step 3. Go to directory you want to publish to GitHub

In terminal, go to the directory you want to put on GitHub. For example, if
you're publishing the Connect 4 Challenge to your GitHub account:

```no-highlight
$ cd ~/challenges/connect4
```

##### Step 4. Initialize git to start watching your directory

```no-highlight
$ git init
```

##### Step 5. Check the status of your directory

Any files not yet staged (or if this is not your first commit this will be all
files changed since last commit) will appear in red:

```no-highlight
$ git status
```

##### Step 6. Stage files

This can be one at a time, or if you're certain you want them all you can:

```no-highlight
$ git add .
```

##### Step 7. Review changes

To review your changes before committing via the command line you can run:

```no-highlight
$ git diff --staged
```

##### Step 8. Check your status again

You should see the files you've now staged in green

```no-highlight
$ git status
```

##### Step 9. Commit your changes

Include a message of what you've done in this commit with the `-m` flag:

```no-highlight
$ git commit -m "added a board class"
```

##### Step 10. Push up to GitHub

To push up to GitHub, go to your GitHub page and make a new repo

![alt](http://i.imgur.com/Ofc8pF3.png)


Then, follow the directions to push up to GitHub under `push an existing
repository from the command line`. This will be on the page after you've
created your directory:

![alt](http://i.imgur.com/APS0bX9.png)

For example:

```no-highlight
$ git remote add origin https://github.com/jennceng/example_repo.git  # run this once
$ git push -u origin master  # run this once
```

### Adding future changes

Let's say you have made some improvements to your code since you initially pushed
it up to GitHub. To get your new changes up on the interwebs, run the following
commands:

```no-highlight
$ git add .
$ git commit -m "A description of the changes that were made."
$ git push origin master
```

Now, when you visit your GitHub page, you should see these new changes.


### Wrap Up

Putting your code up on GitHub is an important step in becoming a developer.
GitHub allows us to share code with others and lets us contribute to Open-source
Software.
