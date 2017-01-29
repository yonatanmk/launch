import React from 'react';

const CandyListItem = (props) => {

  return(
    <div className="list-item text-center small-4 columns">
      <p>{props.name}</p>
      <div>
        <a href={`http://localhost:3000/candies/` + props.id}><img src={props.url} className="list-item-image"/></a>
      </div>
    </div>
  )
}

export default CandyListItem;
