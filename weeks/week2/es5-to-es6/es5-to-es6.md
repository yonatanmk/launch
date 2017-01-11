### Introduction

The JavaScript language has evolved to fit the needs of JavaScript developers.
Improvements to the language have been made incrementally, over time. These
improvements are defined by **ECMAScript specifications**, which are updated every
few years. It is the responsibility of **JavaScript Engines** to implement
these specifications.

| Edition | Publish Date  | Description                                                             |
| ------- | ------------- | ----------------------------------------------------------------------- |
| ES1     | June 1997     | First edition                                                           |
| ES2     | June 1998     | Align specification with ISO/IEC 16262                                  |
| ES3     | December 1999 | Regular Expressions, exception handling, number formatting              |
| ES4     | N/A           | This specification was abandoned.                                       |
| ES5     | December 2009 | "strict" mode, clarifications to ES3, getters and setters, JSON support |
| ES5.1   | June 2011     | Align specification with ISO/IEC 1626:2011 (3rd ed)                     |
| **ES6** | June 2015     | New class and module syntax, iterators, arrow functions, promises, etc. |
| ES7     | June 2016     | Continued improvement of the ES6 specification                          |
| ES.Next | TBD           | Future enhancements to the ECMAScript specification                     |

We are currently studying **JavaScript ES6** syntax. This is the latest
specification that is currently implemented by JS engines, such as Chrome V8.
There were some major changes in the way we write JavaScript with the release
of the ES6 standard.

We should always prefer to write our code in ES6 syntax. However, because this
standard is so new, we will often come across examples written using ES5, or
older, syntax. Knowing how to read and translate code between these
specifications is an important skill.

In this article, we will explore some of the differences between the
JavaScript code developers used to write, and the JavaScript code we write today.


### Learning Goals

* Learn about the **var** keyword, and how it compares to **let**.
* Learn about the **function** keyword, and how this compares to ES6 arrow
  functions.
* Learn about **template strings** and how to perform string interpolation in
  JavaScript ES6.
* Learn how to create **object constructors** using functions and how this
  compares to the ES6 `class` keyword.


### Declaring Variables

The differences between ES5 and ES6 syntax can best be shown by example.

```no-highlight
// ES5 syntax
var x = 1;
if (true) {
  var x = 2;  // same variable!
  console.log(x);  // 2
}
console.log(x);  // 2
```

```no-highlight
// ES6 syntax
let x = 1;
if (true) {
  let x = 2;  // different variable
  console.log(x);  // 2
}
console.log(x);  // 1
```

[Source](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Statements/let#Scoping_rules_2)


The key idea here is to realize that `let` keeps the variable scoped to the
current block, while `var` does not.


### Functions

The following functions return `true` if a given number is even, `false` if odd.

```no-highlight
// ES5 syntax
var isEven = function(number) {
  var remainder = number % 2;
  return remainder == 0;
}
```

```no-highlight
// ES6 syntax
let isEven = (number) => {
  let remainder = number % 2;
  return remainder == 0;
}
```

There are other ways of defining functions in both ES5 and ES6 syntax. We will
typically use the above syntax for defining JavaScript functions. The following
references will show you _all_ of the different ways to define JS functions.

* [ES5 Functions - SpeakingJS](http://speakingjs.com/es5/ch15.html)
* [ES6 Arrow Functions - Mozilla Developer Network](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Functions/Arrow_functions)

Save these links for future reference.


### Strings

ES6 introduces a new way to work with strings. Previously, we had performed
**string concatenation** to combine strings.

```no-highlight
// ES5 syntax
var name = 'Ash';
var greeting = 'Hello, ' + name + '. How are you today?';
console.log(greeting);
```

With ES6 **template strings** (also known as **template literals**), we can
perform **string interpolation** to combine strings.

```no-highlight
// ES6 syntax
let name = 'Ash';
let greeting = `Hello, ${name}. How are you today?`;
console.log(greeting);
```

Both examples will yield the same result. The variable `greeting` will store the
string `'Hello, Ash. How are you today?'`.

Note that we must use backticks to define a template string. Otherwise, we won't
be able to perform string interpolation of variables within the template string.


### Objects

```no-highlight
// ES5 syntax
var Person = function(name) {
  this.name = name;
}

Person.prototype.greet = function(){
  return "Hello, my name is " + this.name + ".";
}

var john = new Person('John');
console.log(john.greet());
```

```no-highlight
// ES6 syntax
class Person {
  constructor(name) {
    this.name = name;
  }

  greet() {
    return `Hello, my name is ${this.name}.`;
  }
}

let john = new Person('John');
console.log(john.greet());
```

ES6 gives us the `class` keyword for writing object-oriented code. In the past
we had to utilize functions to define the constructors for our classes in
JavaScript.


### Wrap Up

In this article, we covered a number of the important changes in JavaScript
syntax when comparing ES5 to ES6 code. Being able to read JavaScript code and
understand its intention, regardless of syntax version, is an important skill
of a modern JavaScript developer.


### Resources

* [ECMAScript 6 - Overview and Comparison of New Features](http://es6-features.org/)
* [Learn ES6 Now!](http://learnharmony.org/)
* [ES6 Katas](http://es6katas.org/)
