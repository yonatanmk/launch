## Learning Objectives

* Learn about `ReactFragment`s.
* Know how to create and use **stateless React components**

## Following Along

In this lesson, we will be working from a pre-built application.

Perform the following steps to get started:

```sh
$ cd ~/challenges
$ et get react-stateless-components
$ cd react-stateless-components
$ npm install
$ webpack-dev-server
```

## Project Description

We have been tasked with creating a grocery list application. Here are the
wireframes provided by our Project Manager:

![Grocery List React Design][grocery-list-react-design]

So far, the current application renders the following static page:

![Grocery List React No Styling][grocery-list-react-no-styling]

The rendering of this page is done through the following code:

```javascript
// main.js
import './app.scss';
import React from 'react';
import ReactDOM from 'react-dom';

let app = (
  <div>
    <h1>Grocery List React</h1>
    <form
      onSubmit={
        event => {
          event.preventDefault();
          alert('Form was submitted');
        }
      }
    >
      <input type="text" placeholder="name of grocery" />
      <input type="submit" value="Add To List" />
    </form>
    <ul>
      <li>
        Oranges
        <button type="button" onClick={event => alert('Button was clicked')}>Delete</button>
      </li>
      <li>
        Bananas
        <button type="button" onClick={event => alert('Button was clicked')}>Delete</button>
      </li>
      <li>
        Bread
        <button type="button" onClick={event => alert('Button was clicked')}>Delete</button>
      </li>
    </ul>
  </div>
);

ReactDOM.render(
  app,
  document.getElementById('app')
);
```

This code has placeholder event handlers for when a delete button is clicked or
when the form is submitted. In a future article, we will update these event
handlers to establish the desired behavior. This is a good starting point for
the application, but we can make some improvements.

We can improve the code for listing grocery items by utilizing `ReactFragment`s
and **stateless React components**.

## `ReactFragment`s

**A `ReactFragment` is simply an array of `ReactElement`s**.

If `React.createElement` is given a `ReactFragment` as a `children` argument,
then every `ReactElement` in the `ReactFragment` will become a child element of
the created `ReactElement`.

Thus, we can refactor our code to use a `ReactFragment` as such:

```javascript
// main.js
import './app.scss';
import React from 'react';
import ReactDOM from 'react-dom';

let oranges = (
  <li>
    Oranges
    <button type="button" onClick={event => alert('Button was clicked')}>Delete</button>
  </li>
);

let bananas = (
  <li>
    Bananas
    <button type="button" onClick={event => alert('Button was clicked')}>Delete</button>
  </li>
);

let bread = (
  <li>
    Bread
    <button type="button" onClick={event => alert('Button was clicked')}>Delete</button>
  </li>
);

let groceries = [oranges, bananas, bread];
let app = (
  <div>
    <h1>Grocery List React</h1>
    <form
      onSubmit={
        event => {
          event.preventDefault();
          alert('Form was submitted');
        }
      }
    >
      <input type="text" placeholder="name of grocery" />
      <input type="submit" value="Add To List" />
    </form>
    <ul>
      {groceries}
    </ul>
  </div>
);
...
```

This code renders the same page as before.

Here the `groceries` variable is a `ReactFragment`, and we are using curly
brackets to evaluate the `groceries` expression as a children argument of the
`ul` ReactDOMElement being created.

It is advantageous to use a `ReactFragment` because the number of groceries
could be zero, one, or more than one. Regardless of the number of groceries,
the `ul` will always receive a `ReactFragment` as its only argument.

It might be tempting to start rendering child elements only via
`ReactFragment`s. `ReactFragment`s should typically only be used if:

1. The number of children elements may vary.
2. All of the children are of the same type and share the same properties.

There may be times when these guidelines are not met, and it is appropriate to
use a `ReactFragment`, but these are good guidelines to follow in your early
development of React applications.

Therefore, we would not use a `ReactFragment` to render the children elements of
the `form` element because the number of children elements is constant and even
though both children elements are of the type `input`, the children elements
still differ in properties (i.e. one has a `placeholder` property and the other
one has a `value` property).

After updating the code to use a `ReactFragment`, the following error will
appear in the console of your Chrome Developer Tools.

