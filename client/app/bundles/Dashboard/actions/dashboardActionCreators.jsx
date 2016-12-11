import actionTypes from '../constants/DashboardConstants'

export function addTweet(tweet) {
  return {
    type: actionTypes.ADD_TWEET,
    tweet
  }
}
