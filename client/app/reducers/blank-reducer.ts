import { TReduxAction } from '../types/actions/index';

// This is a reducer that does nothing, so we can have a placeholder for parts of the model we are not using yet and eliminate warnings.
const BlankReducer = function (state:any = [], action:TReduxAction) {
  switch (action.type) {
    default:
      return state;
  }
};

export default BlankReducer;
