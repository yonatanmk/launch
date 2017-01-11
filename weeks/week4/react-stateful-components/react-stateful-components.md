## Learning Objectives

* Learn about React stateful components
* Understand how the Virtual DOM is used to efficiently update the browser's DOM
* Understand why keys are needed in elements in a React Fragment
* Use stateful components in an application

## Following Along - First Code Example

We will be working on [this React application][stateful-component-example-repository].
To get quickly set up, run the following:

```sh
$ git clone https://github.com/LaunchAcademy/react-stateful-components-stateful-component-example.git
$ cd react-stateful-components-stateful-component-example
$ npm install
$ webpack-dev-server
```

## React Stateful Components
Often need to be dynamic and respond to user interface (UI) events, server events, and even the passage of time.
Thus, we need a way for components to update what they render under different circumstances.
We can accomplish this by using React stateful components.
Stateful components have a source of data called the `state`. React components can also receive data from their parent components called `props` that is passed down for them to use.
Data received from `props` should be considered constant and should never be changed.
In contrast, data in a component's `state` can be changed, and it should be changed whenever the UI needs to be updated.
Let's create a stateful component in our current project.
The two files that we are focusing on are:

```javascript
// main.js
import React from 'react';
import ReactDOM from 'react-dom';
import StatefulComponentExample from './components/StatefulComponentExample';

ReactDOM.render(
  <StatefulComponentExample message="hi" />,
  document.getElementById('app')
);
```

```javascript
// StatefulComponentExample.js
import React from 'react';

const StatefulComponentExample = props => {
  return (
    <div>
      <h1>Component Message {props.message}</h1>
    </div>
  );
};

export default StatefulComponentExample;
```
Booting up our Webpack Dev Server and going to [localhost:8080][localhost-8080] will display the following in the browser:

![React Stateful Components Photo 1][react-stateful-components-photo-1]

We can update this stateless component to a stateful class component as follows:

```javascript
// StatefulComponentExample.js
import React from 'react';

class StatefulComponentExample extends React.Component {
  constructor(props) {
    super(props);
  }

  render() {
    return(
      <div>
        <h1>Component Message: {this.props.message}</h1>
      </div>
    );
  }
};

export default StatefulComponentExample;
```

Booting up our Webpack Dev Server and going to [localhost:8080][localhost-8080] will display the following in the browser:

![React Stateful Components Photo 1][react-stateful-components-photo-1]

Here we use the [ES6 class syntax][introduction-to-es6-classes] and subclass under `React.Component` to declare a class which creates a React Component.
The constructor takes in the `props` as an argument, and uses `super` to set the `props` on the component.
React looks for a `render` method in component classes to determine the `ReactElement` returned by this component.
It is important to notice that we access our `props` via `this.props` in ES6 class methods.

![React Stateful Components Photo 1][react-stateful-components-photo-1]

To make this component actually stateful, we declare the initial state of the component in the `constructor` method of the class.

```javascript
// StatefulComponentExample.js
import React from 'react';

class StatefulComponentExample extends React.Component {
  constructor(props) {
    super(props);
    this.state = {
      clickCount: 0,
      chillLevel: 'Penguin with a surfboard'
    };
  }

  render() {
    return(
      <div>
        <h1>Component Message: {this.props.message}</h1>
        <h1>Component Click Count: {this.state.clickCount}</h1>
        <h1>Component Chill Level: {this.state.chillLevel}</h1>
      </div>
    );
  }
};

export default StatefulComponentExample;
```

When we declare the initial state of the component, we set `this.state` to a JS object which represents the state of the component.
We can then access the data in the state object via `this.state` in the other methods in the class.
Here we have set initial state object to have a `clickCount` equal to `0` and a `chillLevel` equal to `'Penguin with a surfboard'`.
In the browser, we now see the following:

![React Stateful Components Photo 2][react-stateful-components-photo-2]

The component is now stateful and is displaying the data from its state, but the page is still static.
It would make sense for the component's `clickCount` to increase every time the component is clicked.
To do so, we will update the state in response to a click event as such:

