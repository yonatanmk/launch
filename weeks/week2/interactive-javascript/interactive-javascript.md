### Introduction

As the web grew in complexity and popularity, more and more dynamic elements
were required on behalf of the browser. People wanted animation, movement, even
video. HTML is adequate at describing static elements, but has no concept of
moving those elements across a page, even in a repeatable fashion.

Moreover, the HTTP response-request cycle hamstrings any attempt at movement.
Each step would have to come as another response from the server, and then would
have to request from the server the next step. Each response would have to
contain all of the HTML for the site, making this a costly exercise that
seriously undermines the user experience.

What developers wanted was a way to send _instructions_ along with the HTML.

JavaScript was created to solve this problem. JavaScript is a language that was
made to manipulate HTML and provide some in-browser processing of the user
experience, instead of relying entirely on the server (and therefore the HTML
limitations of request/response). Despite the name, it bears no relation to
`Java`, a popular object-oriented programming language.

Until recently, JavaScript was based entirely around the browser. With an
increased focus on front-end user interface design _and_ the creation of new
software to allow JavaScript to be run on a web server, JavaScript is gaining
more and more popularity.

### Finding HTML with JavaScript

In the browser, JavaScript was created to modify and manipulate HTML. It does
this by reading the HTML and creating something called the _Document Object Model_
(or _DOM_). If a Web Page is how we humans interpret HTML, the DOM is how
JavaScript interprets it.

The DOM represents HTML in terms of a strict hierarchy of elements. HTML that
looks like this:

```html
<html>
  <head>
    <title>You can see me in the title bar!</title>
  </head>
  <body>
    <div class="top-matter">
      <h1 id="headline"> Welcome to my Website! </h1>
      <p>Hello, World!</p>
      <p class="byline">Hello, World!</p>
    </div>
  </body>
</html>
```

Will be rendered into a DOM structure, similar to this:

```no-highlight
document
-head
  |-title
-body
  |-div.top-matter
    |-h1#headline
    |-p
    |-p.byline
```

Executing JavaScript code can then write changes to the DOM, which will get
reflected in the rendered view of the browser.

JavaScript can read through the DOM and find different types of things. For
instance, if you wanted to find all of the elements on the page by the name of
their HTML tag, you could use the following function on the DOM object,
reflected in JS by the `document` variable:

```JavaScript
document.getElementsByTagName("p");
```

This would produce a list of all of the `<p>` elements on the page.

You can also use JavaScript to try and find individual elements. The `id`
attribute is great for this, as JavaScript can hone in on the element with the
matching `id`:

```JavaScript
document.getElementById("headline");
```

Note the difference in the grammar of the functions: one references `Elements`,
and the other references `Element`. This is a hint at what this function will
return: `getElementsByTagName` will return an array of elements, as it has
`Elements` in its name. `getElementById` will return a single element: the
element with an id that matches the argument we passed in.

There are several functions like this (including `getElementsByClassName` and
`getElementsByName`), and we can use JavaScript to further manipulate those
elements!

### Changing CSS with JavaScript

When JavaScript correctly identifies an element using a selector, it "inflates"
the element inside of JavaScript. "Inflating" means that JavaScript takes
everything it knows about the element (where it is located in the DOM, the CSS
applied to it, and any contents - text, images, child elements - it might have)
and creates a JavaScript `object` to hold all the data. This object has
functions and properties that, when edited, will update the HTML they represent.

This means there is a critical link between the CSS selectors (tags, classes,
and ids) and the JavaScript that manipulates them on the page. Using plain
JavaScript, we can write code that looks for a certain thing and then changes it.

```html
<body>
  <p id="fluid"> I am prone to change! </p>
  <p id="frozen"> I will never change! </p>
</body>
```

Given this HTML, we can write JavaScript that can identify all of the `<p>`
elements with an `id` of `fluid`!

```JavaScript
document.getElementById('fluid');
```

We can save the element that the `getElementById` function gives us to a
variable and then manipulate the element to change the presentation of it!

```JavaScript
let fluid = document.getElementById('fluid');
```

For instance, lets say we wanted to change the text of the `fluid` elements to
display the time at which they were updated. We might do that like this:

```JavaScript
let generateChangeString = () => {
  let seconds = new Date().getTime() / 1000;
  return 'I last changed at ' + seconds
}

let fluid = document.getElementById('fluid');
fluid.innerHTML = generateChangeString();
```

The `fluid` variable holds a `JavaScript` object that has access to the
`innerHTML` property, which holds the content of the `fluid` HTML element . When
we set this to `generateChangeString()`, we're using JavaScript to return a new
string - a new string showing the last time that this element changed!

