import { connect } from 'react-redux'
import { withRouter } from 'react-router-dom'

import ChatSidenavChannelIndex from './chat_sidenav_channel_index.jsx'
import { getSubscribedChannelsByTeamId } from
  '../../../selectors/chat_selectors'


const mapStateToProps = (state, ownProps) => {

  return {
    channels: getSubscribedChannelsByTeamId(
      ownProps.match.params.teamId,
      state
    ),

  };
};

const mapDispatchToProps = (dispatch, ownProps) => {

  return {
    
  };
};

export default withRouter(connect(
  mapStateToProps,
  mapDispatchToProps
)(ChatSidenavChannelIndex));
