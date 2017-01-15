### Introduction

Branching in Git allows us to easily switch between multiple versions of a codebase. In this article we'll discuss why branching is useful and how we can branch and merge our changes from the command line.

### Learning Goals

* Commit changes to a separate branch
* View the differences between branches

### What is Branching?

One of the benefits of a version control system is the ability to store snapshots of a codebase at various points in time. In Git we can store these snapshots by creating [commits](/lessons/git-commit) that package up our changes and assign them labels so we can revisit them later.

After the first commit is created, every subsequent commit builds off the previous one. This forms a linear chain of commits that document the history of our project. To work with the latest version of our codebase we can look at the end of the chain.

This linear progression is great for ordering the history of a project, but there are times when we want to break out of this single chain of commits and have multiple **branches**. Rather than having every commit build on top of the next one, we can have multiple commits that build off the same starting point and go their own way.

Why would we want to start creating branches? One of the most common use cases is when multiple developers are working on the same project but on separate features. A developer will start with the latest version of the main development branch (often known as **master**) and create a new branch specific to their feature. Now they are free to work on their branch without interrupting (or being interrupted by) other developers committing to the master branch. When their feature is complete, they can **merge** their separate branch back into master.

Branches are useful even on projects with a single developer. Sometimes it is helpful to create a separate branch to experiment with some new feature that we're uncertain will be useful or feasible. Any commits to that feature will be specific to that branch and won't affect the master development branch. With branches, we can have several features in development simultaneously with minimal cost to switch between them.

### Creating Branches

To demonstrate how we can use branches, let's start with a simple Git repository containing one commit. Open up your terminal and follow along...

```no-highlight
$ mkdir branching-demo
$ cd branching-demo
$ git init
Initialized empty Git repository in ~/branching-demo/.git/

$ echo "this is from the first commit" > README
$ git add -A
$ git commit -m "Initial commit"
[master (root-commit) 8b9c3d9] Initial commit
 1 file changed, 1 insertion(+)
 create mode 100644 README
```

At this point we have a README file with a single line in it:

```no-highlight
$ cat README
this is from the first commit
```

Our initial commit was saved on the **master** branch by default. To view the list of branches we have available we can run the `git branch` command:

```no-highlight
$ git branch
* master
```

At the moment we only have a single branch named *master*. The asterisk next to the name indicates that this is the branch that we're currently working on.

Assuming we're about to start work on something we'll call feature A, let's create a new branch that will contain our changes:

```no-highlight
$ git branch feature-a

$ git branch
  feature-a
* master
```

`git branch feature-a` will create a new branch off of the current commit. When we run `git branch` we can see that there are two names now. Even though we've created a separate branch, we're still working off of *master* until we explicitly switch over.

### Switching Between Branches

To switch between branches we can use the `git checkout` command:

```no-highlight
$ git checkout feature-a
Switched to branch 'feature-a'

$ git branch
* feature-a
  master
```

Now we're currently on the *feature-a* branch. At this point both *feature-a* and *master* contain the same commits since we haven't made any changes since creating the branch. If there is a difference between two branches, Git will update any of the files after a checkout to reflect the state of the currently checked-out branch.

Let's make a change on our *feature-a* branch:

```no-highlight
$ echo "this is for feature A" >> README
$ git add -A
$ git commit -m "Test commit for feature A"
[feature-a 2da1894] Test commit for feature A
 1 file changed, 1 insertion(+)
```

We've updated the README file and sealed that in a commit. Now there is a difference between the *feature-a* branch and *master* which we can view using `git diff`:

```no-highlight
$ git diff master

diff --git a/README b/README
index 6bf2cdb..343ec2a 100644
--- a/README
+++ b/README
@@ -1 +1,2 @@
 this is from the first commit
+this is for feature A
```

This shows that the difference between our current branch and *master* is the one line added to the README. When we view the history of commits we'll see both of the commits we've made so far:

```no-highlight
$ git log --oneline
2da1894 Test commit for feature A
8b9c3d9 Initial commit
```

Let's switch back to *master* and see what it looks like there:

```no-highlight
$ git checkout master
Switched to branch 'master'

$ git log --oneline
8b9c3d9 Initial commit

$ cat README
this is from the first commit
```

Notice how when we run `git log` again we only get back our first commit. Our other commit still exists but it is currently on the *feature-a* branch. Also, the *README* file was updated to reflect our first commit.

### In Summary

Git **branches** allow us to work on separate features simultaneously and easily switch between them. They are an essential tool for collaboration between multiple developers and for experimenting with features before commiting them to the main development branch.

The `git branch` command will list the available branches on a repository. `git branch <branch_name>` will create a new branch with the given name starting from the current commit. To switch between branches, use the `git checkout <branch_name>` command.
