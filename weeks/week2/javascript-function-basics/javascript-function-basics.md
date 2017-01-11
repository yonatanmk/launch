### Learning Goals

* Implement a function using JavaScript
* Compare and contrast return values vs. functional side effects
* Define and clarify the concept of scope and scope chains
* Understand variable hoisting and the `this` keyword

## JavaScript Functions

Javascript's built-in functions likely are familiar to you. Take `alert()`, for example. If you run `alert('Hey, you')` from your console, you will see a small alert pop-up with the text `Hey, you` on the screen. While these built-in functions are valuable, as programmers we want to be able to write our own functions for our specific needs. Calling *function* lets us do just that.

Functions are *central* to the JavaScript programming language.

### JavaScript Function Definition

To follow along, open the Web Development Console, press `Cmd + Option + J` or `Ctrl + Shift + J` in Chrome.

Here we can set the variable `triple` to a function that returns three times an input:

```javascript
let triple = (x) => {
  return 3 * x;
}
```

```no-highlight
> triple(6);
18
```

Functions in JavaScript can be identified by the equals and greater-than sign, which form an arrow `=>`. `x` here is considered a *parameter* and `return 3 * x;` is the *body*, which needs to be wrapped in curly braces. Functions can also have no parameters. Here's an example:

```javascript
let gimmeThree = () => {
  return 3;
};
```

When we call `gimmeThree()` in our console, we see that it returns the number `3`.

```no-highlight
> gimmeThree();
3
```

Let's look at a slightly more complex example of counting the integers from 1 up to a number `x`;


```javascript
let countUpTo = (x) => {
  let count = "";
  for(let i = 1; i <= x; i++) {
    count = count + i + " ";
  }
  return count;
}
```

```no-highlight
> countUpTo(5);
"1 2 3 4 5 "
```

### Passing Functions as Arguments to Other Functions

A really powerful aspect of the language that JavaScript provides for is the ability to pass functions as parameters to other functions:

```javascript
let obiWanKenobi = (name) => {
  return "Use the force, " + name;
}

let darthVader = (name) => {
  return name + ", I am your father.";
}
```

Here we are just defining two functions `obWanKenobi` and `darthVader` which return two different strings based on an input `name`. We can now pass either of those functions to another function `dataHandler`:

```javascript
let dataHandler = (name, func) => {
  return func(name);
}
```

Now let's call `dataHandler` by passing two parameters to it:

```
dataHandler("Luke", obiWanKenobi);
>> "Use the force, Luke"

dataHandler("Luke", darthVader)
>> "Luke, I am your father."
```

Passing functions between one another not only cleans up our code, but allows us to organize and associate powerful actions, especially when we incorporate events.

### Side Effects

In each of the above functions, we *return* a value, by explicitly calling the **return** keyword. But not all functions need to return a value (a function that *doesn't* call the **return** keyword will return the special value `undefined` -- we'll talk more about that later.) Instead, some functions produce *side effects*. Consider the following function:

```javascript
let sayHiYou = () => {
  console.log("Hi, You!");
};
```

```no-highlight
> sayHiYou();
Hi, You!
```

While it looks like this function *returns* a string "Hi, You!", it's actually producing a side effect of printing to the screen.

Say we had both a `console.log` line in the function along with returning the same string "Hi, You!".

```javascript
let sayHiYou = () => {
  console.log("Hi, You!");
  return("Hi, You!");
};
```

```no-highlight
> sayHiYou();
Hi, You!
"Hi, You!"
```

In the above example, the function `SayHiYou` both logs to the console (as a side effect) along with returning the string. The return value is in quotes because it is a `String` data type.

The term *side effect* has a negative connotation to it, but that doesn't have to be the case in programming! You can probably guess there are times when you *want* to produce side effects (like printing to the screen, for example). If a function's sole purpose is returning a value, with no side effects (and no side effect dependencies) we call it a *pure function*. Pure functions, in Javascript, neither depend on nor modify the states of variables outside their scopes. In other words, a pure function will return a consistent result, given the same arguments.

For example:

(1) Impure Function

