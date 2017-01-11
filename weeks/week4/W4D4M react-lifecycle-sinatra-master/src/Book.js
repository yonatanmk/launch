// src/components/Capybara.js
import React from 'react';

const Book = props => {
  let book = props.name
  let handleclick = props.handleclick

  return (
    <li onClick={handleclick} className="center">
      <h4>{book}</h4>
    </li>
  );
};



export default Book;
