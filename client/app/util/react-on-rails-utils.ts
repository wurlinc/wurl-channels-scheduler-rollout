import ReactOnRails from 'react-on-rails'
import actions from '../actions/index'
import SchedulerStore from '../../app/bundles/Main/stores/SchedulerStore'
import { getReduxStore } from './redux-utils'

/** Register the store. Should only be done once in the whole app, so we put it here. */
ReactOnRails.registerStore( {SchedulerStore} )

/**
 * Prepares the React On Rails store. Only to be called once, inside registration.tsx
 */
export const prepareReactOnRailsStore = () => {
  let _store = getReduxStore()

  //@ts-ignore
  window.scheduler_console = {
    store: _store,
    actions,
    dispatch: _store.dispatch
  }
  return _store
}

