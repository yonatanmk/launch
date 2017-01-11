import React from 'react';
import QuestionList from './QuestionList';

const App = (props) => {
  return(
    <div>
      <div className="text-center">
        <h1>{"We're here to help"}</h1>
      </div>
      <div className="small-12">
        <QuestionList />
      </div>
    </div>
  )
}

export default App;
