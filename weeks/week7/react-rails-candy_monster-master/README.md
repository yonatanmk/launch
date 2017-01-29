### Candy Monster Clinic: Answering Your React-on-Rails Questions!

### Introduction to Candy Monster!

Candy Monster is an app built in Rails and React, allowing you to add information about the Valentine's Day candies you've consumed and loved (or hated).

You can view your consumed candies on the index page, where the list of candies has been built in React and the form for adding a new candy has been built in Rails. When you click on an image of a candy, you can navigate to the candy's show page, where the candy's information is displayed using a Rails ERB template and a React "Yum-o-meter" button allows you to set the candy's tastiness "score."

### How Do I Create a Rails API Endpoint?

We encourage you to namespace your API controllers.

In your `controllers` folder, you should create an `api` folder, a `v1` folder, and, finally, a `controller.rb` file within that. This helps keep your controllers organized, reminds you which ones are your API controllers, and allows you to store different versions of your API if need be.

Let's check out the Rails API endpoint for Candy Monster.

### How Do My Controller Actions Change?

Your API endpoint should only render JSON, allowing Rails & React to communicate & transmit data back and forth.

The Candy Monster app, like others, also requires non-API controller actions representing Rails views. In this case, Rails needs to use its `index` and `show` views to display the React components we've created.

This is also handy in case a user has JavaScript disabled on their browser, and you still want them to be able to view your site!

Pro-tip: Rails' Authenticity Token is used to prevent "cross-site request forgery (CSRF)" attacks. As an example, when you fill out a form for submitting a new candy to my app, Rails would _usually_ generate a hidden field storing the authenticity token, confirming with the server that the information is coming from Rails.

However, in this case, we're not _just_ communicating with Rails, we're also communicating with a React app on our front-end! In our API controller, it makes sense to add the line `skip_before_action :verify_authenticity_token`.

It's a good idea to use *strong params* in your API controller as well as in your regular controller.

### How Do I Build Different Pages in React?

First things first, create different Rails views with `div`s that have `id`s telling React where to render a component on that page. Easy peasy.

in index.html.erb:

```
<div id="main-list">
</div>
```

in show.html.erb:

```
<button type="button" class="button large" id="counter-button" data-id="<%= @candy.id %>"></button>
```

Well, that's great, you say. But how do I deal with rendering different ReactDOMs for different pages? I only have one `main.js` file, and it looks like this:

```
$(function() {
  ReactDOM.render(
    <Something />,
    document.getElementById('something')
  );
});
```

Avoid adding new entry points for additional `main.js`-like files to your `webpack.config.js`. Things can get complicated really fast. Instead, continue to use your `main.js` file as your overarching entry point for your React components, using conditional logic that looks for a particular `div` on the page and makes a particular `ReactDOM.render` call based on that:

```
$(function() {
  if (document.getElementById('main-list')) {
    ReactDOM.render(
      <CandyList />,
      document.getElementById('main-list')
    );
  };
  if (document.getElementById('counter-button')) {
    ReactDOM.render(
      <CounterButton />,
      document.getElementById('counter-button')
    );
  }
});
```

Don't forget to import everything you need into your `main.js` file.

### How can I use params-like logic in React?

Rails `params` are so nice. They're part of why convention over configuration is so awesome. They make it incredibly easy for us to grab form inputs, information from the URL about which page we're on, and so forth.

Let's say I'm on Candy Monster's show page for a candy, and I want to use the Yum-o-Meter button to send a Fetch request to update the **yum** points for that *specific* candy. I can see from the URL that the candy's ID is `5`, but React doesn't use `params` like Rails does. What can I do?

On the `div` on `show.html.erb`, where I'm rendering the CounterButton component, I can add a special attribute, `data-id`, and pass in the `id` for the ActiveRecord object from my non-API controller's `show` action.

Show action in controller:

```
def show
  @candy = Candy.find(params[:id])
end
```

Div/button on `show.html.erb` for rendering the CounterButton component:

```
<button type="button" class="button large" id="counter-button" data-id="<%= @candy.id %>"></button>
```

The super cool thing about `data-id` is that it translates into an object that JavaScript can understand! On the React side, from my CounterButton component, I can now use the following code to grab the Active Record object's ID:

```
let pageId = parseInt(document.getElementById('counter-button').dataset.id)
```

Let's break that down:

* `document.getElementById('counter-button')` grabs the element on the page with an ID of `counter-button`.
* I call `.dataset.id` to grab the ActiveRecord object ID that's been passed through `data-id`.
* The ActiveRecord ID is currently a string. To convert from string to integer, I use JavaScript's `parseInt` function.

I can then interpolate `pageId` into my Fetch call, as such:

```
fetch(`http://localhost:3000/api/v1/candies/${pageId}`)
```

### How Do I Troubleshoot?

A few tips from my own experiences...

* Always start simple and small. When building a component, make sure you can see it rendering "Hello World" before you add the complicated stuff. When making a Fetch request, put a `binding.pry` inside your controller action to ensure you're sending a request to the right endpoint, before adding anything else.
* Make tons of use of `binding.pry` and `debugger`, sometimes at the same time.
* When a React component all of a sudden doesn't render, it could be a typo. Seriously. React is kinda a drama queen when it comes to syntax. Look for missing semi-colons and extra curly braces.
* Test, test, test. Learn to read and understand test errors. They often offer clues to what could be going on.

### A Reminder

React is new! By learning it now, you're on the cutting-edge.

However, we understand there are plenty of frustrations that come with working with a new library that doesn't have set-in-stone conventions like Rails does. You'll also need to keep in mind that, since React is constantly and rapidly evolving, some of the stuff you'll see online, on Stack Overflow and such, is now out-of-date, even if it was posted relatively recently. So keep asking lots of questions, trying and failing and trying again, and just plugging along!


### Candy Monster: Basic Set-Up

```
git clone git@github.com:lilybarrett/candy_monster.git
cd candy_monster
bundle install
npm install
rake db:create && rake db:migrate && rake db:rollback && rake db:migrate && rake db:seed
```
