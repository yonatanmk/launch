### Introduction

Writing tests for your code serves a number of purposes. Well written tests
ensure that our code does what we expect it to do. Instead of writing
documentation for our code, we can rely on tests to describe how our code
behaves. When it comes time to refactor our code, tests allow us to refactor
with confidence. When we are collaborating on a project, tests will tell us
when we have broken functionality which someone else has written.

There are quite a few terms that you might hear when it comes to testing, such
as Test-Driven Development and Behavior-Driven Development. It might help to
define them:

**Unit testing** involves writing tests that describe how individual methods or
functions work. Ruby's [RSpec framework][rspec] and JavaScript's
[Jasmine framework][jasmine] allow us to write unit tests.

**Acceptance/Integration testing** involves writing tests that describe how the
application should behave. These tests describe how the interaction of many
components of the system should work in concert. [Capybara][capybara], in the
context of a Ruby web application, accomplishes this task by allowing us to
write tests in terms of what the user sees, and how the user interacts with a
web application.

**Test-driven Development** is the act of writing a test first, watching it
fail, and writing only enough code to get the test to pass. The addition of
more test cases shapes the code, and becomes the documentation for the code.

**Behavior-driven Development** involves focusing on user interaction with an
application, and writing only the code that provides value to the user. Starting
with a user story, we can formulate a list of acceptance criteria which become
the basis of our test suite.

Let's explore the [Jasmine framework][jasmine], written by Pivotal Labs, which
allows us to write unit tests for our JavaScript code.

### Getting Set Up

1) Download the latest release of
[Jasmine Standalone](https://github.com/jasmine/jasmine/releases).

2) Unpack it.

```no-highlight
$ cd ~/challenges
$ mkdir learn-jasmine
$ cd learn-jasmine
$ unzip ~/Downloads/jasmine-standalone*.zip
```

### Circle Constructor

Let's practice TDD. Write this test and save it to `spec/CircleSpec.js`.

```js
describe('Circle', () => {
  describe('new Circle()', () => {
    it('takes a value for the radius', () => {
      circle = new Circle(5)
      expect(circle).toBeDefined()
      expect(circle.radius).toEqual(5)
    })
  })
})
```

Create an empty file called `src/Circle.js`. This is where we will implement our
specification.

We have started with a simple specification. We want a JavaScript function named
`Circle()`, which will create a new JavaScript object with the radius defined as
the value we pass to the function.

We can execute the test suite by utilizing the `SpecRunner.html` file. Add our
`CircleSpec.js` and the `Circle.js` files:

```html
<!DOCTYPE html>
<html>
  <head>
    <meta charset="utf-8">
    <title>Jasmine Spec Runner v2.x.x</title>

    <link rel="shortcut icon" type="image/png" href="lib/jasmine-2.x.x/jasmine_favicon.png">
    <link rel="stylesheet" href="lib/jasmine-2.x.x/jasmine.css">

    <script src="lib/jasmine-2.x.x/jasmine.js"></script>
    <script src="lib/jasmine-2.x.x/jasmine-html.js"></script>
    <script src="lib/jasmine-2.x.x/boot.js"></script>

    <!-- include source files here... -->
    <script src="src/Circle.js"></script>

    <!-- include spec files here... -->
    <script src="spec/CircleSpec.js"></script>

  </head>
  <body></body>
</html>
```

Now, run `open SpecRunner.html` from the command line, or open this file in your
browser. Here's what we should see in the browser:

![failing-spec-img](https://s3.amazonaws.com/horizon-production/images/PNZR8pL.png)

Let's write the code to make the tests pass. Write this code in `src/Circle.js`.

```js
class Circle {
  constructor(radius, x, y) {
    this.radius = radius
  }
}
```

Refresh the browser window.

![passing-spec-img](https://s3.amazonaws.com/horizon-production/images/mrN8RHk.png)

### The Jasmine Test Framework

Jasmine provides us with a number of features that allow us to write and run
tests against our code.

##### Expectations and Matchers

The test `expect(circle).toBeDefined()` consists of two parts: an expectation,
and a matcher.

`circle` is the subject of our test. We expect it to be something after
assigning the return value of `new Circle()` to this variable.

`.toBeDefined()` is a "matcher". Behind the scenes, `circle` is being compared
to the `undefined` primitive type. This is perhaps the most simple test we can
perform.

##### Matchers

`.toBe()` - compares the subject with `===`

`.toBeDefined()` and `.toBeUndefined()` - compares the subject with `undefined`.

`.toContain()` - if the subject is an array, it checks if it contains a value.

`.toBeLessThan()` - checks that the subject is less than a value.

`.toBeGreaterThan()` - checks that the subject is greater than a value.

`.toBeCloseTo()` - checks that the subject, a floating-point number, is close to
another floating-point number.

There are other matchers, which can be explored [here][jasmine].

### Expanding the Circle

Let's describe more behaviors that our Circle should have:

```js
describe('Circle', () => {
  describe('new Circle()', () => {
    it('takes a value for the radius', () => {
      circle = new Circle(5)
      expect(circle).toBeDefined()
      expect(circle.radius).toBe(5)
    })

    it('takes an optional argument for the center point', () => {
      circle = new Circle(5, 1, 2)
      expect(circle).toBeDefined()
      expect(circle.x).toBe(1)
      expect(circle.y).toBe(2)
    })

    it('defaults to the origin point if not provided', () => {
      circle = new Circle(5)
      expect(circle.x).toBe(0)
      expect(circle.y).toBe(0)
    })
  })
})
```

Write the code to make the test pass:

```js
class Circle {
  constructor(radius, x, y) {
    this.radius = radius
    this.x = x || 0
    this.y = y || 0
  }
}

```

### Moving Beyond State

So far, we have been describing the state that our `Circle()` function should
record. Let's create some dynamic behavior.

```js
describe('Circle', () => {
  // ...

  describe('#area', () => {
    it('returns 314.16 when the radius is 10', () => {
      circle = new Circle(10)
      expect(circle.area()).toBeCloseTo(314.16)
    })

    it('returns 12.57 when the radius is 2', () => {
      circle = new Circle(2)
      expect(circle.area()).toBeCloseTo(12.57)
    })

    it('returns 0.785 when the radius is 0.5', () => {
      circle = new Circle(0.5)
      expect(circle.area()).toBeCloseTo(0.785)
    })
  })
})
```

The area of a circle is computed by the formula: π * r². The JavaScript `Math`
library will help us complete this functionality.

```js
class Circle {
  constructor(radius, x, y) {
    this.radius = radius
    this.x = x || 0
    this.y = y || 0
  }

  area() {
    return Math.PI * Math.pow(this.radius, 2)
  }
}

```

### In Summary

Writing tests for our code allows us to say, with confidence, that our code
works the way we _expect_.

[rspec]: http://rspec.info/
[jasmine]: http://jasmine.github.io/
[capybara]: http://jnicklas.github.io/capybara/
