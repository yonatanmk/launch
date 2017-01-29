import React, { Component } from 'react';

class CounterButton extends Component {
  constructor(props) {
    super(props)
    this.state = {
      clickCount: 0
    };

    this.handleClick = this.handleClick.bind(this);
  }

  componentDidMount() {
    let pageId = parseInt(document.getElementById('counter-button').dataset.id);
    fetch(`http://localhost:3000/api/v1/candies/${pageId}`)
      .then(response => {
        if (response.ok) {
          return response;
        } else {
          let errorMessage = `${response.status} ($response.statusText)`,
            error = new Error(errorMessage);
          throw(error);
        }
      })
      .then(response => response.json())
      .then(body => {
        this.setState({clickCount: body.points});
      })
      .catch(error => console.error(`Error in fetch: ${error.message}`));
  }

  handleClick(event) {
    let newClickCount;
    let pageId = parseInt(document.getElementById('counter-button').dataset.id);
    let fetchBody = { id: pageId };

    fetch(`http://localhost:3000/api/v1/candies/${pageId}`,
      { method: "PATCH",
        body: fetchBody
      })
      .then(response => {
        if (response.ok) {
          return response.json();
        } else {
          console.log("Oops");
          let errorMessage = `${response.status} ($response.statusText)`,
            error = new Error(errorMessage);
            throw(error);
        }
      })
      .then(data => {
        console.log(data);
        newClickCount = data.points;
        this.setState({ clickCount: newClickCount })
      })
    .catch(error => console.error(`Error in fetch: ${error.message}`));
}

  render() {
    return(
      <div onClick={this.handleClick}>
        <h1>Yum-o-Meter: {this.state.clickCount}</h1>
      </div>
    );
  }
}

export default CounterButton;
