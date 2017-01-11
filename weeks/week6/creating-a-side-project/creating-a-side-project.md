This article will help inspire ideas for creating projects and how to best use your time and resources while you are here at Launch Academy.

## Learning Goals

* Get help thinking up a good side project
* Conceptualize what makes a good side project
* Outline how to approach a new side project

## Why Create a Side Project

Side projects are a great way to demonstrate what you have learned through Launch Academy but they also have other great benefits, such as:
  - growing a "portfolio" of code that you can speak to with prospective employers in the future that shows off your technology interests
  - having a collection of code examples you can refer back to in the future when remembering how to implement specific features or technologies
  - learning through exploring new concepts, languages, frameworks, libraries, etc. that you haven't yet tried
  - solving little inconveniences in your life. For example, you are coding all day and want to quickly know [what food trucks are near by for lunch?](https://github.com/radavis/food_trucks) These can show not only your technical skills but something about your interests which can be great for networking and making conversation in the future.

## What Makes a "Good" Side Project?

Any application of what you've learned through the Launch Academy curriculum or what you've been inspired or curious to learn about since you began you journey in programming can make a great side project. But how can you narrow that down?!

Choosing an idea for a side project or other app to showcase your skills is a tricky balancing act. You want to choose something that is sufficiently interesting to motivate you through the sucky/frustrating parts of application-building that happen to even seasoned pros, but also a project manageable enough to execute without becoming very overly discouraged.

Here's a list of example side projects from past Launchers to get your creative juices flowing!

  - Accomplish one simple task or serve one very specific need, such as [finding the nearest burrito.](http://burrito-locator.herokuapp.com/)
  - Educate people about something you're interested in, like [cats.](https://doyouknowcats.herokuapp.com/catfacts)
  - Show off creative interests, such as [magnetic poetry.](http://mag-poetry.herokuapp.com/)
  - Encourage people to collaborate on a common goal, like learning to [pair program.](http://launchpairpal.herokuapp.com/)
  - Organize important information so it's easy to access, like your cohorts [side projects.](https://github.com/bf86/app-directory)
  - Try a technology or process you haven't yet before, like creating your first [ruby gem.](https://github.com/bf86/chill)
  - Create a simple game for a single user or for groups of people to play, take [trivia to the next level.](https://github.com/rakkofat/launch-trivia-local)
  - Create something new from something already out there, like integrating with a API to [share fun gifs](http://story-time-gifs.herokuapp.com/index?page=0)

While the creative possibilities are endless, what makes a "good" side project at this stage in your career as a developer should be simple and centered around one or two learning objectives that you'd like to practice.

## How to Start a New Project

Learning how to organize your process when starting a new project is an important skill. Below are some tips to help you get started.

### Make a "dream list" and a "do it now" list

When planning your app, you're going to have a lot of big crazy awesome ideas - which is super fun. Store those ideas somewhere. Every time you think of a new feature, write it down on that "dream features" list.

<p align="center">
  <img alt="Carlton is getting dreamy about his new Rails app!" src="https://media.giphy.com/media/P8MxmGnjmytws/giphy.gif">
</p>

Once you have your "dream list" fleshed out with all the ideas that have been floating around in your head, ask yourself, "What is the core functionality of my app?" and "What are the features I need before I'm happy sharing this with friends?" Those questions should help you narrow down where to start.

For actually starting, you need to narrow down your dream features list to a core subset and not let yourself develop beyond those user stories until are all meeting your expectations.

## Think Lean and a Brief Interlude on Not Getting Lost in the Weeds
As an aside to the topic of planning a project, one major school of thought in the software industry is that of [Lean software development.](http://leanstartup.co/) Lean philosophy has 7 principles:

- Eliminate waste
- Amplify learning
- Decide as late as possible
- Deliver as fast as possible
- Empower the team
- Build quality in
- See the whole

It's important to be familiar with these principles, since many teams that you may work on in the near future will use them to guide development. Lean is particularly relevant in startups and small to mid-size companies where bootstrapping and quick iteration are crucial for time-to-market and survival.

Eliminating waste is most applicable to your situation when building a small app to show your skills in a dramatically compressed sprint of two weeks. You provide enormous value to both yourself in this scenario (but also in the future to a company) when you know how to drill down what is absolutely necessary to create a feature and do not get mired in the weeds of unnecessary optimizations and gold-plating.

For example, if you are trying to create a user interface that allows someone to send an invite to another user to join their "team," the first solution that comes to your mind should **not** be an auto-filling form that leverages a React.js module to provide instant feedback on the page. It's awesome if you add this later, but the minimum thing you need to do is make a form that takes an email address, and then do some logic to send an invite. Focus on the minimum amount of code to get the job done, and then later flesh out that skeleton with beautiful interface touches and thoughtful integrations.

You should prioritize what is absolutely needed to make your app do what you say it will do, and nothing more until that is accomplished. One great way to stay Lean is to practice "time boxing." This means that you will set aside a maximum amount of time to pursue a non-core problem, and then move on if you cannot solve the problem in that amount of time. A good time box is about 30 minutes to an hour. Just like we encourage you to ask us for help when you get stuck for 15 minutes or more, you shouldn't spin your wheels on something for so long that your overall productivity suffers.

## ER Diagrams

Every project should begin with an ER Diagram, or a Entity Relationship Diagram. You need to understand what objects or tables you need, and how they relate to one another. Your ER diagram should represent the current (or very-soon-to-be) reality of your database schema. This is your do-it-now list.

Avoid trying to have an ER diagram that attempts to "plan everything" up front. There is a balancing act between doing some amount of architectural thinking/planning and "over engineering" by trying to design the whole thing up front.

A quick reminder on how to do this:
- Draw a box for each table you plan on having in your database
- Inside each box, write the name of the database table, and list each column name you plan on having in the table
- Draw lines between the tables that are connected to each other. (i.e, the character table and a table that has a column for character_id are connected.)

Possible tools:

- [Google Drawings](https://support.google.com/docs/answer/179740?hl=en)
- [Draw.io](https://www.draw.io/) (free and... ok)
- [Lucidchart](https://www.lucidchart.com/) (nicer but not free, 30-day free trial)
- Whiteboard and Photo, or Pen and Paper (this works just fine; take a picture!)

## User Stories and Acceptance Criteria

Now that you have a general idea for a core starting point, time to hash out what exactly that means. One common approach is to make a user story and set of acceptance criteria for each feature you plan on developing.

[User stories](https://twitter.com/goatuserstories?lang=en) describe what value a feature brings to a user. The idea is to not go into implementation details at all, just keep it very general and based on what the user wants to accomplish by using the feature. They are structured like this:

```
As a... <some kind of user of your site>
I want to... <do something with your site>
So that... <some user goal is achieved>
Here are a couple examples:

As a user
I want to submit links to my favorite songs
So that I'm able to share my awesome music finds with my friends.

As a user
I want to see a list of favorite songs submitted by my friends
So that I'm able to discover new good music that's been vetted by my friends.

As an admin
I want to delete a song off of the list of favorite songs
So that I'm able remove inappropriate content.
Acceptance Criteria:
```

User stories don't go into implementation details - **that's what acceptance criteria are for**. This is a list of implementation details that you consider necessary for a feature to be considered complete. Usually, each user story has a set of acceptance criteria to further describe it. Here's an example:

```
As a user
I want to submit links to my favorite songs
So that I'm able to share my awesome music finds with my friends.

[ ] I can visit "/songs/new" and view a form to submit a new song
[ ] I must fill out "Title", "URL", and "Rating" to submit a new song
[ ] I can optionally fill out "Description" when submitting a new song
[ ] "Rating" must be a number between 1 and 5
[ ] If any required fields aren't properly filled out when I try to submit the form, I get a descriptive error message and remain on the page.
[ ] If I submit a successfully filled-out form, I get redirected to "/songs" and can see my new song on the list.
```

## Wireframing (Optional)

<p align="center">
 <img alt="wireframe example with balsamiq" src="https://s3.amazonaws.com/horizon-production/images/qBALeUA.png">
</p>

Now that you have an idea of what pages and features you'll have for starters, it can be helpful to sketch out what you want the pages to look like. This isn't always necessary - often you'll have a fine time just visualizing it in your head or making up the page layout as you go along. However, some people always like to wireframe, and for particularly complicated pages it can be very useful.

Balsamiq is one tool you can use to easily create page layouts! There are others too, and you can also just sketch them by hand. They don't need to be beautiful, just show generally where things should fall on the page. If you are going the sketching route you can always snap a quick picture.

## Write ONE Feature Test

<p align="center">
  <img alt="Testing makes your life easier." src="https://media.giphy.com/media/yR4xZagT71AAM/giphy.gif">
</p>

You will stress yourself out and lose clear sight of your direction if you go writing all your feature tests at once. Pick out one feature (one user story, one set of acceptance criteria) and start with that. It is a good idea to put the user story and acceptance criteria right in the test file:

```
# /spec/features/user_submits_new_song_spec.rb

require 'spec_helper'

feature "User submits new song", %(

  As a user
  I want to submit links to my favorite songs
  So that I'm able to share my awesome music finds with my friends.

  [ ] I can visit "/songs/new" and view a form to submit a new song
  [ ] I must fill out "Title", "URL", and "Rating" to submit a new song
  ...
  ...

%) do

  # scenarios go here

end

```

Note that every acceptance criteria should end up being tested but we do not need a separate acceptance criteria for each test. As long as your tests wouldn't pass if an acceptance criteria was not being fulfilled, we're okay.

Now it's time to actually write the tests!

Start by just writing one or two scenarios. You can flesh out what you want the other ones to be by writing them into the file, but leave them empty for now.

## TDD Off Into the Sunset

Let your tests drive the development of your feature! Early on you'll run into the problem that you don't currently have a table set up in your database, but let the tests tell you when to create that.

Workflow should go:

"Oh, my tests say I don't have that table set up yet. That makes sense, since I don't."
"Let's write some unit tests to test-drive my creation of that model or class."
*...tdd model or class via unit tests...*
"Yay, now I have my model or class, let's see what the next error is in my feature test"

## Pick a New User Story, and Do It Again!

Every green test is one step closer to a cool app that you can be proud of and show off on your GitHub profile and to your family and friends! You're a star.
