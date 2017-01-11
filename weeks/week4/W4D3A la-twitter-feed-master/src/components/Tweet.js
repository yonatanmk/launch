import React from 'react';

const Tweet = (props) => {

  return(
    <div className={`tweet-box ${props.className}`} onClick={props.handleClick}>
      <img src={props.userPhoto} />
      <span className="user-name">
        {props.name}
      </span>
      <p>{props.text}</p>
    </div>
  )
};
export default Tweet;