```javascript
let thinkerPerson = { name: "Wittgenstein" };

let impureFunction = (thing) => {
  let suffix = "Philosopher";

  thing.name = thing.name + ", " + suffix;
}

impureFunction(thinkerPerson);
```

(2) Pure Function

```javascript
let thinkerPerson = { name: "Wittgenstein" };

let pureFunction = (thing) => {
  let suffix = "Philosopher";

  thing = thing + ", " + suffix;

  return thing;
}

pureFunction ( thinkerPerson.name );
```

In example (1), `thinkerPerson` is modified by `impureFunction` while in example (2), it is not. `pureFunction` also neither depends on nor modifies variables outside of its own scope. But what does scope mean?

## Scope

Scope refers to the visibility of variables with respect to a function. While this might sound complicated, it really only describes if (and how) a function has access to a given variable. A variable is *in scope* to a function if that function can access it, and a function can access both *local* and *global* variables.

Consider the following example:

```javascript
let spaceThing = "is in space";

let spaceshipOne = () => {
  let spaceThing = "is in a spaceship";
}
```

We have the variable `spaceThing` twice. Outside of the function `spaceshipOne`, it's defined _globally_ (not within any function) as `"is in space"`, whereas it's defined as `"is in a spaceship"` local to (or within) the function. Let's see what this means when we run `spaceshipOne` and check the value of `spaceThing`:

```no-highlight
> spaceshipOne();
> console.log(spaceThing);
is in space
```

Here, `spaceThing` refers to the `spaceThing` defined outside of the function. The reason it doesn't change is because the second `spaceThing` is defined as a new local variable inside `spaceshipOne`. Can we change that value within another function? Let's take a look:

```javascript
let spaceThing = "is in space";

let spaceshipTwo = () => {
  spaceThing = "is in another spaceship";
}
```

Here, again, we define `spaceThing` globally as `"is in space"`, but notice the difference. Within `spaceshipTwo` we do not use the `let` keyword. This means that, rather than define a new, local variable named `spaceThing`, we will instead reference the global variable defined above the function. When we call `spaceshipTwo`, `spaceThing` will have a new value of `"is in another spaceship"`. Let's see this happen:

```no-highlight
> spaceshipTwo();
> console.log(spaceThing);
is in another spaceship
```

But how does `spaceshipTwo` know to reference the global `spaceThing`?

Variable scopes form a hierarchy. In this situation, the variable scope for the function `spaceshipTwo` can be thought of as existing _inside_ the global scope. When we use the `let` keyword, JavaScript knows to _create_ a new variable _within_ the current scope. When we _omit_ `let`, however, JavaScript searches for an _existing_ variable named `spaceThing` within the current scope. Failing to find one, it proceeds to search for the variable within the containing (or outer) scope.

As the function is defined globally (that is, not defined within another function or object), the next outer scope contains the already-defined `spaceThing`, which our function then overwrites. What happens, though, if we create additional scopes?

### Scope Chaining

Nesting variable scopes within another, and accessing variables from outer scopes, is a process known as **scope chaining**. In the examples above, we chained two scopes together, but we can go further than this.

Consider the following:

```javascript
let spaceThing = "I'm truly in space now";

let spaceshipThree = () => {
  let spaceThing = "I'm contained within a cold metal hull";
  (() => {
    spaceThing = "Where am I?"
  })();
}

spaceshipThree();
console.log(spaceThing);
```

This will output `"I'm truly in space now"`, but what's happening?

Again, we define the variables `spaceThing` both globally and locally within a function, but now there's more going on in `spaceshipThree` - we're using a technique called _self-invoking functions_. We'll expand on this concept later in the lesson, but for now let's just accept that this allows us to define - and execute - a function _inside_ of `spaceshipThree`.

Just as defining `spaceshipThree` created a scope contained within the global scope, this technique creates yet another nested scope, this time within `spaceshipThree`. As we see, omitting `let` in the nested function _does not_ affect the global `spaceThing`. If we wanted to be sure of this, we could change the code to print out the inner variable:

