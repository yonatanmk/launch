import React, { Component } from 'react';
import Tweet from './Tweet'

//stateful

class TwitterFeed extends Component {
  constructor(props){
    super(props);
    this.state= {
      selectedTweetId: null
    }
    this.handleSelectedTweet = this.handleSelectedTweet.bind(this);
  }

  handleSelectedTweet(id){
    this.setState({ selectedTweetId: id });
  }

  render(){

    let tweets = this.props.data.map(tweet =>{
      let className;
      if(tweet.id_str === this.state.selectedTweetId){
        className="selected"
      }
      let handleClick = () => {
        this.handleSelectedTweet(tweet.id_str)
      }

      return(
        <Tweet
          key={tweet.id_str}
          name={tweet.user.name}
          userPhoto={tweet.user.profile_image_url}
          text={tweet.text}
          handleClick={handleClick}
          className = {className}
        />
      )
    });

    return(
      <div>
        {tweets}
      </div>
    )
  }
}

//stateless

const TwitterFeed = (props) => {

  let tweets = props.data.map(tweet =>{
    return(
      <Tweet
        key={tweet.id_str}
        name={tweet.user.name}
        userPhoto={tweet.user.profile_image_url}
        text={tweet.text}
      />
    )
  });

  return(
    <div>
      {tweets}
    </div>
  );
}


export default TwitterFeed;
