import { combineReducers, applyMiddleware, createStore, compose } from 'redux';

/** The Root Reducer calls the other ones. */
import rootReducer from '../../../reducers/root-reducer'
import rootMiddleware from '../middleware/rootMiddleware'
// see https://github.com/facebook/immutable-js/pull/961
// import * as Immutable from 'immutable'
import update from 'immutability-helper'

// Source: https://github.com/zalmoxisus/redux-devtools-extension
// Adding Redux Devtools in development here:
const composeEnhancers =
  typeof window === 'object' &&
  //@ts-ignore
  window.__REDUX_DEVTOOLS_EXTENSION_COMPOSE__ ?
    //@ts-ignore
    window.__REDUX_DEVTOOLS_EXTENSION_COMPOSE__({
      // Specify extension’s options like name, actionsBlacklist, actionsCreators, serialize...
    }) : compose;

//@ts-ignore
const maybeEnhancer = (process.env.NODE_ENV !== 'production') ?
  composeEnhancers(rootMiddleware) :
  rootMiddleware

const configureStore = (railsProps = {}, railsContext = {}) => {
  //@ts-ignore
  window.railsStoreProps = railsProps

  // Overrides selected_day with local current day and calculates client_offset 1x
  let storeProps = update(railsProps, {
  })

  return (
  createStore(
    //@ts-ignore
    rootReducer,
    storeProps,
    maybeEnhancer
  )
)};

export default configureStore;
