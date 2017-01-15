### Introduction

When we push up our code changes to GitHub and the "Merge pull request" button
is grayed out, what do we do? We have covered handling merge conflicts on our
local machine in the past. In this lesson, we will cover what to do when we
introduce changes which cause merge conflicts with a remote repository.


### A familiar example.

We are going to revisit the [POROs repository](https://github.com/launchacademy/poros),
where we have a conflict with the master branch, which will not allow us to
merge our code via GitHub.

![Branch with conflicts](https://s3.amazonaws.com/horizon-production/images/branch-with-conflicts.png)

Oh no! What happened?

Usually, in a scenario like this, the `master` branch on GitHub has changed since
we started working on our branch. That's ok! This is exactly why tools like
`git` and GitHub exists.


### Getting out of a jam

The first thing we should do is go to our terminal, and get the most recent changes
to the `master` branch.

* `git checkout master`
* `git pull origin master`

The next step is to switch back to our branch, and merge in the changes from
`master`.

* `git checkout your-branch-name`
* `git merge master`

```no-highlight
$ git checkout nes-cart
Switched to branch 'nes-cart'

$ git merge master
Auto-merging spec/lib/nes_cartridge_spec.rb
CONFLICT (add/add): Merge conflict in spec/lib/nes_cartridge_spec.rb
Auto-merging lib/nes_cartridge.rb
CONFLICT (add/add): Merge conflict in lib/nes_cartridge.rb
Automatic merge failed; fix conflicts and then commit the result.
```

### Oh no! Conflicts!

If we look closely at the output from the `git merge master` command, we will
see the specific files which need to be corrected (Hint- look for the lines
prefixed with **CONFLICT**). We will have to open up these files in our editor
and fix the problems, manually.

```no-highlight
class NesCartridge
<<<<<<< HEAD
  attr_reader :title, :manufacturer, :year

  def initialize(title, manufacturer, year)
    @title = title
    @manufacturer = manufacturer
    @year = year
  end

  def to_s
    "#{title} by #{manufacturer} ©#{year}"
  end
=======
  attr_reader :title, :developer, :year

  def initialize(title, developer, year)
    @title = title
    @developer = developer
    @year = year
  end
>>>>>>> master
end
```

The key here is to look for the markers which indicate the differences in
branches which git cannot automatically resovle.

```no-highlight
<<<<<<< HEAD
# code in our branch
=======
# code in their branch
>>>>>>> master
```

There are a few different paths we can choose to fix this. If you are unsure,
just use option 1.

1. Manually edit the files, and save the changes.
2. Type `git checkout --ours filename`, if the changes in our branch are the
  only changes we want to keep.
3. type `git checkout --theirs filename`, if the changes in the master branch
  are the only changes we want to keep.

```no-highlight
class NesCartridge
  attr_reader :title, :manufacturer, :year

  def initialize(title, manufacturer, year)
    @title = title
    @manufacturer = manufacturer
    @year = year
  end

  def to_s
    "#{title} by #{manufacturer} ©#{year}"
  end
end
```

After saving our changes, we need to run the test suite (if available), or
test our code manually, then merge the changes, and push them up to GitHub.

```no-highlight
$ git add .
$ git commit -m "merge master"
[nes-cart 587986c] merge master
$ git push origin head
```

### Ready to Merge!

Now, when we look at our pull request on GitHub, we can see there are no
conflicts with the `master` branch, and, once our code has been reviewed,
we can easily merge our changes in via GitHub.

![Branch ready to merge](https://s3.amazonaws.com/horizon-production/images/branch-ready-to-merge.png)

### Wrap up

When you push your changes to GitHub, and you are unable to merge the changes,
follow the following workflow to make things right:

```no-highlight
$ git checkout master
$ git pull origin master
$ git checkout <your-branch-name>
$ git merge master
$ # fix any conflicts either manually or the via `checkout --ours/theirs`
$ git add .
$ git commit -m "merge master"
```

Take your time, and read the output for each command carefully as you go.
