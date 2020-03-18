
/**
 * Dispatch types receive a GetState() function. We declare it like this
 * so IDEs can see our TGlobalState returned by rootReducer.
 */
export type TReduxGetSchedulerStateFn = () => TGlobalState;

export type TGlobalState = {
  rox_flag_ruby: boolean
};

