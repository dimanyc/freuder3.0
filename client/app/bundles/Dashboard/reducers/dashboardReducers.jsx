import Immutable from 'immutable'

import actionTypes from '../constants/dashboardConstants'

export const $$initialState = Immutable.fromJS({
  tweets: ''
})

export default function dashboardReducer($$state = $$initialState, action) {
  const { type, tweet } = action

  switch(type){
    case actionTypes.ADD_NEW_TWEET:
      return $$state.set('tweet', tweet);
    default:
      return $$state
  }
}

