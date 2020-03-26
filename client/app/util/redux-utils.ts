/*
 * (c) 2019, Wurl, Inc. All righs reserved.
 * Some miscellaneous utilities for interacting with Redux outside of it,
 * and the ReactOnRails prep code.
 */
import ReactOnRails from 'react-on-rails';
import { GlobalStoreType } from '../types/rails';

/**
* We should not call ReactOnRails on our app. Instead this wraps it so
* it has correct types and we can keep independent from it.
*/
export const getReduxStore = () => {
 // This should be the only instance of this line in the whole application.
 return ReactOnRails.getStore("SchedulerStore") as GlobalStoreType
}