```javascript
// StatefulComponentExample.js
import React from 'react';

class StatefulComponentExample extends React.Component {
  constructor(props) {
    super(props);
    this.state = {
      clickCount: 0,
      chillLevel: 'Penguin with a surfboard'
    };

    this.handleClick = this.handleClick.bind(this);
  }

  handleClick(event) {
    let newClickCount = this.state.clickCount + 1;
    this.setState({ clickCount: newClickCount });
  }

  render() {
    return(
      <div onClick={this.handleClick}>
        <h1>Component Message: {this.props.message}</h1>
        <h1>Component Click Count: {this.state.clickCount}</h1>
        <h1>Component Chill Level: {this.state.chillLevel}</h1>
      </div>
    );
  }
};

export default StatefulComponentExample;
```

We have added an `onClick` event listener to the `div` element encompassing our component and used the `handleClick` method as the event handler.
It is up to your discretion to decide the names of event handler methods that are passed as `props` in the `render` method.
As mentioned previously, the event handlers will receive a [`SyntheticEvent`][react-synthetic-event] object as its first argument.
In this event handler, we simply want to determine the new click count value and update the state with the new click count value.
To change component state, we use the `setState` method which was inherited from `React.Component` and call it with an object containing only the properties that need to be updated.
Here, the `setState` method updates only the state's `clickCount` property's value to `newClickCount` while leaving the `chillLevel` property untouched.
Thus, our component remains as chill as ever and will have new state with a `chillLevel` of `'Penguin with a surfboard'` and a `clickCount` property incremented by one.
Most importantly, the `setState` method will trigger a re-rendering of the component with the new state and the browser page will be updated.
If we take a look at the browser now, we will see that the click count increments by one every time we click on the component!

### Critical Details

Before we review the process again, please be mindful of the following details:

- **Only ever change state via the `setState` method** - Otherwise, you will inadvertently delete state properties and fail to trigger the re-rendering of the component.

- **It is usually necessary to bind `this` to event handlers** - For any event handlers that use `this` and are passed down as `props` to ReactElements in your `render` method, you must bind `this` in the last line of the `constructor` method. Doing so ensures that `this` will always refer to the component that defined the event handler rather than the child component receiving the event handler as a `prop`.

### Rendering on State Change

To solidify our understanding of component state, let's add a `debugger` to the beginning of our `handleClick` and `render` methods and go through the component's initial rendering and the re-rendering whenever it is clicked.

```javascript
// StatefulComponentExample.js
...

  handleClick(event) {
    debugger;
    let newClickCount = this.state.clickCount + 1;
    ...
  }

  render() {
    debugger;
    return(
    ...
  }
};

export default StatefulComponentExample;
```
After making these changes, our Webpack Dev Server will automatically refresh the page for us and we will be in step 1 of the process.

#### Step 1. `render` is called for the initial rendering of the page.

![React Stateful Components Photo 3][react-stateful-components-photo-3]

There is nothing on the page because the `render` method has not returned the initial representiation of the component.
Exiting out of this debugger will take us to step 2.

#### Step 2. Page shows rendered component with initial state.

![React Stateful Components Photo 4][react-stateful-components-photo-4]

This displays the component's prop data and initial state data.
Clicking on the component will take us to step 3.

#### Step 3. Click event is triggered and event handler is invoked.

![React Stateful Components Photo 5][react-stateful-components-photo-5]

Here we are determining the new state and then calling `setState` to update the state and re-render the component.
Exiting out of this debugger will take us to step 4.

#### Step 4. `render` is called again to re-render the component.

![React Stateful Components Photo 5][react-stateful-components-photo-6]

At this point in time, the component has the new state. However, the page has not been updated because the `render` method has not returned the updated representation of the component.
Exiting out of this debugger will take us to step 5.

#### Step 5. Page shows re-rendered component with the new state.

![React Stateful Components Photo 7][react-stateful-components-photo-7]

