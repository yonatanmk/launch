import React from 'react';

const Profile = props => {
  let hide = "center hidden"

  if (props.showProfile) {
    hide = "center"
  }

  return(
    <div onClick={props.handleClick}>
      <h1>{props.name}</h1>
      <img className={hide} src={props.gif} />
      <p className={hide}>{props.quote}</p>
    </div>
  )
}

export default Profile;