```no-highlight
Warning: Each child in an array or iterator should have a unique "key" prop.
Check the top-level render call using <ul>. See https://fb.me/react-warning-keys
for more information.
```

This error is raised because each `ReactElement` in a `ReactFragment` needs a
unique `key` attribute specified.

In short, the `key` attribute is required because the `ReactElement`s are almost identical, so React needs a way to keep track of the identity of each child element.
The value for the `key` attribute should be a unique identifier for the child element.
For instance, if the data for each child element was stored in a relational database, then it would be appropriate to use primary key values for the `key` attribute.

We will go more in-depth about why the `key` attribute is needed in `ReactFragments` once our application is rendered multiple times.

For now, we will simply assign arbitrary unique values to the `key` attribute of the `li` ReactDOMElements like so:

```javascript
// main.js
import './app.scss';
import React from 'react';
import ReactDOM from 'react-dom';

let oranges = (
  <li key={1}>
    Oranges
    <button type="button" onClick={event => alert('Button was clicked')}>Delete</button>
  </li>
);

let bananas = (
  <li key={2}>
    Bananas
    <button type="button" onClick={event => alert('Button was clicked')}>Delete</button>
  </li>
);

let bread = (
  <li key={3}>
    Bread
    <button type="button" onClick={event => alert('Button was clicked')}>Delete</button>
  </li>
);

let groceries = [oranges, bananas, bread];
...
```

The benefit of using a `ReactFragment` to dynamically render children may not
yet seem apparent because we still have to manually create an `li`
ReactDOMElement and add it to the `groceries` `ReactFragment`.

Once we refactor our code to use stateless components, this benefit will become
more pronounced.

## Stateless Components

There is a lot of code repetition occurring whenever we create grocery `li` elements.
We can DRY up this code by defining a stateless `Grocery` component in `src/Grocery.js`, and importing the component to the `main.js` file:

```javascript
// Grocery.js
import React from 'react';

const Grocery = props => {
  return (
    <li>
      {props.name}
      <button type="button" onClick={props.handleButtonClick}>Delete</button>
    </li>
  );
};

export default Grocery;
```

```javascript
// main.js
import './app.scss';
import React from 'react';
import ReactDOM from 'react-dom';
import Grocery from './Grocery';

let oranges = <Grocery key={1} name="Oranges" handleButtonClick={event => alert('Button was clicked')} />;
let bananas = <Grocery key={2} name="Bananas" handleButtonClick={event => alert('Button was clicked')} />;
let bread = <Grocery key={3} name="Bread" handleButtonClick={event => alert('Button was clicked')} />;

let groceries = [oranges, bananas, bread];

let app = (
  <div>
    <h1>Grocery List React</h1>
    <form
      onSubmit={
        event => {
          event.preventDefault();
          alert('Form was submitted');
        }
      }
    >
      <input type="text" placeholder="name of grocery" />
      <input type="submit" value="Add To List" />
    </form>
    <ul>
      {groceries}
    </ul>
  </div>
);

ReactDOM.render(
  app,
  document.getElementById('app')
);
```

To define a component, we assign a variable to an arrow function.
An important aspect here is that the variable name **must** be capitalized.
This arrow function should take in a `props` object as an argument and return a `ReactElement`, which may have children `ReactElements` itself.
To create a `ReactElement` representing a component, use the same JSX syntax used to create a ReactDOMElement except replace the HTML tag string with the component function.
From this point forward, we will refer to a `ReactElement` representing a React component as a **ReactComponentElement**.
Properties specified when instantiating a ReactComponentElement will be available to the component function via the `props` object.

Let's take a look at the creation of a `Grocery` ReactComponentElement for "Oranges" to better understand how components are used:

```javascript
let oranges = <Grocery key={1} name="Oranges" handleButtonClick={event => alert('Button was clicked')} />;
```

In this example, `props.name` will return `"Oranges"`, and `props.handleButtonClick` will return the function `event => alert('Button was clicked')` in the `Grocery` function.
Thus, the `Grocery` ReactComponentElement in this case will render the following ReactDOMElements.
It's important to note that `key` is not accessible by `props.key` within a component.

