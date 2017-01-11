### Introduction

In web development, we know that **HTML** is responsible for defining the structure of a page. When we want our page to be something more than boring black Times New Roman font on a white background, we can use **CSS** to change fonts, color, and styling of HTML elements. The final piece of this client-side set of languages is **JavaScript**! JavaScript executed within the client's browser allows us to make dynamic changes to the structure and styling of the rendered document. JavaScript can do this without a page re-load or contacting our server in any way, and this makes it a popular and user-friendly way to design and improve interfaces.

We make these dynamic changes on the DOM, or Document Object Model. This is an object-oriented representation of a given web page made of elements, (sometimes called nodes), which we can modify via JavaScript.

```javascript
let paragraphs = document.getElementsByTagName('p')
```

Open up the JavaScript console in Chrome with `Command + Option + J` and paste in the code above. (Safari and Firefox also have developer tools and a JavaScript console, if you prefer). This console is like your terminal--it's a command line for running JavaScript in real time on your webpages.

The code in the example above calls the `getElementsByTagName()` function of the `document` object (the entire page and all the "stuff" on it is enclosed in this parent object) and asks it to grab all the paragraphs on the page. Then we assign the result to a `paragraphs` variable, which will contain a collection of elements. In JavaScript, this is sometimes called a `nodeList`.

You might notice that when you type this into your console, it returns `undefined`. This is because JavaScript does not have implicit return values. Our variable is saved, but we don't have any obvious return from this action because we have not specified one.

Let's play around with the elements on the page! Try typing `document` into the JavaScript console. You can expand the properties of this object by clicking the arrow to the left of the returned object.

The `document` is one of a few JavaScript data types we should familiarize ourselves with:


## JavaScript DOM Data Types

* document - An object-oriented representation of the document we are looking at, from the starting `<!DOCTYPE html>` tag element, all the way to the closing `</html>` tag element.
* element - Typically, a single HTML tag and its contents, such as `<title>Google</title>`.
* nodeList - A collection of elements. We will get a nodeList back from a document query that has multiple matches, such as selecting all the `div` (or, in the example above, `<p>`) elements in a page.
* attribute - This is the same as an attribute on an HTML tag, such as `href="http://google.com/"`.


## Dynamic Additions

Now that we know what the DOM is, we can make changes to it on the fly using JavaScript. For example,with the `createElement` and `appendChild` functions, we can add content to the page. Here's a small script to get you started:

```javascript
let paragraph = document.createElement('p')
let text = document.createTextNode('Oh hey, I\'m learning JavaScript at Launch Academy!')
paragraph.appendChild(text)

let body = document.getElementsByTagName('body')[0]
body.appendChild(paragraph)
```

What's happening in this code snippet? Well, in order to dynamically add content to the page, we must first create a paragraph element, then create a `textNode`, append the text node to the paragraph, and finally append the paragraph to some location in the page. In this case, we just added it to the bottom of the page. Scroll down and take a look!

Since this is a bit of a complex maneuver, it might be nice to be able to reuse this code later so we don't have to re-write it every time we want to add something to the page. We can save it in a function.

```javascript
let appendElement = (target, tag, text) => {
  let element = document.createElement(tag)
  let textNode = document.createTextNode(text)
  element.appendChild(textNode)
  target.appendChild(element)
}

let body = document.getElementsByTagName("body")[0]
appendElement(body, "p", "Make it Dynamic!")
```

Now we can call our `appendElement` function to create any HMTL element that we want to create with the text that should be contained in it, and then append that brand new element to the existing DOM.

## Appending Strings

Since we are working with an HTML document object, it understands HTML. We can simply append a string of HTML to the document if we like.

```javascript
let body = document.getElementsByTagName("body")[0]
let newParagraph = '<blockquote>There is more than one way to do it - Tim Toady</blockquote>'
body.innerHTML += newParagraph
```

## Selecting Elements

In the above examples, we used `getElementsByTagName` to collect the elements we wanted to modify. Two other common ways to select elements make use of their `class` or `id` to "choose" them for modification. For example:

```javascript
let someDiv = document.getElementById('oh-hai')
let someOtherDivs = document.getElementsByClassName('whats-up')
```
This example will interact with the HTML elements below. An id should be used to uniquely identify an element so that you can grab it with JavaScript, while classes are more commonly used in CSS to group and style particular elements in kind.

*Tip: Note that whenever you are using a function that collects multiple items (i.e. `getElementsByTagName` or `getElementsByClassName`), they will be collected and returned in an array.*

<div id="oh-hai">Hi, I'm a div with an id of "oh-hai"!</div>

