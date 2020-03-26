import "@babel/polyfill"; // Satisfy Babel.

import React from "react"
//@ts-ignore
import { Provider } from "react-redux"

import AppContentContainer from '../../layout/AppContentContainer'

import { THistory } from '../../../types/core';
import { GlobalStoreType } from "../../../types/rails";
import { featureFlags, FeatureFlagOverridesButton } from '../FeatureFlags'
import MuiThemeProvider from 'material-ui/styles/MuiThemeProvider';
import MuiTheme from './muiTheme'


// See documentation for https://github.com/reactjs/react-redux.
// This is how you get props from the Rails view into the redux store.
// This code here binds your smart component to the redux store.
// railsContext provides contextual information especially useful for server rendering, such as
// knowing the locale. See the React on Rails documentation for more info on the railsContext


/**
 * Main App. This is the Entry point of our React Application.
 *
 * It's actually not much to look at.
**/
const MainApp = ({ store, history }:{store:GlobalStoreType, history:THistory}) => {
  import(/* webpackChunkName: "rox-browser" */ 'rox-browser').then(RoxModule=>{
    let Rox = RoxModule.default
    Rox.register('wurl', featureFlags)
    console.log('ROX_CLIENT_KEY', process.env.ROX_CLIENT_KEY)
    Rox.setup(process.env.ROX_CLIENT_KEY)
    Rox.setCustomNumberProperty("contentPartner", () => 1)
    Rox.setCustomStringProperty("email", () => 'test@gmail.com')
    Rox.setCustomBooleanProperty("admin", () => false)
  })

  
  //@ts-ignore
  let appContentContainer = (<AppContentContainer/>)

  let innerContent = (
    <div style={{ lineHeight: 0 }}>
      {appContentContainer}
      {featureFlags.featureFlagOverrides.isEnabled() && <FeatureFlagOverridesButton />}
    </div>
  )

  //@ts-ignore Seems we need to inherit from that ReadOnly props type...
  return (<Provider {...{ store }}>
    <MuiThemeProvider muiTheme={MuiTheme}>
      {innerContent}
      </MuiThemeProvider>
    </Provider>
  )
}

export default MainApp
