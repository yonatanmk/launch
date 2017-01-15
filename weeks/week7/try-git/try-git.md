### Introduction

GitHub's [Try Git](http://try.github.com/) is an excellent introduction to the git version control system. Git allows us to track the changes made to our codebase, or **repository**.
Think of it as a "save game" for our code.

### Learning Goals

* Learn the basics of using `git` on the command line
  - Initialize a new git repository with the `git init` command.
  - View tracked and untracked files with the `git status` command.
  - Use the `git add` command to add files to the "staging area".
  - Record our changes with the `git commit` command.
* View the history of a git repository with the `git log` command.
* Working with remote repositories
  - Adding remotes repositories
  - Pushing your changes to a remote repository.
  - Pulling changes to your local repository from a remote repository.
* Viewing line-by-line changes with the `git diff` command.
* Removing files from the "staging area" with the `git reset` command.
* Undo changes to a file with the `git checkout` command.
* Working with branches.
  - Creating branches.
  - Switching branches.
  - Merging branches.
  - Deleting branches.


### Instructions

Work through GitHub's interactive web tutorial "[Try Git](http://try.github.com/)". As you are working through the tutorial, make sure to carefully read the **Advice** section in each step. It gives you crucial information as to what each command does and definitions for unfamiliar terms.

Use the following cheat sheet for future reference.


### git Cheat Sheet

| Command | Description |
| ------- | ----------- |
| `git init` | Initialize a new git repository in the current directory. |
| `git status` | View tracked and untracked files. |
| `git add <filename>` | Add one or more files to the "staging area". |
| `git commit -m "message"` | Record the changes in "staging area". |
| `git log` | View the commit history. |
| `git remote add <remote_name> <remote_url>` | Add a new remote repository. |
| `git push origin master` | Push changes from your master branch to the remote origin branch. |
| `git pull origin master` | Pull changes from the remote origin repository to your local repository. |
| `git diff HEAD` | View the line-by-line changes since the last commit. |
| `git reset filename` | Remove a staged file. |
| `git checkout filename` | Reset the changes to a file to the last commit. |
| `git branch branch_name` | Create a new branch. |
| `git checkout branch_name` | Switch to a branch. |
| `git checkout -b branch_name` | Create a new branch and switch to it. |
| `git merge branch_name` | Attempt to merge a branch into the current branch. Conflicts may occur and will need to be resolved. |
| `git branch -d branch_name` | Delete a branch. |
