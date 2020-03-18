import React from "react";

import { featureFlags } from '../../bundles/Main/FeatureFlags'
//@ts-ignore
import style from "./AppContent.scss";

/** Properties for this widget. */
export type AppContentProps = {
  rox_flag_ruby: boolean
}

class AppContent extends React.Component<AppContentProps> {
  render() {
    console.log('featureFlags.rolloutTest.isEnabled()', featureFlags.rolloutTest.isEnabled())
    return (
      <div className={style.reset_line_height}>
        <div>
          {featureFlags.rolloutTest.isEnabled() ?
            "Rollout Test front-end flag enabled" :
            "Rollout test front-end flag disabled"}
        </div>
        <div>
          {this.props.rox_flag_ruby ?
            "Rollout Test ruby flag enabled" :
            "Rollout test ruby flag disabled"}
        </div>
      </div>
    );
  }
}

export default AppContent