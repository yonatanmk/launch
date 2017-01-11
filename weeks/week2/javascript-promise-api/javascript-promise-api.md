### Introduction

JavaScript is a programming language that treats functions as [first-class
citizens](https://en.wikipedia.org/wiki/First-class_citizen). This simply means
that a function can be assigned to a variable, a function can be passed
to other functions, and a function can be returned from a function.

JavaScript also supports **asynchronous** programming. If we know that a process
might take some time (e.g. - reading a file, downloading an image, requesting data
from a database), we can ask JavaScript to handle this asynchronously, and
specify a **callback function** to execute later. When the asynchronous task
completes, the callback function is then executed. The reason we do this is so
that we don't "lock up" the browser or the current "thread" of execution.

The problem here is that the asynchronous request may not be successful. What 
happens when our code fails, or never gives a return value? Often, in order to
handle the many possibilities that could occur, code would become a nested mess
of conditionals, colloquially known as **callback hell**, or **the Pyramid of
Doom**.

![Pyramid of Doom](https://s3.amazonaws.com/horizon-production/images/pyramid-of-doom.jpg)

Luckily for us, JavaScript has evolved a pattern to deal with this complexity.


### Learning Goals

* Define **callback functions**, and examine some examples of them.
* Learn how to utilize JavaScript **Promises** to handle the complexity of dealing
  with asynchronous programming.


### A Simple Callback Example

The JavaScript `setTimeout()` function is an example of a function that takes a
**callback** function as an argument. Simply put, `setTimeout()` lets us execute
a function at a specified point in the future.

Please, try out the following example in the JavaScript console.

```no-highlight
let delay = 3000

window.setTimeout(() => {
  alert(`setTimeout() was called ${delay}ms ago.`)
}, delay)
```

`setTimeout()` is given two arguments: first, an **anonymous callback function**,
and, second, the time to wait before executing that function.

To understand the asynchronous nature of this example, lets add another line.

```no-highlight
window.setTimeout(() => {
  console.log('▼・ᴥ・▼ - Then, I appear.')
}, 1000)

console.log('(ᵔᴥᵔ) - I appear first.')
```

The second call to the `console.log()` function is executed first. The call to
`window.setTimeout()` is **non-blocking**, meaning that execution of code
continues without us having to wait a full second for `'▼・ᴥ・▼ - Then, I appear.'`
to show up in the console.

To generalize this concept, a **callback** is a function that we expect to be
called by our code at some point in the future.


### A Simple Promise

As we stated earlier, handling the conditions that arise from asynchronous code
can be hazardous. Instead of using combinations `try..catch` blocks and `if..else`
statements to handle the many cases that can arise, we can utilize the **JavaScript
Promise API** to avoid the dreaded Pyramid of Doom.

```no-highlight
new Promise((resolve, reject) => {
  // do something asynchronously

  if (successful) {
    resolve()  // .then() is executed
  } else {
    reject()   // .catch() is executed
  }

}).then(handleSuccess)  // process data, add elements to the DOM, etc...
  .catch(handleError)   // show user an error message, retry network request, etc...
```

The key items to note in this example are...

* `Promise`, `resolve`, and `reject` are all defined by the JavaScript Promise API.
* `resolve`, and `reject` are functions, which should be called to trigger `.then()`
  and `.catch()`, respectively.
* `handleSuccess` and `handleError` are functions we need to define.


### The Language of Promises

Since a promise describes something that _may_ happen in the future, it can be
in one of several states.

* **fulfilled** - This is the successful state of a promise. `resolve()` will be
  called and the `.then()` branch of the promise will be executed.
* **rejected** - This is the failure state of a promise. `reject()` will be
  called and the `.catch()` branch of the promise will be executed.
* **pending** - The promise has neither been fulfilled or rejected.
* **settled** - The opposite of pending. The promise has either been fulfilled
  or rejected.


### Working With Files

Let's move away from the browser for a moment to experiment with Promises.

"File I/O" is a fancy way of saying "reading from, or writing to files." Since
this process has the potential to take a long time to execute (large file size),
or has the potential for error (file does not exist, corrupt file format), it is
a good use case for Promises.

First, let's look at some example code for reading a JSON (JavaScript Object
Notation) file.

```no-highlight
fs = require('fs')

fs.readFile('twitterData.json', 'utf8', (err, data) => {
  if (err) {  // check if there was a problem reading the file
    console.log('Error reading file.')
    console.log(err)
  } else {  // if no probs reading file, try to parse it
    try {
      twitterData = JSON.parse(data)
      console.log(twitterData)
    } catch (err) {
      console.log('Error parsing file.')
      console.log(err)
    }
  }
})
```

This ugly mess of code funk reads a file, and, if successful, tries to parse it,
and, if that's successful, prints the data to the console.

If we happen to misspell the filename as `twittrData.json`, we will get the
following message:

```no-highlight
Error reading file.
{ Error: ENOENT: no such file or directory, open 'twittrData.json'
  errno: -2,
  code: 'ENOENT',
  syscall: 'open',
  path: 'twittrData.json' }
```

If we try to parse a file that isn't properly formatted, we will get this message:

```no-highlight
Error parsing file.
SyntaxError: Unexpected token : in JSON at position 16
    at JSON.parse (<anonymous>)
    at fs.readFile (/Users/rd/work/curriculum/article/javascript-promise-api/readJsonFile.js:9:26)
    at tryToString (fs.js:425:3)
    at FSReqWrap.readFileAfterClose [as oncomplete] (fs.js:412:12)
```

Our code works, but, we can do better.

### Read File using Promises

First, we create a `read` function, which takes in a filename, and returns a Promise.

```no-highlight
fs = require('fs')

let read = (filename) => {
  return new Promise((resolve, reject) => {
    fs.readFile(filename, 'utf8', (err, data) => {
      if (err) {
        reject(Error(err))
      } else {
        resolve(data)
      }
    })
  })
}
```

Now, we can use our `read` function to read the JSON data from the file, parse it,
and output it to the page.

```no-highlight
read('twitterData.json')
  .then((data) => {
    let parsedData = JSON.parse(data)
    console.log(parsedData)
  })
  .catch((err) => {
    console.log("Something went wrong.")
    console.log(err)
  })
```

If there is an issue with **either** the filename or parsing the data within the
file, the code within `.catch()` will be executed. This saves us some lines, and
keeps us from having to put in a `try..catch` block.

### Chaining

We can take this example a step further. Within the `.then()` clause, we are
parsing some data, **then** printing it to the console. Let's update our example
to use `.then` chaining.

```no-highlight
read('twitterData.json')
  .then((data) => { return JSON.parse(data) })
  .then((json) => { console.log(json) })
  .catch((err) => {
    console.log("Something went wrong.")
    console.log(err)
  })
```

The return value of the first `then` becomes the input for the second. If anything
goes wrong, the `catch` handles it.


### The General Promise Format

```no-highlight
new Promise((resolve, reject) => {
  // do something asynchronously

  if (/* things are successful */) {
    resolve("It worked!")  // execute .then()
  } else {
    reject(Error("It broke!"))  // execute .catch()
  }

})
  .then((result) => {
  // process data, add elements to the DOM, etc...
  console.log(result)

})
  .catch((err) => {
  // show user an error message, retry network request, etc...
  console.log(err)
})
```

### Wrap Up

Promises allow us to execute asynchronous code, and then handle the success
or failure of that code.


### Resources

* [JavaScript Callbacks Explained Using Minions](https://medium.freecodecamp.com/javascript-callbacks-explained-using-minions-da272f4d9bcd#.54m4hm8li)
* [Understand JavaScript Callback Functions and Use Them](http://javascriptissexy.com/understand-javascript-callback-functions-and-use-them/)
* [Demystifying JavaScript Closures, Callbacks, and IIFEs](https://www.sitepoint.com/demystifying-javascript-closures-callbacks-iifes/)
* [Art of Node: Callbacks](https://github.com/maxogden/art-of-node#callbacks)
* [JavaScript Promises: an Introduction](https://developers.google.com/web/fundamentals/getting-started/primers/promises)
* [Promises in Wicked Detail](http://www.mattgreer.org/articles/promises-in-wicked-detail/)
* [Promises - promisejs.org](https://www.promisejs.org/)
* [Understanding ES6 - Promises](https://github.com/nzakas/understandinges6/blob/master/manuscript/11-Promises.md)
