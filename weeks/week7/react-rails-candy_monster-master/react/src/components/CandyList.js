import React, { Component } from 'react';
import CandyListItem from './CandyListItem';

class CandyList extends Component {
  constructor(props) {
    super(props)
    this.state = {
      candies: []
    }
    this.getData = this.getData.bind(this);
  }

  getData() {
    fetch('http://localhost:3000/api/v1/candies.json')
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
        this.setState({candies: body});
      })
      .catch(error => console.error(`Error in fetch: ${error.message}`));
  }

  componentDidMount() {
    this.getData();
  }

  render() {
    let newCandies = this.state.candies.map((candy) => {
      return (
        <CandyListItem
          id={candy.id}
          key={candy.id}
          url={candy.image_url}
          name={candy.name}
        />
      )
    });
    return(
      <div className="candy-index">
        {newCandies}
      </div>
    )
  }
}

export default CandyList;
