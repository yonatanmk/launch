### Introduction

Data types allow us to store different types of information. String variables
allow us to store and manipulate textual data. Number variables allow us to
keep a running total of prices, or let us keep track of the current index
within an Array.

In this lesson, we will explore the **object** data type in JavaScript, which
will allow us to combine variables and functions into a reusable package.

### Learning Goals

* Learn about the **object** data type in JavaScript.
* Learn how to get and set **object properties**.
* Define the blueprints for a custom type of object using a **class**.

### Objects and State

Objects are a way for programmers to group together data and functions, varaibles
and methods, **state and behavior**. We use objects as a way to model the outside
world from within the computer.

```no-highlight
let sam = new Object();

sam.name = 'Sam';
sam.age = 32;
sam.occupation = 'Software Developer';
```

In this example, we created a new JavaScript object called `sam`. We then
assigned some **properties** of the `sam` object: name, age, and occupation. We
can retrieve the values of the assigned properties by calling them by name.

```no-highlight
console.log(sam.name);  // 'Sam'
console.log(sam.age);  // 32
```

A more concise way to create this same object is via the **object literal**
notation.

```no-highlight
let sam = {
  name: 'Sam',
  age: 32,
  occupation: 'Software Developer'
}
```

The **properties** of an object keep track of the current **state** of the object;
In this case, the name, age, and occupation we have assigned.

### Objects and Behavior

Data is not the only thing we can group within an object. Functions that are
related to the object can also be tied to it. We typically call these functions,
**methods**.

```no-highlight
let sam = {
  name: 'Sam',
  age: 32,
  occupation: 'Software Developer',
  isAnAdult() {
    return this.age >= 18;
  },
  greet() {
    return `Hello, my name is ${this.name}.`;
  }
}

sam.isAnAdult();  // true
sam.greet(); // 'Hello, my name is Sam.'
```

In this example, we have defined a method on the `sam` object, which returns
`true` if Sam is over 18, and `false`, otherwise.

To validate that our code is working, let's rewind the clock by **reassigning**
Sam's age, and then calling the `isAnAdult()` method, again.

```no-highlight
sam.age = 10;
sam.isAnAdult();  // false
```

Our object has **behavior** in the form of methods which we can call on the
object.

**Note**: A common "gotcha" is when we forget to add opening and closing
parenthesis to the end of a method call. In order to run the method or function,
we **must** include parenthesis.

```no-highlight
sam.isAnAdult;  // won't execute the function
sam.isAnAdult();  // executes the function and returns true or false
```

### `this`

`this` is a special keyword in JavaScript, which we have decidedly avoided
discussing until now. It gives us a way to access _the caller of the method_.

In the example where we call `sam.isAnAdult()`, `this` is `sam`. The `isAnAdult()`
method is not aware of the variable name of its parent object. The `this`
keyword gives the method a way to access the data within the parent object.

_This_ is the most clear and concise explanation of `this` the author has found.
If you would like to read more about the concept of `this` in JavaScript, check
out the resources at the end of the article.

### Modeling Multiple People with ES6 Classes

Up to this point, we have created one person object with the following properties
and methods: name, age, occupation, isAnAdult(), and greet().

If we wanted to create another person object, we could simply copy-and-paste,
and change some values:

```no-highlight
let jim = {
  name: 'Jim',
  age: 23,
  occupation: 'Junior Software Developer',
  isAnAdult() {
    return this.age >= 18;
  },
  greet() {
    return `Hello, my name is ${this.name}.`;
  }
}
```

This is a valid solution. However, if we needed to model an entire company,
we would end up with quite a bit of repetitive code. Also, if we wanted to add
some functionality to the concept of a `person` object, we would have to add
it **in every place** we define one.

A **Class** gives us the ability to define the blueprint for a type of object.
Using JavaScript classes, we can factor out the common elements of our Person
objects, and create a reusable blueprint for building Person objects.

```no-highlight
// ES6 Class Syntax

class Person {
  constructor(name, age, occupation) {
    this.name = name;
    this.age = age;
    this.occupation = occupation;
  }
}

let sam = new Person('Sam', 32, 'Software Developer');
console.log(sam.name);  // 'Sam'
console.log(sam.age);  // 32
```

`new Person('Sam', 32, 'Software Developer')` states that we would like to create
a new Person object, with the name of `'Sam'`, who has an age of `32`, and an
occupation of `'Software Developer'`.

The `constructor` method within the Person class is responsible for assigning
the name, age, and occupation properties of the new Person object.

The simple formula to remember here is this:

```no-highlight
new ClassName(arguments) // => returns a new object built from the ClassName blueprint
```

### Adding Behavior

We can add **behavior** to our objects by defining methods in our Class blueprint.

```no-highlight
class Person {
  // ...

  isAnAdult() {
    return this.age >= 18;
  }

  greet() {
    return `Hello, my name is ${this.name}.`;
  }
}

let jim = new Person('Jim', 23, 'Junior Software Developer');
jim.isAnAdult();  // true
jim.greet(); // 'Hello, my name is Jim.'
```

We can now interact with these "people objects" as we did earlier in our program,
with the added benefit of being able to create a new "person object" with a simple,
one-line statement.

### Pre-ES6 Classes

As with most programming languages, there is more than one way to accomplish the
same task. Here are some other ways we can create a `Person` class in JavaScript.

It is not necessary to commit these different methods for defining a class to
memory. Simply use this as reference for translating pre-ES6 syntax.

##### Class as a Function with Internal Methods

{% show_solution %}
```no-highlight
function Person(name, age, occupation) {
  this.name = name;
  this.age = age;
  this.occupation = occupation;

  this.isAnAdult = function() {
    return this.age >= 18;
  }

  this.greet = function() {
    return 'Hello, my name is ' + this.name + '.';
  }
}
```
{% endshow_solution %}

##### Class as a Function with Prototype Methods

{% show_solution %}
```no-highlight
// using 'prototype' syntax for methods

function Person(name, age, occupation) {
  this.name = name;
  this.age = age;
  this.occupation = occupation;
}

Person.prototype.isAnAdult = function() {
  return this.age >= 18;
}

Person.prototype.greet = function() {
  return 'Hello, my name is ' + this.name + '.';
}

let jim = new Person('Jim', 23, 'Junior Software Developer');
```
{% endshow_solution %}

### Wrap Up

In this article, we have covered objects in JavaScript, as well as the foundations
of **Object-oriented Programming**.

### Resources

* [ECMAScript 6 - Method Properties](http://es6-features.org/#MethodProperties)
* [Understaing JavaScript Function Invocation and "this" - Yehuda Katz](http://yehudakatz.com/2011/08/11/understanding-javascript-function-invocation-and-this/)
* [You Don't Know JS: this & Object Prototypes](https://github.com/getify/You-Dont-Know-JS/blob/master/this%20&%20object%20prototypes/ch1.md)
* [Introduction to Object-Oriented JavaScript - MDN](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Introduction_to_Object-Oriented_JavaScript#The_class)
* [ES6 Classes - Google Chrome](https://googlechrome.github.io/samples/classes-es6/)
