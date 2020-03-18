
import { combineReducers } from 'redux'

import blankReducer from './blank-reducer'

import { TGlobalState } from "../types"
import { TReduxAction } from '../types/actions'


//@ts-ignore
const perStateEntryRootReducer = combineReducers({

  rox_flag_ruby: blankReducer,

});

const rootReducer = function (state:TGlobalState, action:TReduxAction) {
  let resultingState = state
  //@ts-ignore
  resultingState = perStateEntryRootReducer(resultingState, action)
  return resultingState
}


export default rootReducer;
