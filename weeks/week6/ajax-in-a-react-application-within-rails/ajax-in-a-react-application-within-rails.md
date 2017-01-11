## Learning Objectives
* Learn how to fetch data from a Rails API endpoint via AJAX in React

## Following Along
We have the following [Rails application with
React][ajax-in-a-react-application-within-rails-repository] set up within it. To get
quickly set up, do the following:

* Clone down the repository, install the necessary gems, set up
    the database, and run the rails server.

    ```sh
    $ git clone https://github.com/LaunchAcademy/ajax-in-a-react-application-within-rails.git
    $ cd ajax-in-a-react-application-within-rails
    $ bundle install
    $ bundle exec rake db:create
    $ bundle exec rake db:migrate
    $ bundle exec rails server -b 0.0.0.0
    ```

* In another tab, install the necessary NPM packages and run your Webpack Dev Server

    ```sh
    $ npm install
    $ npm start
    ```

## AJAX calls in React

We have written the following `Fortune` component:

```javascript
import React, { Component } from 'react';

class Fortune extends Component {
  constructor(props) {
    super(props);
    this.state = { fortune: '' };
  }

  render() {
    return (
      <h1>Your Fortune: {this.state.fortune}</h1>
    );
  }
}

export default Fortune;
```

Our Rails application displays this component at our root index. If we visit the
page, we see the following:

![AJAX in a React application within Rails 1][ajax-in-a-react-application-within-rails-1]

We have also built the following API endpoint in our Rails applicaition that
returns a random fortune:

```ruby
class Api::FortunesController < ApiController
  def show
    respond_to do |format|
      format.json do
        render json: { fortune: fortunes.sample }
      end
    end
  end

  private

  def fortunes
    [
      "Expect a letter from a friend who will ask a favor of you.",
      "You are taking yourself far too seriously.",
      "Bank error in your favor.  Collect $200.",
      "Your true value depends entirely on what you are compared with.",
      "Don't let your mind wander -- it's too little to be let out alone.",
      "You will be imprisoned for contributing your time and skill to a bank robbery.",
      "Whenever you find that you are on the side of the majority, it is time to reform.",
      "You are confused; but this is your normal state.",
      "Don't read everything you believe.",
      "Keep it short for pithy sake.",
      "Abandon the search for Truth; settle for a good fantasy.",
      "Try to relax and enjoy the crisis.",
      "You will be awarded some great honor.",
      "Tuesday After Lunch is the cosmic time of the week.",
      "Blow it out your ear.",
      "You definitely intend to start living sometime soon.",
      "Don't tell any big lies today.  Small ones can be just as effective.",
      "Don't worry, be happy.",
      "Another good night not to sleep in a eucalyptus tree."
    ]
  end
end
```

We can test the API endpoint by running:

```sh
$ curl localhost:3000/api/fortune
```

And we get back a JSON formatted response of a random fortune:

```sh
{"fortune":"Whenever you find that you are on the side of the majority, it is time to reform."}
```

We would like our component to display a random fortune from the API. We can
accomplish this by doing an AJAX once the component mounts and setting the new
state with the returned fortune if the AJAX response is successful. We update
our component as such:

```javascript
import React, { Component } from 'react';

class Fortune extends Component {
  constructor(props) {
    super(props);
    this.state = { fortune: '' };
  }

  componentDidMount() {
    $.ajax({
      url: '/api/fortune',
      contentType: 'application/json'
    })
    .done(data => {
      this.setState({ fortune: data.fortune });
    });
  }

  render() {
    return (
      <h1>Your Fortune: {this.state.fortune}</h1>
    );
  }
}

export default Fortune;
```

If we visit our root path again, we now see the following:

![AJAX in a React application within Rails 2][ajax-in-a-react-application-within-rails-2]

## Summary
In a React application set up within a Rails application, we are able to fetch
data from a Rails API endpoint for the React application. We accomplish this
through the use of AJAX and React component lifecycle methods. With such
knowledge, we are now able to leverage both the power of a Rails back-end and
the responsiveness of a React front-end in our website!

[ajax-in-a-react-application-within-rails-repository]: https://github.com/LaunchAcademy/ajax-in-a-react-application-within-rails
[ajax-in-a-react-application-within-rails-1]: https://s3.amazonaws.com/horizon-production/images/ajax-in-a-react-application-within-rails-1.png
[ajax-in-a-react-application-within-rails-2]: https://s3.amazonaws.com/horizon-production/images/ajax-in-a-react-application-within-rails-2.png
