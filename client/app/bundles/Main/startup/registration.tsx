// (c) Wurl, Inc. All Rights Reserved
import { hot } from 'react-hot-loader/root';

import ReactOnRails from 'react-on-rails';
import React from 'react';
import { render } from "react-dom"
import history from './configureHistory'

import MainApp from './MainApp';
import { TRailsContext } from "../../../types/index"
import { prepareReactOnRailsStore } from '../../../util/react-on-rails-utils';


const consoleErrorReporter = ({ error }) => {
  console.error(error) // eslint-disable-line
  return null
}

const HotMainApp = hot(MainApp,{errorReporter: consoleErrorReporter})

const Main = (props:any, railsContext:TRailsContext, domNodeId:string) => {
  const store = prepareReactOnRailsStore()
  const renderApp = (Component:any) => { // JSX.Element but then it breaks on props.
    const element = (<Component {...{ store, history }} />)
    render(element, document.getElementById(domNodeId))
  }

  renderApp(HotMainApp)
}

// ReactOnRails registers this, then on app/views/main/index.html.erb it renders it with an ERB tag.
ReactOnRails.register({Main});
