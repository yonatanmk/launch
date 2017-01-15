### Introduction

Merging branches allows us to bring our changes into the master branch of a codebase. In this article, we will discuss how to merge two git branches, and resolve any conflicts that may arise.

### Learning Goals

* Merge changes between two branches
* Resolve a merge conflict

### Getting Started

Using the git repository we created in the [Git Branching](/lessons/git-branching) lesson,
let's create another branch off of master to start work on another feature B. Open up your terminal and follow along...

```no-highlight
$ git branch feature-b
$ git checkout feature-b
Switched to branch 'feature-b'

$ echo "this is for feature B" >> README
$ git add -A
$ git commit -m "Test commit for feature B"
[feature-b f287f09] Test commit for feature B
 1 file changed, 1 insertion(+)

$ git checkout master
Switched to branch 'master'
```

Here we've created and checked out a new branch, committed a change, and then switched back to *master*.

### Merging

At this point we should have three branches:

* *master* with only a single commit.
* *feature-a* with an additional commit on top of master.
* *feature-b* with an additional commit on top of master that is distinct from *feature-a*.

One way we can view this in Git is via the `git log` command which provides a wealth of options for displaying the history of a repository:

```no-highlight
$ git log --all --graph --abbrev-commit --decorate

* commit f287f09 (feature-b)
| Author: Adam Sheehan <a.t.sheehan@gmail.com>
| Date:   Thu Mar 12 14:48:02 2015 -0400
|
|     Test commit for feature B
|
| * commit 2da1894 (feature-a)
|/  Author: Adam Sheehan <a.t.sheehan@gmail.com>
|   Date:   Thu Mar 12 14:33:21 2015 -0400
|
|       Test commit for feature A
|
* commit 8b9c3d9 (HEAD, master)
  Author: Adam Sheehan <a.t.sheehan@gmail.com>
  Date:   Thu Mar 12 14:16:27 2015 -0400

      Initial commit
```

The output is a bit dense, but we have all three commits and how they're linked from the dashes along the side, as well as what each branch currently points to.

Branching wouldn't be very useful if we didn't have a way to bring these commits back to our main development branch (i.e. the *master* branch in this case). What we want to do now is to **merge** the feature branches back into the *master* branch.

Whenever merging branches, we're taking a separate branch and *merging it into the current branch*. Since we want to merge *feature-a* and *feature-b* into *master*, let's make sure we have the *master* branch checked out:

```no-highlight
$ git checkout master
```

Now we have to choose which branch we want to merge in. To merge in the *feature-a* branch, we can run the following command:

```no-highlight
$ git merge feature-a

Updating 8b9c3d9..2da1894
Fast-forward
 README | 1 +
 1 file changed, 1 insertion(+)
```

The `git merge feature-a` command brought any commits from the *feature-a* branch into *master*. If we check our *README* file we should see that it has been updated:

```no-highlight
$ cat README
this is from the first commit
this is for feature A
```

Checking our commit log we notice that the master branch contains the same commits as the *feature-a* branch:

```no-highlight
$ git log --all --graph --abbrev-commit --decorate

* commit f287f09 (feature-b)
| Author: Adam Sheehan <a.t.sheehan@gmail.com>
| Date:   Thu Mar 12 14:48:02 2015 -0400
|
|     Test commit for feature B
|
| * commit 2da1894 (HEAD, master, feature-a)
|/  Author: Adam Sheehan <a.t.sheehan@gmail.com>
|   Date:   Thu Mar 12 14:33:21 2015 -0400
|
|       Test commit for feature A
|
* commit 8b9c3d9
  Author: Adam Sheehan <a.t.sheehan@gmail.com>
  Date:   Thu Mar 12 14:16:27 2015 -0400

      Initial commit
```

Since we've merged in the changes from *feature-a*, both *master* and *feature-a* are identical. We no longer really have a use for the *feature-a* branch so we can go ahead and delete it at this point:

```no-highlight
$ git branch -d feature-a
Deleted branch feature-a (was 2da1894).
```

### Merge Conflicts

Now we have two branches left: *master* and *feature-b*. Let's go ahead and merge *feature-b* into *master*:

```no-highlight
$ git merge feature-b
Auto-merging README
CONFLICT (content): Merge conflict in README
Automatic merge failed; fix conflicts and then commit the result.
```

Now we've run into an issue. Both branches *feature-a* and *feature-b* included a commit that modified the same file in the same location (i.e. both added a second line to the README file). Which commit should be used to update the README? Should both lines be included or only one of them? If both, which order should they be added?

These are questions that Git cannot answer because Git doesn't assume anything about what the developers intended. Rather, Git notifies the user that there is a **merge conflict** and will pause the merge until it has been resolved.

We can check the status to view what files are in conflict:

```no-highlight
$ git status
On branch master
You have unmerged paths.
  (fix conflicts and run "git commit")

Unmerged paths:
  (use "git add <file>..." to mark resolution)

        both modified:   README
```

Here it indicates that both branches have modified the *README* file and that it cannot be merged as-is. What Git will do though is highlight the conflicting parts of a file and show what each side of the merge has changed:

```no-highlight
$ cat README
this is from the first commit
<<<<<<< HEAD
this is for feature A
=======
this is for feature B
>>>>>>> feature-b
```

Any parts of the file that have been modified by both branches will be marked using this format:

```no-highlight
<<<<<<< HEAD
any conflicting changes made by the current branch
=======
any conflicting changes made by the branch being merged
>>>>>>> branch-to-merge
```

At this point it is up to the developer to edit the file and clear up these conflicts. Open up the *README* file in any editor, delete the `<<<`, `===`, and `>>>` characters, and then choose which portions you want to keep from both branches. Assuming we want to keep the lines from both branches we can edit the file to resemble the following:

```no-highlight
this is from the first commit
this is for feature A
this is for feature B
```

We're still in a merge conflict though so we need to let Git know we're finished resolving the changes. Save this file and then add and commit:

```no-highlight
$ git add README
$ git commit -m "Merge feature-b"
```

Now we've successfully merged both feature branches back into *master*. We no longer need *feature-b* anymore so we can go ahead and delete that branch:

```no-highlight
$ git branch -d feature-b
Deleted branch feature-b (was f287f09).
```

If we look at the commit log we'll see that *master* now contains all of the commits we've made so far:

```no-highlight
$ git log --all --graph --abbrev-commit --decorate
*   commit 2162c57 (HEAD, master)
|\  Merge: 2da1894 f287f09
| | Author: Adam Sheehan <a.t.sheehan@gmail.com>
| | Date:   Thu Mar 12 15:24:43 2015 -0400
| |
| |     Merge feature-b
| |
| * commit f287f09
| | Author: Adam Sheehan <a.t.sheehan@gmail.com>
| | Date:   Thu Mar 12 14:48:02 2015 -0400
| |
| |     Test commit for feature B
| |
* | commit 2da1894
|/  Author: Adam Sheehan <a.t.sheehan@gmail.com>
|   Date:   Thu Mar 12 14:33:21 2015 -0400
|
|       Test commit for feature A
|
* commit 8b9c3d9
  Author: Adam Sheehan <a.t.sheehan@gmail.com>
  Date:   Thu Mar 12 14:16:27 2015 -0400

      Initial commit
```


### In Summary

Branches can be combined by **merging** them together. To merge another branch into the currently checked out branch, run the `git merge <branch_name>` command. This will merge the other branch into the current one.

If two branches have overlapping modifications, Git will issue a **merge conflict**. A merge conflict requires a developer to inspect the conflicting files and determine which changes to keep or discard.
