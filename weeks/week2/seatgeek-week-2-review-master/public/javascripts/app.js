// JS goes here

// Use the SeatGeek API(docs: http://platform.seatgeek.com/, link to data: https://api.seatgeek.com/2/events?venue.state=MA)

// Create an event class that takes in a name and venue as properties
class Event {
  constructor (name, venue) {
    this.name = name;
    this.venue = venue;
  }
}

let eventList = [];
// Create a method that returns a summary of each event
let summary = (event) => {
  return `${event.name} at the <b>${event.venue}</b>`;
};
// Make a Fetch call to get the information, turn them into Event objects and then put them into the DOM

fetch('https://api.seatgeek.com/2/events?venue.state=MA')
  .then(response => {
    if (response.ok) {
      return response;
    } else {
      let errorMessage = `${response.status} (${response.statusText})`,
          error = new Error(errorMessage);
      throw(error);
    }
  })
  .then(response => response.json())
  .then(body => {
    //console.log(body.events[0].title);
    //console.log(body.events[0].venue.name);
    for (let event of body.events) {
      eventList.push(new Event (event.title, event.venue.name));
    }
    document.getElementById('events').innerHTML += '<ul id="eventList"></ul>';
    for (let event of eventList) {
      console.log(event);
      document.getElementById('eventList').innerHTML += `<li>${summary(event)}</li>`;
    }
  })
  .catch(error => console.error(`Error in fetch: ${error.message}`));
