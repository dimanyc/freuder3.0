import React, { PropTypes } from 'react';
import Tweet from '../components/Tweet';

export default class Dashboard extends React.Component {

  static propTypes = {
    name:   PropTypes.string.isRequired,
    tweets: PropTypes.array.isRequired
  }

  constructor(props, context) {
    super(props, context);
    this.state = {
      name:   this.props.name,
      tweets: this.props.tweets
    }
  }

  renderTweets(){
    return(
      this.props.tweets.map((tweet) => {
        return <Tweet key={tweet.id_str} tweet={tweet} />
      })
    )
  }

  render(){
    return(
      <div className="container">
        <div className="row">
          <h1>Dashboard</h1>
          <p>{this.props.name}</p>
          <h3>Tweets</h3>
          { this.renderTweets() }
        </div>
      </div>
    );
  }
}