If we were to click on the component again, steps 3-5 would be repeated.

One final refactoring we can do is to import `Component` directly from the `react` package, so we can write `extends Component` instead of `extends React.Component`.

```javascript
// StatefulComponentExample.js
import React, { Component } from 'react';

class StatefulComponentExample extends Component {
...
};

export default StatefulComponentExample;
```

## React Virtual DOM

You may currently be wondering how our React application updates the browser's DOM every time a component is re-rendered when its state changes.
First, we must recall that we have two libraries working together to achieve this: React and ReactDOM.
The React library creates virtual DOM representations while ReactDOM does the actual browser DOM manipulation based on the virtual DOM representations.
Every time a component is re-rendered, the React library creates a new virtual DOM.
A naive approach to update the browser DOM would be to delete the entire browser DOM and replace it with the new virtual DOM equivalent.
The problem with this is that browser DOM manipulation is an expensive operation, so React applications would be slow if this approach was taken.
However, what the React library does instead is it compares the newly generated virtual DOM with the previous virtual DOM and first determines if there are any differences.
If there are no differences, then ReactDOM does not touch the browser's DOM.
However, if there are differences, then ReactDOM will perform the minimal amount of changes to the browser's DOM, so it matches up with the new virtual DOM representation.
The process of manipulating the browser DOM so it matches the new virtual DOM is known as reconciliation.

Let's go through a conceptual example where our React application initially renders an empty `ul` element.
In the following picture, the top-left pane is our current virtual DOM and the top-right pane is our current browser DOM.
Both DOMs are currently in-sync with each other.

![React Stateful Components Photo 8][react-stateful-components-photo-8]

Let's assume there was a state change and components were re-rendered, so a new virtual DOM representation is created.
The new virtual DOM representation will be in the bottom-left pane.

![React Stateful Components Photo 9][react-stateful-components-photo-9]

React would first compare the current virtual DOM with the new virtual DOM and determine if there were any differences.
It would find that the difference was a new `li` element inside of the `ul` element.
Thus, ReactDOM would then update the browser DOM, so it matches the new virtual DOM.
The new browser DOM representation will be in the bottom-right pane.

![React Stateful Components Photo 10][react-stateful-components-photo-10]

The browser DOM is now again in-sync with the virtual DOM.
ReactDOM accomplished this by simply inserting a `<li>New element</li>` inside the `ul` element.
The `ul` DOM element in the browser DOM is the same as the one before the reconciliation process begun.
This is a cursory overview of the process of reconciliation.
We recommend reading the [Reconciliation section][react-reconciliation] of the React Docs to get a more comprehensive understanding of the process.
Now that we know how React updates the DOM, let's revisit the topic of `ReactFragment`s.

## Following Along - Second Code Example
We will be working on [this React application][react-fragment-example-repository].
To get quickly set up, run the following:

```sh
$ git clone https://github.com/LaunchAcademy/react-stateful-components-react-fragment-example.git
$ cd react-stateful-components-react-fragment-example
$ npm install
$ webpack-dev-server
```

## `ReactFragment`s

We will now finish discussing why `key` properties are needed for the elements in a `ReactFragment`.
The relevant files in our project are:

```javascript
// main.js
import React from 'react';
import ReactDOM from 'react-dom';
import App from './components/App';

ReactDOM.render(
  <App />,
  document.getElementById('app')
);
```
Our `main.js` file is simply just rendering the `App` component.

