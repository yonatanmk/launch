import React from 'react';

const Question = (props) => {

  let hiddenAnswer = "";
  let buttonText = "+";
  let buttonClass = "button-unselected"
  if (props.selected) {
    hiddenAnswer = props.answer;
    buttonText = "-";
    buttonClass = "button-selected";
  }

  return(
    <div className="row question">
      <div className="row">
        <div className="small-1 columns">
          <div className={buttonClass} onClick={props.handleClick}>{buttonText}</div>
        </div>
        <div className="small-11 columns text-left">
          <h6>{props.question}</h6>
        </div>
      </div>
      <div className="row">
        <div className="small-12 columns">
          <p>{hiddenAnswer}</p>
        </div>
      </div>
    </div>
  )
}

export default Question;
