import { TGlobalState } from './states/index';
import { Store } from '../../node_modules/redux';
import { ThunkDispatch } from 'redux-thunk';
/**
 * TRailsContext - for react-on-rails-produced React widgets.
 * from http://www.rubydoc.info/github/shakacode/react_on_rails
 */
export interface TRailsContext {
    href: string; // request.original_url,
    location: string; //"#{uri.path}#{uri.query.present? ? "?#{uri.query}": ""}",
    scheme: string; // http
    host: string; // foo.com
    port: string;
    pathname: string; // /posts
    search: string; // id=30&limit=5
  
    // Locale settings
    i18nLocale: string;
    i18nDefaultLocale: string; // I18n.default_locale,
    httpAcceptLanguage: string; //request.env["HTTP_ACCEPT_LANGUAGE"],
  
    //Other
    serverSide: boolean; // Are we being called on the server or client? NOTE, if you conditionally
    // render something different on the server than the client, then React will only show the
    // server version!
  }
  
  //@ts-ignore Figure out how to properly subtype this.
  export interface GlobalStoreType extends Store<any, TReduxAction> {
    getState: () => TGlobalState    
    dispatch: ThunkDispatch<TGlobalState, any, TReduxAction>
  }

  export type ReactOnRailsType = {
    getStore: (storeName:string) => GlobalStoreType
  }