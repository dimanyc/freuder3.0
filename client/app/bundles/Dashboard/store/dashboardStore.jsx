import { compose, createStore, applyMiddleware, combineReducers } from 'redux';

import thunkMiddleware from 'redux-thunk';

import reducers from '../reducers';

import { initialStates } from '../reducers';

export default props => {

  const { tweet } = props
  const { $$dashboardState } = initialStates;

  const initialState = {
    $$dashboardStore: $$dashboardState.merge({
      tweet
    })
  }

  const reducer = combineReducers(reducers)
  const composedStore = compose(
    applyMiddleware(thunkMiddleware)
  )
  const storeCreator = composedStore(createStore)
  const store = storeCreator(reducer, initialState)

  return store
}


