import { applyMiddleware } from 'redux';
import thunk from 'redux-thunk';
import createLogger from 'redux-logger';
import freeze from 'redux-freeze'

// Add more middleware here as needed.

const middleware = [thunk]

//@ts-ignore
if (process.env.NODE_ENV !== 'production') {
  // Order of these middleware matters -- createLogger should always come last.
  //@ts-ignore
  middleware.push(freeze)
  middleware.push(createLogger)
}

const rootMiddleware = applyMiddleware(...middleware);

export default rootMiddleware;
