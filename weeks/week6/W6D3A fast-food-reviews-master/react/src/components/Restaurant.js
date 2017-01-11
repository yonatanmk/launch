import React from 'react'

const Restaurant = props => {
  return(
    <div>
      <h1 className="columns small-offset-2 small-centered">{props.name}</h1>
      <p className="columns small-offset-2 small-centered"><strong>{props.category}</strong></p>
      <p className="columns small-offset-2 small-centered">{props.description}</p>
      <p className="columns small-offset-2 small-centered">
        Up Votes:{props.upVotes}
        <button value="Up Vote" name="Up Vote" onClick={props.handleUpVote}>Up Vote</button>
      </p>
      <p className="columns small-offset-2 small-centered">
        Down Votes: {props.downVotes}
        <button value="Up Vote" name="Up Vote" onClick={props.handleDownVote}>Down Vote</button>
      </p>
      <div className="row">
        <div className="col s2 offset-s5 center-align">
          <input className="btn" type="submit" value="Delete" name="Delete" onClick={props.handleDelete}/>
        </div>
      </div>
    </div>
  )
}

export default Restaurant;
