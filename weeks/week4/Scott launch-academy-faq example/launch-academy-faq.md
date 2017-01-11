### Introduction

Launch Academy is rebuilding its main website in React, and they need your help
to recreate their FAQ accordion in React!

![Launch Academy FAQ 1][launch-academy-faq-1]

### Setup

From your challenges directory, run the following:

```no-highlight
$ et get launch-academy-faq
$ cd launch-academy-faq
$ npm install
$ webpack-dev-server
```

Then, visit <http://localhost:8080> in your browser. You should see a blank page
and there should be no errors in the JavaScript console.

### Instructions

This is a multi-part challenge. You should not expect to complete this assignment
in one sitting. Expect that there will be other lessons you will need to complete
in order gain the knowledge and experience to complete this challenge.

### Requirements, Part One: Basic React

Using the data found in `src/constants/data.js`, create a React application that
displays the following:

1.  Your application should start out with all the question tabs closed:
    ![Launch Academy FAQ 1][launch-academy-faq-1]

2.  Clicking on a question tab will open it so it shows the answer for the question:
    ![Launch Academy FAQ 2][launch-academy-faq-2]

3.  Clicking on an open question tab will close it. For example, if the "What
    Languages do you teach? What will I learn?" tab is open and we click on it,
    then our site will then change to:
    ![Launch Academy FAQ 1][launch-academy-faq-1]

4. At Launch Academy, Jim Bruno is in charge of accepting and rejecting tickets:

   ![Jim][jim]

   Jim rejects tickets where the application does not match the given design.
   Don't let Jim reject your ticket because it lacks styling.

**Tips:**

* Manage the visible **state** of an answer on the React Component that
    renders the answer. This component should have an `onClick` handler, which
    toggles whether or not the answer is rendered.

* Start by rendering a static version of the site. Then, add state to your
    components, when necessary.

Once you have completed this functionality, and you are satisfied with the styling
of the application, run `et submit` to submit your code.

### Requirements, Part Two: Refactor Your Application

The requirements of the application have changed slightly. In order to improve
User Experience (UX), the higher-ups have decided that clicking on a question
tab should close any other question tabs that are open.

For example, if the "What is Launch Academy?" tab is open and we click on the
"What Languages do you teach? What will I learn?" tab, then our site will
look like so:

![Launch Academy FAQ 3][launch-academy-faq-3]

Refactor your code to meet the new requirements. Once you have completed this
functionality, and you are satisfied with the styling of the application, run
`et submit` to submit your code.

### Requirements, Part Three: Test Your Application

Your app is looking great! The only problem is, other developers won't touch it
until it has tests.

Write tests for your React Components using the Jasmine and Enzyme libraries.
Then, `et submit` your code.

### Requirements, Part Four: `fetch` the Data

Currently, your application retrieves data from a local file, `src/constants/data.js`.
We would like to refactor the app to **retrieve data from an API**, which has
been provided. Run `node server.js` in a separate terminal window.

Use `fetch` to request data from <http://localhost:3000/api/v1/questions>, from
within the appropriate React Component. Use the data in the response to build
your components.

`et submit` your code when you have completed this lesson.

[jim]: https://launchpass-production.s3.amazonaws.com/uploads/user/profile_photo/229/me.jpg
[launch-academy-faq-1]: https://s3.amazonaws.com/horizon-production/images/launch-academy-faq-1.png
[launch-academy-faq-2]: https://s3.amazonaws.com/horizon-production/images/launch-academy-faq-2.png
[launch-academy-faq-3]: https://s3.amazonaws.com/horizon-production/images/launch-academy-faq-3.png
