## Learning Objectives
* Understand the purpose of the Enzyme library.
* Setup Enzyme with Karma and Jasmine.
* Learn to test React components with Enzyme.

## Introduction
By using Karma with Jasmine, we are able to test our JavaScript code. However,
how do we test a React component? It is technically possible to make assertions
on the return value of a React function component or on the object created by a
React class component. Yet, in our application we use React components to
create ReactComponentElements which is what is used by ReactDOM to render our
application, and therefore, we should make assertions on the
ReactComponentElements created by the React components rather than the React
components themselves. Having to make assertions on ReactComponentElements,
however, makes writing tests more difficult because we would have to look at
the React source code to properly understand how the rendered tree of a
ReactComponentElement is generated and how to traverse it in order to
be able to test it (i.e.  `ReactElement`s do not have a `render` method, so we
would have to look at the source code to figure out how to generate a
`ReactElement`'s rendered tree).

The React authors addressed the difficulty of testing React components by
creating the [Test Utilities][react-docs-test-utils] add-on. This add-on not
only gives us the ability to test `ReactElement`s created from React component
definitions, but also gives us to capability to more easily traverse rendered
trees, simulate events, and optionally render our components onto a DOM to test
lifecycle methods. Unfortunately, the API of the Test Utilities Add-On is quite
minimal and writing tests for React components is still quite the chore if you
only use this add-on. Luckily, the engineers at Airbnb wrote the
[Enzyme][enzyme-docs] library to make it easier to write tests for React
components. This library uses the Test Utilities add-on under the hood, but its
API is significantly more intutive and flexible. Let's go ahead and setup Enzyme
with the Karma and Jasmine test suite found in [this
repository][testing-react-components-repository].

## Setup
To install enzyme run the following:

```sh
npm install --save-dev enzyme react-addons-test-utils
```

This installs both the enzyme library and the [`react-addons-test-utils`][react-docs-test-utils] peer dependency.
Then add the `externals` property to the `webpack` property in our `karma.conf.js` file:

```javascript
// karma.conf.js
...
  // webpack configuration used by karma-webpack
  webpack: {
    // generate sourcemaps
    devtool: 'eval-source-map',
    // enzyme-specific setup
    externals: {
      'cheerio': 'window',
      'react/addons': true,
      'react/lib/ExecutionEnvironment': true,
      'react/lib/ReactContext': true
    },
    module: {
      loaders: [
        // use babel-loader to transpile the test and src folders
        {
          test: /\.jsx?$/,
          exclude: /node_modules/,
          loader: 'babel'
        },
        // use isparta-loader for ES6 code coverage in the src folder
        {
          test: /\.jsx?$/,
          exclude: /(node_modules|test)/,
          loader: 'isparta'
        }
      ]
    },

    // relative path starts out at the src folder when importing modules
    resolve: {
      root: path.resolve('./src')
    }
  },
...
```

This change in our `karma.conf.js` is necessary because we need to ignore
certain files when we are [using Enzyme with
Webpack][enzyme-docs-using-enzyme-with-webpack].

At this point, we are all set up to use Enzyme. However, we will also install
[`jasmine-enzyme`][npm-jasmine-enzyme] which adds custom Jasmine matchers that
come in handy when testing our React components with Enzyme. To install we run:

```sh
$ npm install --save-dev jasmine-enzyme
```

Now that the setup is done, let's start writing some tests for our components.

## Testing a React Application
The relevant files in our application are:

```javascript
// main.js
import 'babel-polyfill';
import './main.scss';
import React from 'react';
import ReactDOM from 'react-dom';
import CapybaraContainer from './components/CapybaraContainer';

ReactDOM.render(
  <CapybaraContainer />,
  document.getElementById('app')
);
```

```javascript
// src/components/CapybaraContainer.js
import React, { Component } from 'react';
import Capybara from './Capybara';

class CapybaraContainer extends Component {
  constructor(props) {
    super(props);
    this.state = { hasBird: false };
    this.handleClick = this.handleClick.bind(this);
  }

  componentDidMount() {
    alert('click on the Capybara!');
  }

  handleClick() {
    let nextHasBird = !this.state.hasBird;
    this.setState({ hasBird: nextHasBird });
  }

  render() {
    let image, text;

    if (this.state.hasBird) {
      image = 'http://tinyurl.com/zkgcwed';
      text = 'Capybara with bird friend!';
    } else {
      image = 'http://tinyurl.com/jefhp9q';
      text = 'Sleepy Capybara';
    }

    return (
      <div>
        <Capybara
          image={image}
          onClick={this.handleClick}
          text={text}
        />
      </div>
    );
  }
}

export default CapybaraContainer;
```

```javascript
// src/components/Capybara.js
import React from 'react';

const Capybara = props => {
  const { image, onClick, text } = props;

  return (
    <div onClick={onClick} className="center">
      <img src={image} height="400" width="600" />
      <h1>{text}</h1>
    </div>
  );
};

export default Capybara;
```

Upon visiting the site, an alert box pops up telling us to "click on the Capybara!":

![Testing React Components 1][testing-react-components-1]

After, we click "OK". We see the initial state of our application:

![Testing React Components 2][testing-react-components-2]

Clicking on the capybara changes the state of our application to:

![Testing React Components 3][testing-react-components-3]

If we click on the capybara again, we go back to the initial state:

![Testing React Components 2][testing-react-components-2]

### Testing Stateless React Components

This application is untested, so let's start to fix that by first writing a test
for the `Capybara` component, which is shown here again for convenience:

```javascript
// src/components/Capybara.js
import React from 'react';

const Capybara = props => {
  const { image, onClick, text } = props;

  return (
    <div onClick={onClick} className="center">
      <img src={image} height="400" width="600" />
      <h1>{text}</h1>
    </div>
  );
};

export default Capybara;
```

We begin with the following test:

```javascript
// test/components/Capybara.js
import Capybara from 'components/Capybara';
import { shallow } from 'enzyme';
import React from 'react';

describe('Capybara', () => {
  let image,
      onClick,
      text,
      wrapper;

  beforeEach(() => {
    onClick = () => {};
    wrapper = shallow(
      <Capybara
        image="http://fakeurl.com/capybara"
        onClick={onClick}
        text="I am a Capybara!"
      />
    );
  });

  it('should render an h1 tag', () => {
    expect(wrapper.find('h1').length).toEqual(1);
  });

  it('should render an h1 tag with the text property value', () => {
    expect(wrapper.find('h1').text()).toBe('I am a Capybara!');
  });
});
```

We import the `shallow` method from the Enzyme library. This method takes in a
`ReactElement` which represents a component and returns a `shallowWrapper`
object. The [`shallowWrapper` API][enzyme-docs-shallow-rendering-api] will allow
us to traverse the "shallow" render output of our `ReactElement`. The render
output is referred to as "shallow" because the rendered tree will include all
the `ReactElement`s representing DOM elements and child components, but it will
not include the rendered trees of the child components.  This is advantageous
because this allows unit testing of a parent component even though the child
components may not be fully implemented and/or may have bugs. Furthermore,
"shallow" rendered components are not mounted, so the tests run faster because
no DOM manipulation is needed. We will further discuss the topic of "shallow"
rendering when we write our test for the `CapybaraContainer` component which
renders a child component.

The most useful method on the `shallowWrapper` object is the [`find`
method][enzyme-docs-shallow-rendering-api-find] which takes in a string of the
HTML tag or a React Component function that you want to find in the rendered
tree and returns another `shallowWrapper` containing the matching nodes. In our
first test, we see if our `Capybara` component renders one `h1` element.
Another, useful method is the `text` method which returns a `String`
representation of the text nodes in the wrapper. The second test is asserting
that the text in the `h1` element matches the `text` property value from the the
`props` of our `Capybara` component. These tests describe our current
implementation, so they are passing.

Our test asserting the presence of a rendered `h1` element works, but it does
not read well. We can use the `jasmine-enzyme` library that we installed so we
can use matchers that will increase the readability of our tests. We make the
following changes to our test:

```javascript
// test/components/Capybara.js
import Capybara from 'components/Capybara';
import { shallow } from 'enzyme';
import jasmineEnzyme from 'jasmine-enzyme';
import React from 'react';

describe('Capybara', () => {
  ...

  beforeEach(() => {
    jasmineEnzyme();
    onClick = () => {};
    ...
  });

  it('should render an h1 tag', () => {
    expect(wrapper.find('h1')).toBePresent();
  });

  ...
});
```

Here we imported the `jasmine-enzyme` library, and invoked the `jasmineEnzyme`
function before each of our tests. This allows us to use the [`toBePresent`
matcher][jasmine-enzyme-tobepresent] which asserts for the presence of at least
one node in the wrapper.

We can also test that the rendered `ReactElement`s have certain `props`.
The following spec is added to our test file:

```javascript
// test/components/Capybara.js
...

describe('Capybara', () => {
  ...

  beforeEach(() => {
    jasmineEnzyme();
    onClick = () => {};
    wrapper = shallow(
      <Capybara
        image="http://fakeurl.com/capybara"
        onClick={onClick}
        text="I am a Capybara!"
      />
    );
  });

  ...

  it('should render an img tag with the specific props', () => {
    expect(wrapper.find('img').props()).toEqual({
      src: 'http://fakeurl.com/capybara',
      height: '400',
      width: '600'
    });
  });
});
```

The [`props` method][enzyme-docs-shallow-rendering-api-props] can only be called on the wrapper of a single `ReactElement`,
and it will return the `props` of the `ReactElement`. Awesome, but how about
testing event handlers?? For example, the `onClick` property of the `Capybara`
`props` should be invoked when the component is clicked. We can actually simulate
events on wrappers using the [`simulate` method][enzyme-docs-shallow-rendering-api-simulate]:

```javascript
// test/components/Capybara.js
...

describe('Capybara', () => {
  ...

  beforeEach(() => {
    jasmineEnzyme();
    onClick = jasmine.createSpy('onClick spy');
    wrapper = shallow(
      <Capybara
        image="http://fakeurl.com/capybara"
        onClick={onClick}
        text="I am a Capybara!"
      />
    );
  });

  ...

  it('should invoke the onClick function from props when clicked', () => {
    wrapper.simulate('click');
    expect(onClick).toHaveBeenCalled();
  });
});
```

The `simulate` method takes in the event name as a string for its first argument
and an event data as an optional second argument. Notice also that we have changed
our `onClick` declaration from an empty function to a spy using
[`jasmine.createSpy`][jasmine-docs-createspy] so we can assert that the function
is called when the wrapper is clicked. We are now done testing
our `Capybara` component. Let's move on to testing our `CapybaraContainer`
stateful component!

### Testing Stateful React Components

We will now write tests for the `CapybaraContainer` whose code is shown here
again for convenience:

```javascript
// src/components/CapybaraContainer.js
import React, { Component } from 'react';
import Capybara from './Capybara';

class CapybaraContainer extends Component {
  constructor(props) {
    super(props);
    this.state = { hasBird: false };
    this.handleClick = this.handleClick.bind(this);
  }

  componentDidMount() {
    alert('click on the Capybara!');
  }

  handleClick() {
    let nextHasBird = !this.state.hasBird;
    this.setState({ hasBird: nextHasBird });
  }

  render() {
    let image, text;

    if (this.state.hasBird) {
      image = 'http://tinyurl.com/zkgcwed';
      text = 'Capybara with bird friend!';
    } else {
      image = 'http://tinyurl.com/jefhp9q';
      text = 'Sleepy Capybara';
    }

    return (
      <div>
        <Capybara
          image={image}
          onClick={this.handleClick}
          text={text}
        />
      </div>
    );
  }
}

export default CapybaraContainer;
```

Let's first write a few tests to assert the initial state of our component
and that we are rendering a `Capybara` component with specific props:

```javascript
// test/components/CapybaraContainer.js
import CapybaraContainer from 'components/CapybaraContainer';
import Capybara from 'components/Capybara';
import { shallow } from 'enzyme';
import jasmineEnzyme from 'jasmine-enzyme';
import React from 'react';

describe('CapybaraContainer', () => {
  let wrapper;

  beforeEach(() => {
    jasmineEnzyme();
    wrapper = shallow(<CapybaraContainer />);
  });

  it('should should have the specified inital state', () => {
    expect(wrapper.state()).toEqual({ hasBird: false });
  });

  it('should render an Capybara Component', () => {
    expect(wrapper.find(Capybara)).toBePresent();
  });

  it('should render the Capybara Component with specific props when hasBird is false', () => {
    expect(wrapper.find(Capybara).props()).toEqual({
      image: 'http://tinyurl.com/jefhp9q',
      onClick: jasmine.any(Function),
      text: 'Sleepy Capybara'
    });
  });
});
```

Here we use the [`state` method][enzyme-docs-shallow-rendering-api-state] to get
the current state of our wrapper, and assert that it matches the initial state.
In the second test, we are passing in a component function to the `find` method
instead of a string because we are looking for a component, and in the last test
we are asserting the props that are passed to the `Capybara` component when the
state is the initial state.  Great, but the `CapybaraContainer` will pass
different props to the `Capybara` component when its state changes, so how do we
test that? We can test this by using the [`setState`
method][enzyme-docs-shallow-rendering-api-setstate] like so:

```javascript
// test/components/CapybaraContainer.js
import CapybaraContainer from 'components/CapybaraContainer';
import Capybara from 'components/Capybara';
import { shallow } from 'enzyme';
import jasmineEnzyme from 'jasmine-enzyme';
import React from 'react';

describe('CapybaraContainer', () => {
  ...

  it('should render the Capybara Component with specific props when hasBird is true', () => {
    wrapper.setState({ hasBird: true });
    expect(wrapper.find(Capybara).props()).toEqual({
      image: 'http://tinyurl.com/zkgcwed',
      onClick: jasmine.any(Function),
      text: 'Capybara with bird friend!'
    });
  });
});
```

In this spec, we just change the state of the wrapper, and assert that the
appropriate props are now passed.

In the last two tests, we have simply asserted that the `props` that we are
passing to the `Capybara` component includes an `onClick` property that is
simply a function. However, we should test that this function calls the
`handleClick` method and it updates the state of the `CapybaraContainer`
component when it is invoked. We can do this with the help of Jasmine spies:

```javascript
// test/components/CapybaraContainer.js
...

describe('CapybaraContainer', () => {
  let wrapper;

  beforeEach(() => {
    jasmineEnzyme();
    spyOn(CapybaraContainer.prototype, 'handleClick').and.callThrough();
    wrapper = shallow(<CapybaraContainer />);
  });

  ...

  describe('handleClick', () => {
    it('should be invoked when the function assigned to the onClick propety of the Capybara props is executed', () => {
      wrapper.find(Capybara).props().onClick();
      expect(CapybaraContainer.prototype.handleClick).toHaveBeenCalled();
    });

    it('should change the hasBird property in the state to the opposite boolean value', () => {
      wrapper.find(Capybara).props().onClick();
      expect(wrapper.state()).toEqual({ hasBird: true });
    });
  });
});
```

In the `beforeEach` function, we create a spy on the `handleClick` method of our
component that still delegates to the actual implementation. We then write a
test that invokes the `onClick` property of the `props` passed to the `Capybara`
component and expect our spy to have been called. We also wrote another test
which asserts that our state has changed as expected when this method is called.
We have tested everything in our component except our `componentDidMount`
method, but we will have to actually mount our component on a DOM to actually
test this method.

### Shallow Rendering vs. Full DOM Rendering
The `componentDidMount` is a React lifecycle method that gets called when the
component is placed on the DOM. Unfortunately, we cannot test this method using
a shallow wrapper because shallow rendered components are not placed on a DOM,
and hence, `componentDidMount` will never actually be invoked. Fortunately, we
can render components on a DOM using the `mount` method from the Enzyme library.
This method takes takes in a `ReactElement` which represents a component and
returns a `ReactWrapper` object. The [`ReactWrapper`
API][enzyme-docs-full-rendering-api] is very similar to the `shallowWrapper`
API, but do realize that there are differences. We change our test file as
follows and write a couple of specs to test our `componentDidMount` method using
a `reactWrapper`:

```javascript
// test/components/CapybaraContainer.js
import CapybaraContainer from 'components/CapybaraContainer';
import Capybara from 'components/Capybara';
import { shallow, mount } from 'enzyme';
import jasmineEnzyme from 'jasmine-enzyme';
import React from 'react';

describe('CapybaraContainer', () => {
  let wrapper;

  beforeEach(() => {
    jasmineEnzyme();
  });

  describe('shallow rendered component', () => {
    beforeEach(() => {
      spyOn(CapybaraContainer.prototype, 'handleClick').and.callThrough();
      wrapper = shallow(<CapybaraContainer />);
    });

    it('should should have the specified inital state', () => {
      expect(wrapper.state()).toEqual({ hasBird: false });
    });

    it('should render an Capybara Component', () => {
      expect(wrapper.find(Capybara)).toBePresent();
    });

    it('should render the Capybara Component with specific props when hasBird is false', () => {
      expect(wrapper.find(Capybara).props()).toEqual({
        image: 'http://tinyurl.com/jefhp9q',
        onClick: jasmine.any(Function),
        text: 'Sleepy Capybara'
      });
    });

    it('should render the Capybara Component with specific props when hasBird is true', () => {
      wrapper.setState({ hasBird: true });
      expect(wrapper.find(Capybara).props()).toEqual({
        image: 'http://tinyurl.com/zkgcwed',
        onClick: jasmine.any(Function),
        text: 'Capybara with bird friend!'
      });
    });

    describe('handleClick', () => {
      it('should be invoked when the function assigned to the onClick propety of the Capybara props is executed', () => {
        wrapper.find(Capybara).props().onClick();
        expect(CapybaraContainer.prototype.handleClick).toHaveBeenCalled();
      });

      it('should change the hasBird property in the state to the opposite boolean value', () => {
        wrapper.find(Capybara).props().onClick();
        expect(wrapper.state()).toEqual({ hasBird: true });
      });
    });
  });


  describe('full DOM rendered component', () => {
    beforeEach(() => {
      spyOn(CapybaraContainer.prototype, 'componentDidMount').and.callThrough();
      spyOn(global, 'alert');
      wrapper = mount(<CapybaraContainer />);
    });

    it('should invoke componentDidMount', () => {
      expect(CapybaraContainer.prototype.componentDidMount).toHaveBeenCalled();
    });

    it('should invoke alert', () => {
      expect(alert).toHaveBeenCalledWith('click on the Capybara!');
    });
  });
});
```

We re-organized our file to use two additional `describe` functions so we can
separate our specs that use a `shallowWrapper` from the specs that use a
`ReactWrapper`. Pay attention to the fact that the `mount` method is now also
being imported from the `enzyme` pacakges at the top of our file now. For a full
DOM rendered component, we created a spy on the `componentDidMount` function to
ensure that it was defined and is invoked when the component mounts. We also
created a spy on the global `alert` method and wrote an additional spec that
expects it to be called with a specific string. We are now done testing our
`CapybaraContainer` component. For educational purposes, however, let's write a
few additional specs so we can better understand the difference between shallow
rendering and full DOM rendering:

```javascript
// test/components/CapybaraContainer.js
...

describe('CapybaraContainer', () => {
  let wrapper;

  beforeEach(() => {
    jasmineEnzyme();
  });

  describe('shallow rendered component', () => {
    beforeEach(() => {
      spyOn(CapybaraContainer.prototype, 'handleClick').and.callThrough();
      spyOn(CapybaraContainer.prototype, 'componentDidMount').and.callThrough();
      wrapper = shallow(<CapybaraContainer />);
    });

    ...

    it('should not invoke componentDidMount', () => {
      expect(CapybaraContainer.prototype.componentDidMount).not.toHaveBeenCalled();
    });

    it('should not render the rendered tree of the Capybara component', () => {
      expect(wrapper.find(Capybara).find('h1')).not.toBePresent();
    });
  });


  describe('full DOM rendered component', () => {
    beforeEach(() => {
      spyOn(CapybaraContainer.prototype, 'componentDidMount').and.callThrough();
      spyOn(global, 'alert');
      wrapper = mount(<CapybaraContainer />);
    });

    ...

    it('should render the rendered tree of the Capybara component', () => {
      expect(wrapper.find(Capybara).find('h1')).toBePresent();
    });
  });
});
```

We created another spy for the `componentDidMount` method, but now on the
`shallowWrapper`. We also have a spec asserting that it is not invoked, and
it passes because shallow rendered components are not rendered into the DOM, and
thus, their lifecycle methods are not invoked. Shallow rendering also differs
from full DOM rendering in that the rendered tree of a child component is not
rendered. For example, our `Capybara` component renders an `h1` tag, but when we
shallow render the `CapybaraContainer` component, we will not find the `h1` tag
in our `shalloWrapper`. In contrast, our `ReactWrapper` does render the
rendered trees of child components, and we will see that the `h1` tag is present.
The other two specs that were written exemplify this behavior and automatically
pass. These last three specs were written for demonstrative purposes, and they
would not be present in test suites for real-live applications, so we will now
delete them as well as the spy for the `componentDidMount` method in the shallow
rendered component suite.

So you may wonder when to use shallow rendering and when to use full DOM
rendering. In general, use shallow rendering if you can. The tests will be more
efficient because no DOM manipulation is required and you can write tests for a
parent component even though it renders child components that may not be fully
implemented. You should only use full DOM rendering when you have to test React
lifecycle methods and/or any DOM manipulation.

## Cleaning Up the Test Suite
Currently, we have to import the same packages in every test file and execute
`jasmineEnzyme` in a `beforeEach` function if we want to use `jasmine-enzyme`
matchers. Luckily, we can modify our `test/testHelper.js` file so we do not have
to do this for every test file. We make the following changes:

```javascript
// test/testHelper.js
import { mount, shallow } from 'enzyme';
import jasmineEnzyme from 'jasmine-enzyme';
import React from 'react';

Object.assign(global, {
  mount,
  shallow,
  jasmineEnzyme,
  React
});

beforeEach(() => {
  jasmineEnzyme();
});

// function to require all modules for a given context
let requireAll = requireContext => {
  requireContext.keys().forEach(requireContext);
};

// require all js files except testHelper.js in the test folder
requireAll(require.context('./', true, /^((?!testHelper).)*\.jsx?$/));

// require all js files except main.js in the src folder
requireAll(require.context('../src/', true, /^((?!main).)*\.jsx?$/));

// output to the browser's console when the tests run
console.info(`TESTS RAN AT ${new Date().toLocaleTimeString()}`);
```

Now we change our test files from this:

```javascript
// test/components/Capybara.js
import Capybara from 'components/Capybara';
import { shallow } from 'enzyme';
import jasmineEnzyme from 'jasmine-enzyme';
import React from 'react';

describe('Capybara', () => {
  let image,
      onClick,
      text,
      wrapper;

  beforeEach(() => {
    jasmineEnzyme();
    onClick = jasmine.createSpy('onClick spy');
    wrapper = shallow(
      <Capybara
        image="http://fakeurl.com/capybara"
        onClick={onClick}
        text="I am a Capybara!"
      />
    );
  });

  it('should render an h1 tag', () => {
  ...
```

```javascript
// test/components/CapybaraContainer.js
import CapybaraContainer from 'components/CapybaraContainer';
import Capybara from 'components/Capybara';
import { shallow, mount } from 'enzyme';
import jasmineEnzyme from 'jasmine-enzyme';
import React from 'react';

describe('CapybaraContainer', () => {
  let wrapper;

  beforeEach(() => {
    jasmineEnzyme();
  });

  describe('shallow rendered component', () => {
  ...
```

to this:

```javascript
// test/components/Capybara.js
import Capybara from 'components/Capybara';

describe('Capybara', () => {
  let image,
      onClick,
      text,
      wrapper;

  beforeEach(() => {
    onClick = jasmine.createSpy('onClick spy');
    wrapper = shallow(
      <Capybara
        image="http://fakeurl.com/capybara"
        onClick={onClick}
        text="I am a Capybara!"
      />
    );
  });

  it('should render an h1 tag', () => {
  ...
```

```javascript
// test/components/CapybaraContainer.js
import CapybaraContainer from 'components/CapybaraContainer';
import Capybara from 'components/Capybara';

describe('CapybaraContainer', () => {
  let wrapper;

  describe('shallow rendered component', () => {
  ...
```

Nice!

## Final Files
For convenience, here are the final test files that were written in this article:

```javascript
// test/components/Capybara.js
import Capybara from 'components/Capybara';

describe('Capybara', () => {
  let image,
      onClick,
      text,
      wrapper;

  beforeEach(() => {
    onClick = jasmine.createSpy('onClick spy');
    wrapper = shallow(
      <Capybara
        image="http://fakeurl.com/capybara"
        onClick={onClick}
        text="I am a Capybara!"
      />
    );
  });

  it('should render an h1 tag', () => {
    expect(wrapper.find('h1')).toBePresent();
  });

  it('should render an h1 tag with the text property value', () => {
    expect(wrapper.find('h1').text()).toBe('I am a Capybara!');
  });

  it('should render an img tag with the specific props', () => {
    expect(wrapper.find('img').props()).toEqual({
      src: 'http://fakeurl.com/capybara',
      height: '400',
      width: '600'
    });
  });

  it('should invoke the onClick function from props when clicked', () => {
    wrapper.simulate('click');
    expect(onClick).toHaveBeenCalled();
  });
});
```

```javascript
// test/components/CapybaraContainer.js
import CapybaraContainer from 'components/CapybaraContainer';
import Capybara from 'components/Capybara';

describe('CapybaraContainer', () => {
  let wrapper;

  describe('shallow rendered component', () => {
    beforeEach(() => {
      spyOn(CapybaraContainer.prototype, 'handleClick').and.callThrough();
      wrapper = shallow(<CapybaraContainer />);
    });

    it('should should have the specified inital state', () => {
      expect(wrapper.state()).toEqual({ hasBird: false });
    });

    it('should render an Capybara Component', () => {
      expect(wrapper.find(Capybara)).toBePresent();
    });

    it('should render the Capybara Component with specific props when hasBird is false', () => {
      expect(wrapper.find(Capybara).props()).toEqual({
        image: 'http://tinyurl.com/jefhp9q',
        onClick: jasmine.any(Function),
        text: 'Sleepy Capybara'
      });
    });

    it('should render the Capybara Component with specific props when hasBird is true', () => {
      wrapper.setState({ hasBird: true });
      expect(wrapper.find(Capybara).props()).toEqual({
        image: 'http://tinyurl.com/zkgcwed',
        onClick: jasmine.any(Function),
        text: 'Capybara with bird friend!'
      });
    });

    describe('handleClick', () => {
      it('should be invoked when the function assigned to the onClick propety of the Capybara props is executed', () => {
        wrapper.find(Capybara).props().onClick();
        expect(CapybaraContainer.prototype.handleClick).toHaveBeenCalled();
      });

      it('should change the hasBird property in the state to the opposite boolean value', () => {
        wrapper.find(Capybara).props().onClick();
        expect(wrapper.state()).toEqual({ hasBird: true });
      });
    });
  });


  describe('full DOM rendered component', () => {
    beforeEach(() => {
      spyOn(CapybaraContainer.prototype, 'componentDidMount').and.callThrough();
      spyOn(global, 'alert');
      wrapper = mount(<CapybaraContainer />);
    });

    it('should invoke componentDidMount', () => {
      expect(CapybaraContainer.prototype.componentDidMount).toHaveBeenCalled();
    });

    it('should invoke componentDidMount', () => {
      expect(alert).toHaveBeenCalledWith('click on the Capybara!');
    });
  });
});
```

## Summary
Front-end applications tend to grow in complexity quite quickly as user
interfaces become more interactive and the size of your application state
increases. Testing your React application will allow you to better handle this
complexity because tests will enhance your focus by driving your development and
also inform you if new feature implementations have broken any existing
features. In this article, we introduced the Enzyme testing library, which has
an intiutive and flexibile API that makes it easy to test React components. By
using Enzyme, you will have the ability to develop new features in the
application via Test-Driven Development and increase the maintainability of your
React application.

## Additional Resources
* [Enzyme Docs][enzyme-docs]
* [Enzyme Docs: Shallow Rendering API][enzyme-docs-shallow-rendering-api]
* [Enzyme Docs: Full Rendering API][enzyme-docs-full-rendering-api]
* [Jasmine Enzyme Docs][npm-jasmine-enzyme]
* [React Docs: Test Utilities][react-docs-test-utils]

[enzyme-docs]: https://github.com/airbnb/enzyme
[enzyme-docs-full-rendering-api]: https://github.com/airbnb/enzyme/blob/master/docs/api/mount.md
[enzyme-docs-shallow-rendering-api]: https://github.com/airbnb/enzyme/blob/master/docs/api/shallow.md
[enzyme-docs-shallow-rendering-api-find]: https://github.com/airbnb/enzyme/blob/master/docs/api/shallow.md#findselector--shallowwrapper
[enzyme-docs-shallow-rendering-api-props]: https://github.com/airbnb/enzyme/blob/master/docs/api/shallow.md#props--object
[enzyme-docs-shallow-rendering-api-simulate]: https://github.com/airbnb/enzyme/blob/master/docs/api/shallow.md#simulateevent-data--shallowwrapper
[enzyme-docs-shallow-rendering-api-setstate]: https://github.com/airbnb/enzyme/blob/master/docs/api/shallow.md#setstatenextstate--shallowwrapper
[enzyme-docs-shallow-rendering-api-state]: https://github.com/airbnb/enzyme/blob/master/docs/api/shallow.md#statekey--any
[enzyme-docs-using-enzyme-with-webpack]: https://github.com/airbnb/enzyme/blob/master/docs/guides/webpack.md
[jasmine-docs-createspy]: http://jasmine.github.io/2.4/introduction.html#section-Spies:_<code>createSpy</code>
[jasmine-enzyme-tobepresent]: https://www.npmjs.com/package/jasmine-enzyme#tobepresent
[npm-jasmine-enzyme]: https://www.npmjs.com/package/jasmine-enzyme
[react-docs-test-utils]: https://facebook.github.io/react/docs/test-utils.html
[testing-react-components-repository]: https://github.com/LaunchAcademy/testing-react-components
[testing-react-components-1]: https://s3.amazonaws.com/horizon-production/images/testing-react-components-1.png
[testing-react-components-2]: https://s3.amazonaws.com/horizon-production/images/testing-react-components-2.png
[testing-react-components-3]: https://s3.amazonaws.com/horizon-production/images/testing-react-components-3.png
