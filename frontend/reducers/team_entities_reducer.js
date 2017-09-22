import { arrayToObj } from '../util/shapers'
import {
  RECEIVE_CURRENT_USER
} from '../actions/session_actions.js';

const teamEntitiesReducer = (state = {}, action) => {
  Object.freeze(state);
  const newState = Object.assign({}, state)

  switch (action.type) {
    case RECEIVE_CURRENT_USER:
      if (action.user) {
        return arrayToObj(action.user.teams);
      } else {
        return {}
      }
    default:
      return state;
  }
};

export default teamEntitiesReducer;