```javascript
// App.js
import React, { Component } from 'react';
import StatefulListItem from './StatefulListItem';

class App extends Component {
  constructor(props) {
    super(props);
    this.state = {
      listItems: [
        {
          id: 1,
          name: 'item one'
        },
        {
          id: 2,
          name: 'item two'
        }
      ]
    };

    this.handleSwitchButtonClick = this.handleSwitchButtonClick.bind(this);
  }

  handleSwitchButtonClick(event) {
    let firstListItem = this.state.listItems[0],
        secondListItem = this.state.listItems[1],
        nextListItems = [
          secondListItem,
          firstListItem
        ];

    this.setState({ listItems: nextListItems });
  }

  render() {
    let firstListItem = this.state.listItems[0],
        secondListItem = this.state.listItems[1],
        firstStatefulListItem,
        secondStatefulListItem,
        statefulListItems;

    firstStatefulListItem = <StatefulListItem name={firstListItem.name} />;
    secondStatefulListItem = <StatefulListItem name={secondListItem.name} />;
    statefulListItems = [firstStatefulListItem, secondStatefulListItem];

    return(
      <div>
        <ul>
          {statefulListItems}
        </ul>
        <button onClick={this.handleSwitchButtonClick}>Switch List Item Positions</button>
      </div>
    );
  }
};

export default App;
```
The `App` component is initialized with a state containing the data for the `StatefulListItem` ReactComponentElements.
The component will render a `ReactFragment` containing two `StatefulListItem` ReactComponentElements.
Initially, these ReactComponentElements are created without the `key` attribute.
Furthermore, the `App` component also renders a button which will run the `handleSwitchButtonClick` method when clicked.
The `handleSwitchButtonClick` method switches the order of the ReactComponentElements in the `ReactFragment`.

```javascript
// StatefulListItem.js
import React, { Component } from 'react';

class StatefulListItem extends Component {
  constructor(props) {
    super(props);
    this.state = { clicked: false };
    this.handleClick = this.handleClick.bind(this);
  }

  handleClick(event) {
    let nextClicked = !this.state.clicked;
    this.setState({ clicked: nextClicked });
  }

  render() {
    let text = this.props.name;

    if (this.state.clicked) {
      text += ' was clicked';
    }

    return <li onClick={this.handleClick}>{text}</li>;
  }
};

export default StatefulListItem;
```
The `StatefulListItem` renders an `li` ReactDOMElement.
The component is initialized with a state that has a `clicked` property set to false.
The text for the `li` element is based on the components props.
If the state's `clicked` property value is `true`, then it will also append `' was clicked'` to the text.
The `li` element has an click event listener on it that invokes the `handleClick` method.
The `handleClick` method changes the `clicked` property value to the opposite boolean value.

Running our Webpack Development Server and visiting [localhost:8080][localhost-8080] will display the following in your browser.

![React Stateful Components Photo 11][react-stateful-components-photo-11]

Clicking on the first `li` element twice will transition the page as such:

![React Stateful Components Photo 12][react-stateful-components-photo-12]

Clicking on the `button` element twice will transition the page as such:

![React Stateful Components Photo 13][react-stateful-components-photo-13]

So far the behavior is as expected.
However, if we click the first `li` element once and then click the `button` element, the page will transition as such:

![React Stateful Components Photo 14][react-stateful-components-photo-14]

The expected behavior would be for "item one" to maintain its clicked state after being moved to the bottom.
However, it seems like the clicked state remained with the top `li` element.
This occurs because whenever React updates children elements without a `key` property, it does so by mutating the elements.
Unfortunately, when React updates the DOM through mutation, the identity and state of stateful children elements are not kept in-sync with each other.
To fix this problem, we simply add a `key` property whenever we create a `StatefulListItem` ReactComponentElement.
We update the following code in `App.js` from:

```javascript
firstStatefulListItem = <StatefulListItem name={firstListItem.name} />;
secondStatefulListItem = <StatefulListItem name={secondListItem.name} />;
```

to:

```javascript
firstStatefulListItem = <StatefulListItem key={firstListItem.id} name={firstListItem.name} />;
secondStatefulListItem = <StatefulListItem key={secondListItem.id} name={secondListItem.name} />;
```

After we make the following change, the children identity and state are maintained across render passes.
We now get the expected behavior when we click on an `li` element and click the `button` element.

![React Stateful Components Photo 15][react-stateful-components-photo-15]

To clarify, we did not have any problems in the first two examples in this section because these problems arise whenever you have stateful children elements with different states changing position.
In the first example, the children elements were not changing position.
In the second example, the state of both children elements were identical.
Now that we know about stateful components, let's go ahead and use them in our grocery list application to make it functional.

