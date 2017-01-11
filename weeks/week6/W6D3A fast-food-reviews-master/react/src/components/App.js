import React, { Component } from 'react';
import Restaurant from './Restaurant'
import Form from './Form'

class App extends Component {
  constructor(props) {
    super(props);
    this.state = {
      restaurants: [],
      name: "",
      category: "American",
      description: ""
    };
    this.handleNameChange = this.handleNameChange.bind(this)
    this.handleCategoryChange = this.handleCategoryChange.bind(this)
    this.handleDescriptionChange = this.handleDescriptionChange.bind(this)
    this.handleSubmit = this.handleSubmit.bind(this)
    this.handleDelete = this.handleDelete.bind(this)
    this.handleUpVote = this.handleUpVote.bind(this)
    this.handleDownVote = this.handleDownVote.bind(this)
  }

  handleNameChange(event) {
    let newName = event.target.value;
    this.setState({ name: newName })
  }

  handleCategoryChange(event) {
    let newCategory = event.target.value;
    this.setState({ category: newCategory })
  }

  handleDescriptionChange(event){
    let newDescription = event.target.value;
    this.setState({ description: newDescription })
  }

  handleSubmit(event){
    event.preventDefault()
    let fetchBody = { name: this.state.name, category: this.state.category, description: this.state.description }
    let newRestaurants = []
    fetch('/api/v1/restaurants',
      { method: "POST",
      body: JSON.stringify(fetchBody) })
      .then(function(response) {
        newRestaurants = response.json()
        return newRestaurants
      }).then((response) => this.setState({
        restaurants: response,
      }))
  }

  handleDelete(restaurantId){
    let fetchBody = { id: restaurantId }
    let newRestaurants = []
    fetch(`/api/v1/restaurants/${restaurantId}`,
    { method: "DELETE",
    body: JSON.stringify(fetchBody)
  }).then(function(response) {
      newRestaurants = response.json()
      return newRestaurants
  }).then((response) => this.setState({restaurants: response}))
  }

  handleUpVote(restaurantId){
    let fetchBody = { id: restaurantId, type: "up_vote" }
    let newRestaurants = []
    fetch(`/api/v1/restaurants/${restaurantId}`,
    { method: "PATCH",
    body: JSON.stringify(fetchBody)
  }).then(function(response) {
      newRestaurants = response.json()
      return newRestaurants
  }).then((response) => this.setState({restaurants: response}))
  }

  handleDownVote(restaurantId){
    let fetchBody = { id: restaurantId, type: "down_vote" }
    let newRestaurants = []
    fetch(`/api/v1/restaurants/${restaurantId}`,
    { method: "PATCH",
    body: JSON.stringify(fetchBody)
  }).then(function(response) {
      newRestaurants = response.json()
      return newRestaurants
  }).then((response) => this.setState({restaurants: response}))
  }

  componentDidMount() {
    $.ajax({
        method: "GET",
        url: "/restaurants.json",
      })
      .done(data => {
        this.setState({
          restaurants: data
        });
      })
  }

  render() {
    let restaurants = this.state.restaurants.map(restaurant => {
      let handleDelete = () => {
        this.handleDelete(restaurant.id)
      }
      let handleUpVote = () => {
        this.handleUpVote(restaurant.id)
      }
      let handleDownVote = () => {
        this.handleDownVote(restaurant.id)
      }
      return(
        <Restaurant
          key={restaurant.id}
          id={restaurant.id}
          name={restaurant.name}
          category={restaurant.category}
          description={restaurant.description}
          upVotes={restaurant.up_votes}
          downVotes={restaurant.down_votes}
          handleDelete={handleDelete}
          handleUpVote={handleUpVote}
          handleDownVote={handleDownVote}
         />
      )
    })
    return(
      <div>
        <h1 className="columns small-4 small-centered">Fast-Food Fiend</h1>
        <h2 className="columns small-4 small-centered">New Restaurant</h2>
        <Form
          handleNameChange={this.handleNameChange}
          handleCategoryChange={this.handleCategoryChange}
          handleDescriptionChange={this.handleDescriptionChange}
          handleSubmit={this.handleSubmit}
        />
        {restaurants}
      </div>
      )
    }
}

export default App;