<div class="whats-up">Hi, I'm a div with a class of "whats-up"!</div>
<div class="whats-up">Hi, I'm another div with a class of "whats-up"!</div>

## Dynamic Styling

Perhaps we don't like the designer's choice of font. Changing it with JavaScript from the console is easy.

```javascript
let body = document.getElementsByTagName("body")[0]
body.style.fontFamily = '"Andale Mono",AndaleMono,monospace'
```

With the `element.style` function, we can change any and all CSS properties of the page. Now, usually we will set these kinds of attributes with CSS in our stylesheet, like so:

```css
body {
  font-family: "Andale Mono", AndaleMono, monospace
}
```

However, sometimes we'll want to change the way the page looks based on what the user does. JavaScript lets us do that, essentially writing new CSS on the fly without having to contact the server for an updated stylesheet.

*Tip: Note that any keywords that contain a dash would need to be translated to camelCase when utilizing `element.style`. For example, to set the `background-color` of the body, we would need to set `body.style.backgroundColor = "grey"`.*


## Getting and Setting Attributes

We can also get and set attributes on elements. Maybe you're not that crazy about using Google and you would rather substitute the search engine on the page with another one.

```html
<!-- html -->
<a id="search-link" href="http://google.com/">Search</a>
```

```javascript
// js
let link = document.getElementById('search-link')
let url = link.getAttribute('href')
console.log(url)
link.setAttribute('href', 'http://duckduckgo.com/')
```

In the example above, we are able to retrieve the `href` attribute of the link with the `getAttribute` function, and then we print it to the console using the `console.log()` function. Using the `setAttribute` function, we then change the `Search` link to a different search engine.

Try it yourself: <a id="search-link" href="http://google.com/">Search</a>.


## Binding Actions to Events

One of the most enjoyable uses of JavaScript is the ability to dynamically change the page the user is interacting with by binding functions to events. That means that we wait for some event to occur (usually something the user is doing with their keyboard or mouse, but not always), and then we run one of our functions to do something in response. We can do this via the `addEventListener` function.

```javascript
let changeFontColor = (event) => {
  let colors = ['Aqua', 'Blue', 'Cyan', 'Green', 'LightGray', 'LightSteelBlue']
  let index = Math.floor(Math.random() * colors.length)
  let color = colors[index]
  event.srcElement.style.color = color
}

let paragraph = document.getElementById('moby-dick-chapter-1')
paragraph.addEventListener('click', changeFontColor, false)
```

In the example above, we have bound a function to an element in the page with an id of `id="moby-dick-chapter-1"`. When the user clicks on this element, the `changeFontColor` function is executed.

Check out this [list](https://developer.mozilla.org/en-US/docs/Web/Events) of all the events you can bind to your functions!


## The Whale - Chapter 1

<div id="moby-dick-chapter-1">
  Call me Ishmael. Some years ago- never mind how long precisely- having little or no money in my purse, and nothing particular to interest me on shore, I thought I would sail about a little and see the watery part of the world. It is a way I have of driving off the spleen and regulating the circulation. Whenever I find myself growing grim about the mouth whenever it is a damp, drizzly November in my soul whenever I find myself involuntarily pausing before coffin warehouses, and bringing up the rear of every funeral I meet and especially whenever my hypos get such an upper hand of me, that it requires a strong moral principle to prevent me from deliberately stepping into the street, and methodically knocking people's hats off- then, I account it high time to get to sea as soon as I can...
</div>


## Window Loading

Suppose we want to have some code execute after all of the assets (js, css, images) have been loaded into the page. In the following function, we are just printing a little message to ourselves in the JavaScript console that you opened at the beginning of the tutorial.

```javascript
window.onload = function() {
  console.log('window loaded.')
}
```

## Scrolling

You'll want to use caution when manipulating the window the user is interacting with, but when used judiciously, the `window.scrollTo()` function to scroll on your user's behalf can create some cool effects. In the example below, we can scroll the window down 1000 pixels. This begins calculating from the very top of the page.

```javascript
window.scrollTo(0, 1000)
```

## Conclusion

This has been a tour of some commonly used JavaScript functions to dynamically change the DOM. Your ability to alter the page the client is viewing is only limited to the functions provided to you and your imagination!


## References
* The [Mozilla Developer Documentation for JS](https://developer.mozilla.org/en-US/docs/Web/JavaScript) is exhaustive and contains many excellent articles. It's a great place to go looking for functions that do what you want or to learn more about a particular topic.
* [Introduction to the Document Object Model](https://developer.mozilla.org/en-US/docs/Web/API/Document_Object_Model/Introduction)
* [The Basics of JavaScript DOM Manipulation](http://callmenick.com/post/basics-javascript-dom-manipulation)
