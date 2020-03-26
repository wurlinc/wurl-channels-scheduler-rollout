import React, { SFC } from 'react';
import FloatingActionButton from 'material-ui/FloatingActionButton';
import ContentFlag from 'material-ui/svg-icons/content/flag';

let initialFlagsTag = document.querySelector('script[data-initial_rox_flags]')
let initialFlags = initialFlagsTag ? initialFlagsTag.textContent || '{}' : '{}'

const FEATURE_FLAG_INITIAL_STORE = JSON.parse(initialFlags)

console.log('FEATURE_FLAG_INITIAL_STORE', FEATURE_FLAG_INITIAL_STORE)

/**
 * Static temporary flag that gets the *real* value from FeatureFlags.rb but
 * without loading 700K+ worth of Rox UI yet.
 */
class TempRoxFlag {
  flagName: string
  constructor(flagName:string) {
    this.flagName = flagName
  }
  isEnabled() { 
    return FEATURE_FLAG_INITIAL_STORE[this.flagName]
  }
}

// DRY -- Do not set rox flags here. Go to app/models/feature_flags.rb
// and they will be passed through the Redux initial context. This loop
// GRabs the parsed flags (see above) and gves an initial Temp flag.
let __featureFlags:any = {
  ROX_LOADED: false
}

Object.keys(FEATURE_FLAG_INITIAL_STORE).forEach((flagName) => {
  __featureFlags[flagName] = new TempRoxFlag(flagName)
});

export const featureFlags = __featureFlags

let showOverridesUI = () => {
  if ( featureFlags.Rox ) {
    console.log("Rox initialized. Overrides button will work now.")
    featureFlags.Rox.showOverrides()
  } else {
    console.log('Rox is not loaded yet. Please wait until it does.')
  }
}

import(/* webpackChunkName: "rox-browser"  */ 'rox-browser').then(Rox=>{
  featureFlags.ROX_LOADED = true
  //@ts-ignore
  featureFlags.Rox = Rox
  console.log('initializing real front-end flags')
  Object.keys(FEATURE_FLAG_INITIAL_STORE).forEach((flagName) => {
    featureFlags[flagName] = new Rox.Flag()
  });
})

export const FeatureFlagOverridesButton: SFC<{}> = () => {
  return (
      <FloatingActionButton style={{position: 'absolute', bottom: '10px', right: '10px'}}>
        <ContentFlag onClick={() => showOverridesUI()}/>
      </FloatingActionButton>
    )
}
