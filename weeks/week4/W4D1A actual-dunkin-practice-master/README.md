Note:
You'll need to run the following commands to get started!

`npm install`

`bundle install`

Then in order to get the application up and running you have to open up two
tabs and run `ruby server.rb` in one and `webpack --watch` in the other!

## Steps to Create the Actual Customers of Dunkin App

1. Create a Customer React fragment that passes the appropriate information down from the App's state to a Customer component

2. Create a stateful Customer React component that has a `showProfile` property set to `false` by default in the state

3. Return a Profile React component in your Customer that passes the appropriate information down from the state

4. Create the Profile React component (remember that components that just display information do not need to be stateful)

5. Create a `handleClick` function that toggles the `showProfile` state value and pass that down to the Profile component

6. Create a className attribute on the Profile's `<div>` set to "center"

7. Write a function on Profile that will toggle the hidden class on Profile depending on how the showProfile state object is toggled