```javascript
<li>
  Oranges
  <button type="button" onClick={event => alert('Button was clicked')}>Delete</button>
</li>;
```

These are the same elements that were previously rendered for the "Oranges" list item, so our page still renders the same DOM elements after refactoring to use the `Grocery` component.
To better visualize how we are using the `Grocery` component, we have drawn red boxes around the rendered output of each of the three `Grocery` components:

![Grocery List Grocery Component][grocery-list-react-grocery-component]

One last thing to note in this code is that the `key` attribute is no longer on the `li` element, but it is instead specified on the `Grocery` ReactComponentElements.
This is because the the `ReactElement`s in the `groceries` `ReactFragment` are now the `Grocery` ReactComponentElements.

Now that we know what a component is, you might be wondering why this component is referred to as stateless.
The components presented here are stateless because they will always render the same output to the page given the same `props` object.
In contrast, a **stateful component** might render different outputs to the page given the same `props` object.
We will extensively discuss how stateful components accomplish this in the a future article.

Using the `Grocery` component has improved the code, but there is still plenty of repetition when creating `Grocery` ReactComponentElements.

We can do better by creating a `GroceryList` component:

```javascript
// GroceryList.js
import React from 'react';
import Grocery from './Grocery';

const GroceryList = props => {
  let groceries = props.groceries.map(grocery => {
    return (
      <Grocery
        key={grocery.id}
        name={grocery.name}
        handleButtonClick={props.handleButtonClick}
      />
    );
  });

  return (
    <ul>
      {groceries}
    </ul>
  );
};

export default GroceryList;
```

```javascript
// main.js
import './app.scss';
import React from 'react';
import ReactDOM from 'react-dom';
import GroceryList from './GroceryList';

let groceries = [
  { id: 1, name: "Oranges" },
  { id: 2, name: "Bananas" },
  { id: 3, name: "Bread" }
];

let app = (
  <div>
    <h1>Grocery List React</h1>
    <form
      onSubmit={
        event => {
          event.preventDefault();
          alert('Form was submitted');
        }
      }
    >
      <input type="text" placeholder="name of grocery" />
      <input type="submit" value="Add To List" />
    </form>
    <GroceryList groceries={groceries} handleButtonClick={event => alert('Button was clicked')} />
  </div>
);

ReactDOM.render(
  app,
  document.getElementById('app')
);
```

We are now importing and using the `GroceryList` component in `main.js`.
Furthermore, the `Grocery` component is only used by the `GroceryList` component, so we only need to import it in `GroceryList.js`.
To render the list of groceries, the `GroceryList` component will utilize a `groceries` property, which is an array of objects containing the data for each grocery, and a `handleButtonClick` property which is the event handler to be used when the delete button for a grocery is clicked.
The `GroceryList` function will first use the data from the `props.groceries` array to create a `groceries` `ReactFragment`.
This `groceries` `ReactFragment` will contain `Grocery` ReactComponentElements.
Through the use of a `ReactFragment` to dynamically render children, we have successfully created a `GroceryList` component that renders an entire list of grocery items from an array of objects which represent individual grocery data.

The following picture encloses the rendered output of the `GroceryList` component in an orange box:

![Grocery List Grocery List Component][grocery-list-react-grocery-list-component]

We now have a `GroceryList` component that concerns itself with rendering the list of groceries.
In the spirit of separation of concerns, it is also in our interest to create a component whose single responsibility is rendering the form.
We can create a `GroceryForm` component like so:

```javascript
// GroceryForm.js
import React from 'react';

const GroceryForm = props => {
  return (
    <form onSubmit={props.handleFormSubmit}>
      <input type="text" placeholder="name of grocery" />
      <input type="submit" value="Add To List" />
    </form>
  );
};

export default GroceryForm;
```

