import React, { Component } from 'react';
import Book from './Book.js'

class App extends Component {
  constructor(props) {
    super(props);
    this.state = {
      books: []
    };
    this.handleClick = this.handleClick.bind(this)
  }

  componentWillMount() {
    // debugger;
  }

  componentDidMount() {
    // debugger;
    fetch('http://localhost:4567/books.json')
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
        // debugger;
        let nextBooks = body.books;
        this.setState({ books: nextBooks });
      })
      .catch(error => console.error(`Error in fetch: ${error.message}`));
  }

  handleClick() {
    fetch('http://localhost:4567/books.json')
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
        let nextBooks = body.books;
        this.setState({ books: nextBooks });
      })
      .catch(error => console.error(`Error in fetch: ${error.message}`));
  }

  componentWillMount() {
    // debugger;
  }

  render() {
    let books = this.state.books.map(book => {
      return (
        <Book
          key={book.id}
          name={book.name}
        />
      )
    });

    return (
      <div onClick={this.handleClick} className="callout center columns">
        <h1>Lovely Lovely Books</h1>
        <ul> {books} </ul>
      </div>
    );
  }
}

export default App;
