### Introduction

If we are issuing a **pull request** on a code repository, we should expect to
get some feedback from the repository owner. If we are the owner of a repository,
and someone has taken the time to add some functionality to our codebase, we
should take a moment to give the contributor some feedback. Here are some
questions both parties should ask themselves when the time comes to perform a
**pull request review**.


### What makes a good Pull Request?

Some of the components of a well crafted PR are as follows:

* **It follows a style guide**. Either the style guide indicated by the
  repository, or, if there was none specified, the pull request follows the
  community style guide for the language. Take a moment to review the
  [Ruby community style guide](https://github.com/bbatsov/ruby-style-guide).

* **It follows conventions**. Is the code organized a certain way, with one
  class per file? Is there a test suite? We should try to follow the conventions
  laid out by previous developers.

* **It is well documented**. As contributors, we should take the time to describe
  our changes to the codebase in the notes of our PR, as well as document any
  changes in the README or a [changelog file](http://keepachangelog.com/).

* **It adds one feature**. Typically, we want to keep a pull request scoped to
  one singular feature. This might involve touching or creating multiple files.
  The main idea being that the collection of changes in the pull request are
  all related and relevant to the goal at hand.


### What makes a good Pull Request Review?

When leaving comments on a PR, we want to be careful of our tone. It's easy to
come off as mean and grating when asking someone to adhere to the "spaces over
tabs" convention. Here are some tips to follow when leaving a code review:

* Try to **use praise and criticism, equally**. Leave positive comments when you
  see something impressive, or learned about a method you didn't know before
  reviewing the PR. Be kind when leaving criticisms:

  > Could you please change the indentation level of your files to match the
  > convention of the Ruby style guide? After that, I would be happy to merge
  > your changes. Thank you!

* **Leave links to relevant documentation** if there is a better process or
  preferred way to do something. eg-

  > I see you are using an `.each` block to build a new array. Check out the
  > `.map` method. It's one of my favorite methods!
  > <http://ruby-doc.org/coreArray.html#method-i-map>

* **Leave clear and specific comments on what needs to be changed** so that the
  PR can be merged into `master`.

If you are the author of the pull request, make sure to follow the suggestions
of the repository owner and other members of your team. Make corrections and ask
clarifying questions. To make changes, simply make commits on the branch locally
and push your changes up to GitHub and they will show up on the PR.

Expect there to be some "back and forth" before your changes are merged.

Once the repository owner is happy with the changes in the pull request, they
should feel free to merge the branch into `master`.

[![Pull request review](https://s3.amazonaws.com/horizon-production/images/pull-request-review.png)](https://github-secret.herokuapp.com/question)


### Merge the pull request

The task of merging the PR is often the role of your project manager, or the
repository owner.

As the repository owner, when you are completely sure the PR is in its final
form and all the changes are ready to go into master, you can merge the pull
request!

To merge the PR, click the big green **Merge pull request** button.


### Make sure everyone has the new version of the code on `master`

Notify others working on the codebase to grab the latest changes. To do this,
navigate to the local master branch and type `git pull origin master`. It is
_very important_ to do this before creating a new branch, so that you are always
working with the latest revision of the codebase.

### Resources

* [Using Pull Requests - GitHub](https://help.github.com/articles/using-pull-requests/)
