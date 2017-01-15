### Introduction

One of the major benefits of Git is being able to have multiple people working
on different parts of a codebase at once, and using an organized system to
review each other's code and merge those changes together. This article will
walk you through the workflow you'll want to use in all future collaborative
work.

### Git branches

Git "branches" allow you to have different "versions" of your codebase,
simultaneously. You will have a clean, working version of your code in the
`master` branch. When you are ready to start a new feature, you will switch to a
new branch and start working. A branch off of master will sometimes be referred
to as a **feature branch**, since it will eventually contain all of the code
necessary implement a specific feature. Once you're sure the new feature is
working, the repository owner will merge those changes into the `master` branch.

When you have multiple people working on the same project, each person (or pair,
if you are pair programming) should working in a separate branch. Once the
feature is finished, the branch containing the changes can be pushed to the
remote repository on GitHub. Then, a _pull request_ should be made.

A pull request, or **PR**, is a way for you to tell other developers working on
the project that your work is ready to be merged into the `master` branch.
The phrase "pull request" can be thought of as "I am asking the owner of this
project to pull in my changes". A PR is a nicely-collected set of changes that
your team can review, and decide whether the changes are ready to be merged into
your the primary code base, your `master` branch.

### Basic Pull Request Workflow

First of all, let's get set up. We're going to have you clone a repo and set it
up on GitHub as if it was your own, so you can use it to practice making
branches and pull requests. To get set up, follow these steps:

1. Clone the repo with the following command:
  `git clone https://github.com/LaunchAcademy/poros.git`
1. `cd` into the directory that was created
1. Type `rm -rf .git`
1. Type `git init`
1. Visit [GitHub](https://github.com/) and create a new remote repository. Make sure to create the new repository _without_ a README
1. Copy the URL of the remote repo
1. Back in the command line, type: `git remote add origin <YOUR REMOTE REPO URL>`
1. Make the first commit: `git add -A`, `git commit -m "First commit"`
1. Push the master branch to GitHub (origin): `git push origin master`

When working collaboratively, each team member will clone down the repository.
However, **you should not delete the git folder**, as we did in the above
example. We are performing those steps here so that you have your own, separate
repository to work on.

You're now set up and ready to go! Let's get started with making our changes.

### 1. Make a branch

From here on out in your Launch Academy coding career, you will NEVER make
changes directly on the `master` branch again. All your future work should be
done on a separate feature branch! (...Saying "never" might be an slight
exaggeration, but that's the idea anyway!)

We are going to add a new **Plain-Old Ruby Object** to the repository.

Create a new branch in which to do your work, by typing
`git checkout -b add-puppy-poro`. From here on out, you can always change which
branch you're looking at by typing `git checkout branch-name`. This will update
the files as they are displayed in Atom to show you the version of your code as
it exists on the current branch. You can see a full list of what branches you've
made by typing `git branch`!

Make sure that you're on your new branch, then keep going.

### 2. Make some changes

Add the following code to the repository.

```no-highlight
# lib/puppy.rb

class Puppy
  attr_reader :name, :breed

  def initialize(name, breed)
    @name = name
    @breed = breed
  end

  def speak
    "#{name} says 'arf!'"
  end

  def to_s
    "#{name} is just a lil pup. He's a #{breed}."
  end
end
```


### 3. Commit your changes

`git add -A`

`git commit -m "Add the Puppy poro"`


### 4. Push your changes to the remote repo

`git push origin add-puppy-poro`


### 5. Make the pull request

Visit GitHub, and go to the remote repo. There should be a button near the top
that looks like this:

![Compare & pull request button](https://s3.amazonaws.com/horizon-production/images/compare-and-pull-request.png)

Click it! If you don't see that button, click the link at the top of the page
that says "# branches", then click the "New pull request" button next to your
branch.

Here, you can review all your changes before actually creating the pull request.
**Update the title** so that it accurately describes the changes in this branch.
Also, **update the description** to make sure others know what the changes you
made are all about. Scroll down to **review all of the changes** in this branch.

![Update title, description, review changes](https://s3.amazonaws.com/horizon-production/images/update-title-description-review-changes.png)

If you notice that anything's wrong, make some changes on your local branch,
commit, and push them to the remote repo. You will see your changes updated
on GitHub.

Once you're sure that the changes are just the way you want them, click "Create
pull request":

![Create pull request](https://s3.amazonaws.com/horizon-production/images/create-pull-request.png)

This will bring you to the page for your PR. You should now copy this link and
share it with your team to show them your work!


### Wrap Up

You made a **PR**! Now, inform your team members that there are new changes to
be reviewed.