`functions` are a grouping of instructions, and in JavaScript they execute a
repeatable series of actions. They can return a value, they can return nothing
(or, in JavaScript, a special type of nothing called `undefined`), and they can
even return functions! `generateChangeString` returns a new string.

When we call `generateChangeString()`, the function executes and `return`s the
string. This gets saved to the `innerHTML` property, which updates the view.

### Connecting it all with Events

While the above JavaScript would work, we need to get it into the HTML page
somehow. What's more, is that we would want to make sure the code executes
_when_ we want it to.

Most programming languages execute in a particular order, top-to-bottom. With
JavaScript, we have to be more dynamic, as the JavaScript engine in the browser
can respond to various _events_ from the user (clicking on a link, scrolling,
typing into an input box, etc). When one of these events happens, the JavaScript
engine will look at the event type and then run any functions that have been
added to this event through _event listeners_. Lets change our code above to use
the `onclick` listener inside of our HTML!

First, lets put this `JavaScript` code in the `script` element inside our `head`
element. We're going to want to call it directly, so let's wrap it up in a
function named `changeText`.

```html
<script>
  let fluid;
  let generateChangeString;
  let changeText;

  changeText = () => {
    fluid = document.getElementById('fluid');
    fluid.innerHTML = generateChangeString();
  };

  generateChangeString = () => {
    let seconds = new Date().getTime() / 1000;
    return 'I last changed at ' + seconds
  };
</script>
```

Now, we can add an HTML attribute, `onclick`, to our fluid `<p>` tag.

```html
<html>
  <head>
    <script>
      let fluid;
      let generateChangeString;
      let changeText;

      changeText = () => {
        fluid = document.getElementById('fluid');
        fluid.innerHTML = generateChangeString();
      };

      generateChangeString = () => {
        let seconds = new Date().getTime() / 1000;
        return 'I last changed at ' + seconds
      };
    </script>
  <head>
  <body>
    <p onclick="changeText()" id="fluid"> I am prone to change! </p>
    <p class="frozen"> I will never change! </p>
  </body>
</html>
```

The `onclick` attribute binds the `changeText` function in our JavaScript to the
*event* of a users click. When a user clicks on the `p#fluid` element, the
JavaScript function `changeText` will run!

This interaction, triggering behavior based off of events initiated by the
user, is the original use case for JavaScript.

### JavaScript Today

Most JavaScript written for the browser today relies on this event-driven pattern.
By leveraging selectors, developers can write JavaScript to better manipulate
the HTML on the page based on user interaction.

There are a number of tools that JavaScript developers use to make their jobs
easier, and to make it a more palatable language for those involved. Chief among
those libraries is [jQuery](https://jquery.com/), the "Write Less, Do More"
JavaScript library.

jQuery became rapidly adopted as an industry standard following its release. It
resolves many cross-browser incompatibilities (meaning, the different ways that
various browsers implement - or, in some cases, fail to implement - the
JavaScript specification), and jQuery also provides 'syntactical sugar' for
developers, which generally means "easier to read, easier to write."

Compare the different syntaxes for finding an HTML element based on ID, for
instance.

In pure JavaScript:

```js
document.getElementById('test-id');
```

Using jQuery:

```js
$('#test-id');
```

This kind of help can save the programmer keystrokes while increasing the
readability of the code. And many of jQuery's methods not only provide syntactic
sugar, they also provide a stable, consistent interface that hides a lot of the
cross-browser differences.

### Front-end JavaScript

"Front-end" refers to all interactions between the browser and the user. CSS,
HTML, and interactive JS are all considered to be 'front-end' technologies.

Front-end JavaScript frameworks are software systems designed to handle the
management and logic of presenting HTML. They were conceived out of a need to
have more responsive, complex, and easily testable JavaScript. In some
frameworks, the server takes a back-seat to the JavaScript: the initial HTML
just contains JavaScript, which will launch when the page loads and make the
website look and act the way it was written to look. The Server is relegated to
a source of data, where permanent changes are sent via HTTP calls and stored in
a database.

This use case for JavaScript is still relatively new, and several solutions have
made their way into the developer consciousness:
[Angular](https://angularjs.org/),
[Ember](http://emberjs.com/), and
[React](https://facebook.github.io/react/)
are a few that have risen in popularity recently.

### Wrap Up

JavaScript has been on a tumultuous journey since its introduction into the web
space. What once was a simple scripting language for changing elements of HTML
is now a robust language designed to tackle any particular coding problem that
comes on the horizon.

Like CSS and HTML, JavaScript relies on browser compatibility. While libraries
like jQuery offer some level of compatibility checking, new features may be slow
to be adopted by all browsers.
