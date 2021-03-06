###       eslint-disable        ###
### Required for React's Linter ###
###*****************************###
import { Component } from 'react'
# import { PropTypes } from 'prop-types'
import { h } from '@jhessin/react-hyperscript-helpers'
import { Container } from 'semantic-ui-react'
import { Set } from 'immutable'
import {
  coffeeLogo
  reactLogo
  plusLogo
} from './images'
import { firebase, Path } from './controllers'

import {
  Header
  Menu
  PathView
} from './components'

class App extends Component
  @propTypes: {}
  @defaultProps: {}
  state: {
    user: null
    path: null
    tables: new Set()
  }

  componentWillMount: ->
    firebase.auth().onAuthStateChanged (user)=>
      path = if !!user then Path.new.to({ users: user.uid }).to 'Tables'
      @setState {
        user
        path
      }
      path?.on (tables)=> @setState { tables }

  componentWillUnmount: ->
    @state.path?.unsubscribeAll()

  render: ->
    h 'div',
      h Header,
        leftImage: reactLogo,
        midImage: plusLogo,
        rightImage: coffeeLogo
      h Menu,
        loggedIn: !!@state.user
        username: @state.user?.displayName ? undefined
      if !!@state.user
        # h Tables,
        #   path: @state.path
        #   items: @state.tables
        h PathView,
          path: @state.path
      else
        h Container,
          text: true
          textAlign: 'center'
          content: 'Please login to continue'
export default App