```javascript
// main.js
import './app.scss';
import React from 'react';
import ReactDOM from 'react-dom';
import GroceryList from './GroceryList';
import GroceryForm from './GroceryForm';

let groceries = [
  { id: 1, name: "Oranges" },
  { id: 2, name: "Bananas" },
  { id: 3, name: "Bread" }
];

let app = (
  <div>
    <h1>Grocery List React</h1>
    <GroceryForm
      handleFormSubmit={
        event => {
          event.preventDefault();
          alert('Form was submitted');
        }
      }
    />
    <GroceryList groceries={groceries} handleButtonClick={event => alert('Button was clicked')} />
  </div>
);

ReactDOM.render(
  app,
  document.getElementById('app')
);
```

We import the `GroceryForm` component into `main.js` to use it.
By using this component, we have separated the concerns of the code in `main.js`, and we can also better visualize the structure of our application.
To increase the flexibility of the `GroceryForm` component, the component has a `handleFormSubmit` property which will be used as the form submission event handler.

The following picture encloses the rendered output of the `GroceryForm` component in a green box:

![Grocery List Form Component][grocery-list-react-form-component]

Lastly, it is usually customary to have a single top-level component for our application.
Here we will call this component `App`:

```javascript
// App.js
import React from 'react';
import GroceryForm from './GroceryForm';
import GroceryList from './GroceryList';

let groceries = [
  { id: 1, name: "Oranges" },
  { id: 2, name: "Bananas" },
  { id: 3, name: "Bread" }
];

const App = props => {
  let handleFormSubmit = event => {
    event.preventDefault();
    alert('Form was submitted');
  };

  let handleButtonClick = event => alert('Button was clicked');

  return (
    <div>
      <h1>Grocery List React</h1>
      <GroceryForm handleFormSubmit={handleFormSubmit} />
      <GroceryList groceries={groceries} handleButtonClick={handleButtonClick} />
    </div>
  );
};

export default App;
```

```javascript
// main.js
import './app.scss';
import React from 'react';
import ReactDOM from 'react-dom';
import App from './App';

ReactDOM.render(
  <App />,
  document.getElementById('app')
);
```

This further aids with separation of concerns because now our `main.js` file is simply focused on having `ReactDOM` render an `App` component.
In our `App` component function, we have also increased code legibility by assigning our event handlers to variables.
The purpose of the `groceries` global variable is to be hard-coded data that is used by our stateless components to ensure that all necessary DOM elements are rendered.
If we did not have this data, we would not be able to ascertain that our `GroceryList` and `Grocery` components work as intended.
At this point in our development process, though, we would delete this hard-coded data and finish implementing a working application by converting certain stateless components to stateful components.

The following picture encloses the rendered output of the `App` component in a blue box:

![Grocery List App Component][grocery-list-react-app-component]

## Summary

This article has demonstrated the creation of stateless components to encourage code reuse and separation of concerns.
By doing so, we have avoided a lot of code repetition and increased the maintability of our code.
We have also specifically learned how to use `ReactFragment`s in our components to render dynamic children.
All in all, creating and using stateless components to render a static page is a great way to start the development of a React application.
Once all the necessary stateless components have been created, the next step is to change some stateless components into stateful components in order to create a fully-functioning dynamic page.

## Additional Resources

* [React ES6 Syntax for Stateless Components][react-stateless-component-es6-syntax]
* [React Multiple Components][react-multiple-components]

[grocery-list-react-design]: https://s3.amazonaws.com/horizon-production/images/grocery_list_react.png
[grocery-list-react-no-styling]: https://s3.amazonaws.com/horizon-production/images/grocery_list_react_no_styling.png
[grocery-list-react-app-component]: https://s3.amazonaws.com/horizon-production/images/grocery_list_react_app_component.png
[grocery-list-react-grocery-component]: https://s3.amazonaws.com/horizon-production/images/grocery_list_react_grocery_component.png
[grocery-list-react-grocery-list-component]: https://s3.amazonaws.com/horizon-production/images/grocery_list_react_grocery_list_component.png
[grocery-list-react-form-component]: https://s3.amazonaws.com/horizon-production/images/grocery_list_react_form_component.png
[react-multiple-components]: https://facebook.github.io/react/docs/multiple-components.html
[react-stateless-components-repository]: https://github.com/LaunchAcademy/react_stateless_components
[react-stateless-component-es6-syntax]: https://facebook.github.io/react/docs/reusable-components.html#stateless-functions