```javascript
let spaceThing = "I'm truly in space now";

let spaceshipThree = () => {
  let spaceThing = "I'm contained within a cold metal hull";
  (() => {
    spaceThing = "Where am I?"
  })();
  console.log(spaceThing);
}

spaceshipThree();
console.log(spaceThing);
```

Running this will show that the `spaceThing` defined immediately within `spaceshipThree` is now the variable being changed. Again, JavaScript is looking for a variable named `spaceThing` within the current scope of the inner function. Not finding one, it looks to the immediately containing scope of `spaceshipThree` where it finds the variable we defined in this scope using `let`. If we didn't include `let` within `spaceshipThree`, the line `spaceThing = "Where am I?"` would ultimately trace `spaceThing` back through the scope chain to the variable defined globally.

As we generally don't want functions to change the values of variables defined elsewhere, we can leverage function-local scopes to protect ourselves and our variables from unintentional changes, even when using the same variable names inside and outside of functions.

## Function Arguments and Object Properties

With scope chaining, we saw one way that a function could change an object. To see another way, let's take a look at how function arguments and object properties relate to one another:

```javascript
let rebrand = (theSpaceship) => {
  theSpaceship.brand = "Virgin Galactic";
}

let mySpaceship = {
  brand: "SpaceX",
  model: "Enterprise",
  year: 2028
}
```

