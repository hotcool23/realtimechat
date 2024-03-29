import React from 'react'
import { connect } from 'react-redux'
import { Route, Redirect, withRouter } from 'react-router-dom'

const Auth = ({ component: Component, path, exact, loggedIn }) => (
  <Route
    exact={exact}
    path={path}
    render={(props) => (
      !loggedIn ? (
        <Component {...props} />
      ) : (
        <Redirect to='/messages' />
      )
    )}
  />
);

const Demo = ({ component: Component, path, exact, loggedIn, isDemo }) => (
  <Route
    exact={exact}
    path={path}
    render={(props) => (
      !loggedIn || isDemo ? (
        <Component {...props} />
      ) : (
        <Redirect to='/messages' />
      )
    )}
  />
);

const Protected = ({ component: Component, path, exact, loggedIn }) => (
  <Route
    exact={exact}
    path={path}
    render={(props) => (
      loggedIn ? (
        <Component {...props} />
      ) : (
        <Redirect to='/login' />
      )
    )}
  />
);

const mapStateToProps = (state, ownProps) => ({
  loggedIn: Boolean(state.session.currentUser),
  isDemo: state.session.currentUser && state.session.currentUser.isDemo,
})

export const AuthRoute = withRouter(
  connect(mapStateToProps, null)(Auth)
)

export const DemoAuthRoute = withRouter(
  connect(mapStateToProps, null)(Demo)
)

export const ProtectedRoute = withRouter(
  connect(mapStateToProps, null)(Protected)
)