## Following Along - Third Code Example
We will be working on [this React application][react-stateful-components-repository].
To get quickly set up, run the following:

```sh
$ git clone https://github.com/LaunchAcademy/react-stateful-components.git
$ cd react-stateful-components
$ npm install
$ webpack-dev-server
```

## Using Stateful Components in React Grocery List

As a reminder, we been tasked with creating a grocery list React application that matches the following design:

![Grocery List React Design][grocery-list-react-design]

So far, our project renders the following static page using React components:

![Grocery List React No Styling][grocery-list-react-no-styling]

First, we must identify what data changes in the application to keep the UI up-to-date.
In this application, groceries can be added and deleted, so the data for the groceries must be in a component's state.
The second task is to identify which component holds the state for the grocery data.
Each `Grocery` component receives the data to display a single grocery from `GroceryList`, and in turn, the `GroceryList` component receives the data for all the groceries from the `App` component.
Hence, `App` would be good candidate to hold the grocery data in its state because if the data changes, then it will simply give the updated data to the `GroceryList` component and the page will show the updated groceries.
Let's start by changing our `App` component from this:

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
to the following stateful class component:

```javascript
// App.js
import React, { Component } from 'react';
import GroceryForm from './GroceryForm';
import GroceryList from './GroceryList';

class App extends Component {
  constructor(props) {
    super(props);
    this.state = {
      groceries: []
    };

    this.handleFormSubmit = this.handleFormSubmit.bind(this);
    this.handleButtonClick = this.handleButtonClick.bind(this);
  }

  handleFormSubmit(event) {
    event.preventDefault();
    alert('Form was submitted');
  }

  handleButtonClick(event) {
    alert('Button was clicked');
  }

  render() {
    return(
      <div>
        <h1>Grocery List React</h1>
        <GroceryForm handleFormSubmit={this.handleFormSubmit} />
        <GroceryList
          groceries={this.state.groceries}
          handleButtonClick={this.handleButtonClick}
        />
      </div>
    );
  }
}

export default App;
```
We have removed the static grocery data that was being used to render our components.
Instead, we are now using the `groceries` property in our `App` component's state for our data.
We initially set the `groceries` property to an empty array, and thus our grocery application initially does not display any groceries.

![React Stateful Components Photo 19][react-stateful-components-photo-19]

Having successfully, updated our `App` component to have state, let's now focus now on adding some groceries to our application via the form.

We currently have a problem in our `GroceryForm` component though.

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

On initial rendering, both the virtual DOM and browser DOM have a text `input` element with no value.
If a user types "avocados" into the browser, however, the text `input` element will now have a value of "avocados" in the browser DOM, but the virtual DOM's text `input` will still have no value.
Therefore, our virtual DOM and browser DOM no longer match each other.
A quick fix would be to hard-code the value in the input like so:

```javascript
// App.js
...

class App extends Component {
  ...

  render() {
    return(
      <div>
        <h1>Grocery List React</h1>
        <GroceryForm handleFormSubmit={this.handleFormSubmit} name="avocados" />
        <GroceryList
          groceries={this.state.groceries}
          handleButtonClick={this.handleButtonClick}
        />
      </div>
    );
  }
}

export default App;
```

```javascript
// GroceryForm.js
import React from 'react';

const GroceryForm = props => {
  return (
    <form onSubmit={props.handleFormSubmit}>
      <input type="text" placeholder="name of grocery" value={props.name} />
      <input type="submit" value="Add To List" />
    </form>
  );
};

export default GroceryForm;
```

Our `App` component is now passing a `name` property down to the `GroceryForm` component, and the `GroceryForm` component is now rendering a text `input` element with the value of the `name` property.
In this example, the application is now initially rendered with "avocados" for the value of the text `input` for both the virtual and browser DOMs.

![React Stateful Components Photo 16][react-stateful-components-photo-16]