Here we define `rebrand` which takes an object and performs a task on it (setting the object's brand to `Virgin Galactic`). Let's take a look at a few things in `console.log` and see what's going on:

```no-highlight
> console.log(mySpaceship.brand)
"SpaceX"
```

That's straightforward. Let's pass mySpaceship to `rebrand` now and then look at the value of `mySpaceship.brand`:

```no-highlight
> rebrand(mySpaceship);
> mySpaceship.brand;
"Virgin Galactic"
```

As you might have expected, the function `rebrand` changed the value of the `brand` property on `mySpaceship`. Even though the object we're changing inside the function is `theSpaceship`, this local variable is acting as a reference to the object we passed in when we invoked `rebrand`. This is an excellent example of **side effects** mentioned previously.

## Interlude

### Functions as First Class Objects

Functions are *first-class objects* in JavaScript, meaning that they have the same behavior as any other object. What's so special about that? Well, while a program is being executed, a function that was constructed can be stored in a data structure. Additionally, as we saw earlier, we can pass the function around as an argument to another function and even have that function be returned as the value of another function!

* Interested in learning more here? See more on [StackOverflow](http://stackoverflow.com/questions/705173/what-is-meant-by-first-class-object) and this [blog post](http://helephant.com/2008/08/19/functions-are-first-class-objects-in-javascript/) about functions as first class objects.

### More on Return Values

By the way, it's worth noting here that to have a function return a value of something other than the default, a *return* statement must be called. Without a return statement, the function will return a default value, namely one of two types: (1) If the function constructor is called with *new*, the default value is the value of *this* (we'll talk more about *this* later); (2) Otherwise, a special value *undefined* is returned. We'll get into *this* and *undefined* later on, but for now, just keep these defaults in mind when constructing a function without an explicit return statement.

## Function declarations vs. expressions in ES5 and ES6

Let's look at a few examples of functions. Each of these has it's own subtleties that we'll discuss in a moment.

(1) Function declaration:

```javascript
function addInSpace(string) {
  return string + "in Space";
}
```

(2) *Anonymous* function expression assigned to `stringInSpace`:

```javascript
var stringInSpace = function(string) {
  return string + "in Space";
}
```

(3) *Anonymous* arrow function expression assigned to `stringInSpace`:

```javascript
let stringInSpace = (string) => {
  return string + "in Space";
}
```

(3) *Named* function `addInSpace` expression assigned to `stringInSpace`:

```javascript
var stringInSpace = function addInSpace(string) {
  return string + "in Space";
}
```

All these look pretty similar, and they do the same thing (add the string `"in Space"` to another string), but there are some key differences:

* Function *declarations* load before code gets executed.
* Function *expressions* load when the JavaScript reaches that line of code.

#### A Short Interlude on Function Declarations vs. Expressions

One of the simplest ways to create a new JavaScript function is with a *function declaration*:

```javascript
function eatSpaceFood() {
  alert("You are an astronaut!");
}

eatSpaceFood();
```

The JavaScript interpreter creates a function object (in this case `eatSpaceFood()`) as it parses the JavaScript code, and before the code is run. That allows you, due to a peculiarity of JavaScript called *hoisting* (which we'll talk more about later), to call a function "before" it is declared:

```javascript
eatSpaceFood();

function eatSpaceFood() {
  alert("You are an astronaut!");
}
```

*Function expressions* also let us create functions:

```javascript
let eatSpaceFood = function() {
  alert("You are an astronaut!");
}

eatSpaceFood();
```

However, they have with one main difference with *function declarations*. Hoisting doesn't affect *function expressions* so they get evaluated as the code runs.

Why should we prefer one over the other?

*Function declarations* look very similar to how functions and methods might look in other languages, but *function expressions* let us be very specific and about what kind of code we are trying to write. For example, *function declarations* shouldn't be be declared inside `if` statements or loops. In fact, different browsers will handle this kind of behavior differently. If you stick to *function expressions* broadly, you are likely to deal with less naming and scope issues long term.

## More on Global vs. Local Scope

### Global Scope

Defining a variable outside of a function will result it in having global scope. As a result, a global variable can be accessed by the browser at any point. How are global variables declared?

(1) Declaration outside of a function:

```javascript
let myFavoriteCity = "Berlin";
```

or

```javascript
favoriteCity = "Berlin";
```

(2) Declaration without the `let` keyword *in* a function

```javascript
showFavoriteCity = () => {
  favoriteCity = "Berlin";
  return favoriteCity;
}
```

```
> showFavoriteCity();
"Berlin"
```

Now, let's call the variable `favoriteCity`:

```
> favoriteCity;
"Berlin"
```

Note that after we call `showFavoriteCity()`, `favoriteCity` has a global context. What if we use the `let` keyword?

```javascript
let showAnotherFavoriteCity = () => {
  let anotherFavoriteCity = "New York";
  return anotherFavoriteCity;
}
```

```no-highlight
> showAnotherFavoriteCity();
"New York"
```

What happens when we call `anotherFavoriteCity`?:

```no-highlight
> anotherFavoriteCity;

Uncaught ReferenceError: anotherFavoriteCity is not defined
    at <anonymous>:2:1
    at Object.InjectedScript._evaluateOn (<anonymous>:895:140)
    at Object.InjectedScript._evaluateAndWrap (<anonymous>:828:34)
    at Object.InjectedScript.evaluate (<anonymous>:694:21)
```

As mentioned before, the `let` keyword is what separates global from local scope in a function. Keeping track of these kinds of things will become more and more important over time.

Also, it's better to avoid creating many globally scoped variables. If you can scope a variable locally and not globally, it's worth doing, as it makes debugging and application control much easier.

### Local Variables & Scope (Also known as function level scope)

Here is an example of local variable scope:

```javascript
let tibetanKing = "Nyatri Tsenpo"

let whoIsTheKingOfTibet = () => {
  let tibetanKing = "Langdarma"
  return tibetanKing;
}

console.log(tibetanKing);
```

Here, we have `tibetanKing` of `"Langdarma"` scoped to the function `whoIsTheKingOfTibet()` and `"Nyatri Tsenpo"` outside the scope of the function:

```no-highlight
> whoIsTheKingOfTibet();
"Langdarma"

> console.log(tibetanKing);
Nyatri Tsenpo
```

While both variables are called `tibetanKing`, they are not the same variable and have entirely different scopes. In fact, with respect to variables that have the same name, local variables take precedence over global variables when accessing a function that has the variable name used in its scope.

## Variable Hoisting

In JavaScript, variable declarations get processed before any other code gets processed. That implies that variables can look like they're used before they're declared:

```javascript
myPlanet = "Saturn";
var myPlanet;
```

is processed as the following:

```javascript
var myPlanet;
myPlanet = "Saturn";
```

This behavior is called *hoisting*, where variables are *hoisted* to the top of their containing scope. Because of this, strange or unintended behavior can occur! This can be a frequent cause of logic errors in your JavaScript.

**Note**: Hoisting is a property of declaring variables with the `var` keyword.
ES6 introduces the `let` keyword, which does not hoist variables.

As an exercise to understand hoisting, load up your browser console and take a look at each of the following examples and work through what hoisting is doing in each instance:

(1)

```javascript
var spaceThing = 'the Universe';
(() => {
  alert(spaceThing);
})();
```

(2)

```javascript
var spaceThing = 'the Universe';
(() => {
  alert(spaceThing);

  var spaceThing = 'Earth';
})();
```

(3)

```javascript
var spaceThing = 'the Universe';
(() => {
  var spaceThing = 'Earth';

  alert(spaceThing);
})();
```

(4)

```javascript
var spaceThing = 'the Universe';
(() => {
  var spaceThing;

  alert(spaceThing);

  var spaceThing = 'Earth';
})();
```

Note: These kinds of functions are called *Self-Invoking Functions*:

```javascript
(function() {
  # code
})();

(() => {
  # code
})();
```

Self-invoked functions automatically execute, unlike *function declarations* or *function expressions*, which need to get called.

So what's going on? Effectively this: in JavaScript, if your variable is declared *anywhere* in a scope, the *declaration* is hoisted to the top of the scope but *not* the *initialization*. As a rule, it's a good idea to define your variables at the top of a scope to avoid unintended behavior.

*Tip*: Always ensure your `var` and `let` keywords appear at the top of your scripts and functions.

## this

Think of the *this* keyword like a pronoun in English. The following two sentences effectively mean the same thing:

(1)

Hubble's orbit outside the distortion of Earth's atmosphere allows it to take extremely high-resolution images with negligible background light.

(2)

Hubble's orbit outside the distortion of Earth's atmosphere allows Hubble to take extremely high-resolution images with negligible background light.

<sub>Source: [Wikipedia](https://en.wikipedia.org/wiki/Hubble_Space_Telescope)</sub>

In the first sentence, `it` refers to Hubble. In English, this is short hand to avoid repeating `Hubble` again (like in sentence 2). It would be awkward to repeat `Hubble` when we can just use `it` as a reference. Similarly, *this* is a JavaScript keyword that refers to an object that is the subject of a current scope.

Let's see it in action.

A while back, we defined a `mySpaceship` object with three properties:

```javascript
let mySpaceship = {
  brand: "SpaceX",
  model: "Enterprise",
  year: 2028
};
```

Let's add a function called `details` to this object which logs the details of the `mySpaceship` variable:

```javascript
let mySpaceship = {
  brand: "SpaceX",
  model: "Enterprise",
  year: 2028,
  details: function() {
    let string = "Brand: " + mySpaceship.brand + ", ";
    string += "Model: " + mySpaceship.model + ", ";
    string += "Built in: " + mySpaceship.year;
    console.log(string);
  }
};
```

Now when we call `mySpaceship.details()` we see the following text in the console:

```
Brand: SpaceX, Model: Enterprise, Built in: 2028
```

Great. That does what we want, but it's a bit unwieldy. What if we had a global variable somewhere called `mySpaceship` that referenced a different spaceship? We can handle this imprecision and ambiguity with the `this` keyword:

```javascript
let mySpaceship = {
  brand: "SpaceX",
  model: "Enterprise",
  year: 2028,
  details: function() {
    let string = "Brand: " + this.brand + ", ";
    string += "Model: " + this.model + ", ";
    string += "Built in: " + this.year;
    console.log(string);
  }
};
```

`this` now refers to the context we're in when we call the `details()` function, meaning that `this` refers to the variable `mySpaceship` that the function gets called in. `this` is the entire object declared and assigned to `mySpaceship` above. Also, note that `this` only gets assigned when the function where `this` is declared gets invoked.

<sub>BTW, remember the DOM? Call `this` in your console and see what it refers to.</sub>

* More on this in the [Mozilla docs](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Operators/this) and at [JavaScript is sexy](http://javascriptissexy.com/understand-javascripts-this-with-clarity-and-master-it/)
