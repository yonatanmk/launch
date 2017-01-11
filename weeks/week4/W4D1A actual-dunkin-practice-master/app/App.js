import React, { Component } from 'react';
import Customer from './Customer'

class App extends Component {
  constructor(props){
    super(props)
    this.state = {
      customers: [
        {
          name: 'Donny, Mayor of Dunkins',
          gif: 'http://i.giphy.com/dQryH4rpYh9oQ.gif',
          quote: "This is the face of Dunkin Donuts right here.",
        },
        {
          name: 'Mark, Mad Dunkin Employee',
          gif: "http://i.giphy.com/XpE3NBotHGJoY.gif",
          quote:"No smoking in heah, it's coming in through the crack!",
        },
        {
          name: 'Yuppie Starbucks',
          gif: "http://i.giphy.com/zXK3SmaSCYEFO.gif",
          quote: "Where else can I get breakfast and the perfect stawking stuffah?",
        },
        {
          name: 'Dewey',
          gif: 'http://i.giphy.com/Df43GSwWA1G9O.gif',
          quote: "I COULDN'T BREATHE, DONNY",
        }
      ]
    }
  }

  render() {
    return(
      <div>
          <h1>Actual Customers of Dunkin</h1>
      </div>
    )
  }
}

export default App;
