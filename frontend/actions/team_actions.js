import * as TeamUtil from '../util/api/team_api_util';


export const RECEIVE_NEW_TEAM = 'RECEIVE_NEW_TEAM';
export const RECEIVE_TEAM_ERRORS = 'RECEIVE_TEAM_ERRORS';
export const CLEAR_TEAM_ERRORS = 'CLEAR_TEAM_ERRORS';

export const receiveNewTeam = team => ({
  type: RECEIVE_NEW_TEAM,
  team
});

export const receiveTeamErrors = errors => ({
  type: RECEIVE_TEAM_ERRORS,
  errors
});

export const clearTeamErrors = () => ({
  type: CLEAR_TEAM_ERRORS,
})

export const createTeam = (team, currentUser) => dispatch => (
  TeamUtil.postTeam(team, currentUser)
    .then(newTeam => dispatch(receiveNewTeam(newTeam)),
          error => dispatch(receiveTeamErrors(error.responseJSON)))
);
