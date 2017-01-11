
// Create an Event Class
class Event {
  constructor (name, venue) {
    this.name = name;
    this.venue = venue;
  }

  summary () {
    return `This event is called ${this.name} and is hosted at ${this.venue}`;
  }
}

// Make a fetch call to get the information from the api and put it in the DOM
fetch('https://api.seatgeek.com/2/events?venue.state=MA')
  .then(response => {
    if (response.ok) {
      return response;
    }
    else {
      let error = "No soup for you!";
      throw error;
    }
  })
  .then(response => {
    response.json();
  })
  .catch();