We now have a new problem though.
If a user tries to type in something to the text `input` field, the text remains as "avocados".
The good news is that the virtual and browser DOMs are still matching, but we now need to respond to a user typing into the text `input` field.
We can do this by adding another property to our `App` component's state and passing another event handler to the `GroceryForm` component. This event handler will watch for changes in the form field's value and update the state accordingly.

```javascript
// App.js
...

class App extends Component {
  constructor(props) {
    ...
    this.handleChange = this.handleChange.bind(this);
  }

  ...

  handleChange(event) {
    let newName = event.target.value;
    this.setState({ name: newName });
  }

  render() {
    console.log("App's state name value: ", this.state.name);
    return(
      <div>
        <h1>Grocery List React</h1>
        <GroceryForm
          handleFormSubmit={this.handleFormSubmit}
          handleChange={this.handleChange}
          name={this.state.name}
        />
        <GroceryList
          groceries={this.state.groceries}
          handleButtonClick={this.handleButtonClick}
        />
      </div>
    );
  }
}

export default App;
```

```javascript
// GroceryForm.js
import React from 'react';

const GroceryForm = props => {
  return (
    <form onSubmit={props.handleFormSubmit}>
      <input
        type="text"
        placeholder="name of grocery"
        value={props.name}
        onChange={props.handleChange}
      />
      <input type="submit" value="Add To List" />
    </form>
  );
};

export default GroceryForm;
```
A `name` property has been added to the `App` component's state and with an initial value of an empty string.
The `name` property is now passed down to the `GroceryForm` component instead of a constant value.
Also, the `handleChange` event handler is passed down to `GroceryForm` and is invoked any time there is a change on the text `input` field.
When `handleChange` is run, the `name` property of the `App` component's state is updated to be the value of the text `input` field.

To better visualize how the `name` property in the `App` component's state changes as a user types, we have added a `console.log` in the beginning of the `App` component's render method.
If you open up your browser and type in "avocados" while you have your console open, you will see the following:

![React Stateful Components Photo 17][react-stateful-components-photo-17]

Great! A user can now type into our text `input` field and our virtual and browser DOMs are still in-sync.
What about a user submitting a new grocery?
The `App` component essentially has access to the text in the text `input` field via the `name` property in it's state, so updating our `handleSubmit` function is actually pretty straightforward.
We make the following changes to our code:

```javascript
// App.js
...

class App extends Component {
  ...

  handleFormSubmit(event) {
    event.preventDefault();
    let newGrocery = {
      id: Date.now(),
      name: this.state.name
    };
    let newGroceries = [...this.state.groceries, newGrocery];
    this.setState({
      groceries: newGroceries,
      name: ''
    });
  }

  ...
}

export default App;
```

First, we prevent the default behavior of form submission.
Then a grocery object is created with the name from the text `input` field.
It should have a unique id which should come from a database, but since we are not hitting any APIs yet, using the value from `Date.now()` will suffice.
We then create a new array using the current `groceries` in the `App` component's state and append the grocery object we just created.
The last step is to update the component's state with the new groceries and setting the `name` property to an empty string to clear the text `input` field.
If we now go to the application, we should now be able to submit grocery items.

![React Stateful Components Photo 18][react-stateful-components-photo-18]

Boom!

Finally we want to be able to delete groceries.
We will update our `handleButtonClick` event handler and `GroceryList` component to accomplish this.

```javascript
// App.js
...

class App extends Component {
  ...

  handleButtonClick(id) {
    let newGroceries = this.state.groceries.filter(grocery => {
      return grocery.id !== id;
    });
    this.setState({ groceries: newGroceries });
  }

  ...
}

export default App;
```

```javascript
// GroceryList.js
import React from 'react';
import Grocery from './Grocery';

const GroceryList = props => {
  let groceries = props.groceries.map(grocery => {
    const { id, name } = grocery;
    let onButtonClick = () => props.handleButtonClick(id);

    return (
      <Grocery
        key={id}
        name={name}
        handleButtonClick={onButtonClick}
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

In our `handleButtonClick` we create a new array of groceries that does not include the grocery whose id was given as an argument to the function.
Then we set the new state of the `App` component using this new array of groceries.
In our `GroceryList`, we create a curried `onButtonClick` function that calls our our event handler with the grocery id.
The curried function is passed as props to the created `Grocery` component.
By using a curried function, the `GroceryComponent` can simply invoke the function without any arguments when the delete button is clicked.
If we go back to our browser now, we are able to delete grocery items!

![React Stateful Components Photo 19][react-stateful-components-photo-19]

See ya avocados!

The final code for all our components is as follows:

```javascript
// App.js
import React, { Component } from 'react';
import GroceryForm from './GroceryForm';
import GroceryList from './GroceryList';

class App extends Component {
  constructor(props) {
    super(props);
    this.state = {
      groceries: [],
      name: ''
    };

    this.handleFormSubmit = this.handleFormSubmit.bind(this);
    this.handleButtonClick = this.handleButtonClick.bind(this);
    this.handleChange = this.handleChange.bind(this);
  }

  handleFormSubmit(event) {
    event.preventDefault();
    let newGrocery = {
      id: Date.now(),
      name: this.state.name
    };
    let newGroceries = [...this.state.groceries, newGrocery];
    this.setState({
      groceries: newGroceries,
      name: ''
    });
  }

  handleButtonClick(id) {
    let newGroceries = this.state.groceries.filter(grocery => {
      return grocery.id !== id;
    });
    this.setState({ groceries: newGroceries });
  }

  handleChange(event) {
    let newName = event.target.value;
    this.setState({ name: newName });
  }

  render() {
    return(
      <div>
        <h1>Grocery List React</h1>
        <GroceryForm
          handleFormSubmit={this.handleFormSubmit}
          handleChange={this.handleChange}
          name={this.state.name}
        />
        <GroceryList
          groceries={this.state.groceries}
          handleButtonClick={this.handleButtonClick}
        />
      </div>
    );
  }
}

export default App;
```

```javascript
// GroceryForm.js
import React from 'react';

const GroceryForm = props => {
  return (
    <form onSubmit={props.handleFormSubmit}>
      <input
        type="text"
        placeholder="name of grocery"
        value={props.name}
        onChange={props.handleChange}
      />
      <input type="submit" value="Add To List" />
    </form>
  );
};

export default GroceryForm;
```

```javascript
// GroceryList.js
import React from 'react';
import Grocery from './Grocery';

const GroceryList = props => {
  let groceries = props.groceries.map(grocery => {
    const { id, name } = grocery;
    let onButtonClick = () => props.handleButtonClick(id);

    return (
      <Grocery
        key={id}
        name={name}
        handleButtonClick={onButtonClick}
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

## Summary

Stateful components allow us to make our pages dynamic so they respond to UI events, server events, and the passage of time.
These components are able to do this because they have state, which is data that is also used in the creation virtual DOM representations.
What makes this data different than data from props is that it can be changed in response to events.
Whenever a component updates its state, our React application utilizes the React library to generate a new updated virtual DOM.
This new virtual DOM is compared against the previous virtual DOM, and if there are any differences between these virtual DOMs, then the ReactDOM library will update our browser DOM, so it is up-to-date with our new virtual DOM.
With this knowledge of stateful components, you are now fully equipped to create dynamic React applications.

## Additional Resources
* [React Docs: ES6 Syntax for Stateful Components][react-stateful-component-es6-syntax]
* [React Blog: ES6 Class Syntax Announcement][react-blog-es6-syntax-announcement]
* [React Docs: Interactivity and Dynamic UIs][react-interactivity-and-dynamic-uis]
* [React Docs: Forms][react-forms]
* [React Docs: Reconciliation][react-reconciliation]
* [React Docs: Child Reconciliation][react-child-reconciliation]
* [React Docs: Thinking In React][react-docs-thinking-in-react]

[grocery-list-react-design]: https://s3.amazonaws.com/horizon-production/images/grocery_list_react.png
[grocery-list-react-no-styling]: https://s3.amazonaws.com/horizon-production/images/grocery_list_react_no_styling.png
[introduction-to-es6-classes]: https://learn.launchacademy.com/lessons/introduction-to-es6#classes
[localhost-8080]: http://localhost:8080
[react-blog-es6-syntax-announcement]: https://facebook.github.io/react/blog/2015/01/27/react-v0.13.0-beta-1.html#plain-javascript-classes
[react-child-reconciliation]: https://facebook.github.io/react/docs/multiple-components.html#child-reconciliation
[react-docs-thinking-in-react]: https://facebook.github.io/react/docs/thinking-in-react.html
[react-forms]: http://facebook.github.io/react/docs/forms.html
[react-fragment-example-repository]: https://github.com/LaunchAcademy/react-stateful-components-react-fragment-example.git
[react-interactivity-and-dynamic-uis]: http://facebook.github.io/react/docs/interactivity-and-dynamic-uis.html
[react-reconciliation]: https://facebook.github.io/react/docs/reconciliation.html
[react-stateful-component-es6-syntax]: https://facebook.github.io/react/docs/reusable-components.html#es6-classes
[react-stateful-components-photo-1]: https://s3.amazonaws.com/horizon-production/images/react-stateful-components-photo-1.png
[react-stateful-components-photo-2]: https://s3.amazonaws.com/horizon-production/images/react-stateful-components-photo-2.png
[react-stateful-components-photo-3]: https://s3.amazonaws.com/horizon-production/images/react-stateful-components-photo-3.png
[react-stateful-components-photo-4]: https://s3.amazonaws.com/horizon-production/images/react-stateful-components-photo-4.png
[react-stateful-components-photo-5]: https://s3.amazonaws.com/horizon-production/images/react-stateful-components-photo-5.png
[react-stateful-components-photo-6]: https://s3.amazonaws.com/horizon-production/images/react-stateful-components-photo-6.png
[react-stateful-components-photo-7]: https://s3.amazonaws.com/horizon-production/images/react-stateful-components-photo-7.png
[react-stateful-components-photo-8]: https://s3.amazonaws.com/horizon-production/images/react-stateful-components-photo-8.png
[react-stateful-components-photo-9]: https://s3.amazonaws.com/horizon-production/images/react-stateful-components-photo-9.png
[react-stateful-components-photo-10]: https://s3.amazonaws.com/horizon-production/images/react-stateful-components-photo-10.png
[react-stateful-components-photo-11]: https://s3.amazonaws.com/horizon-production/images/react-stateful-components-photo-11.png
[react-stateful-components-photo-12]: https://s3.amazonaws.com/horizon-production/images/react-stateful-components-photo-12.png
[react-stateful-components-photo-13]: https://s3.amazonaws.com/horizon-production/images/react-stateful-components-photo-13.png
[react-stateful-components-photo-14]: https://s3.amazonaws.com/horizon-production/images/react-stateful-components-photo-14.png
[react-stateful-components-photo-15]: https://s3.amazonaws.com/horizon-production/images/react-stateful-components-photo-15.png
[react-stateful-components-photo-16]: https://s3.amazonaws.com/horizon-production/images/react-stateful-components-photo-16.png
[react-stateful-components-photo-17]: https://s3.amazonaws.com/horizon-production/images/react-stateful-components-photo-17.png
[react-stateful-components-photo-18]: https://s3.amazonaws.com/horizon-production/images/react-stateful-components-photo-18.png
[react-stateful-components-photo-19]: https://s3.amazonaws.com/horizon-production/images/react-stateful-components-photo-19.png
[react-synthetic-event]: https://facebook.github.io/react/docs/events.html#syntheticevent
[stateful-component-example-repository]: https://github.com/LaunchAcademy/react-stateful-components-stateful-component-example.git
[react-stateful-components-repository]: https://github.com/LaunchAcademy/react-stateful-components.git
