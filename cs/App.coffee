###   eslint-disable import/first   ###
# ^^^ Required for React's Linter ^^^ #
###^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^###
import { Component } from 'react'
# import { PropTypes } from 'prop-types'
import { h } from '@jhessin/react-hyperscript-helpers'
import { Container } from 'semantic-ui-react'
import { Set, Map } from 'immutable'
import {
  coffeeLogo
  reactLogo
  plusLogo
} from './images'
import { firebase, Path } from './controllers'

import {
  Header
  Menu
  Tables
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
      if user
        path = Path.fromRef().to({ users: user.uid }).to('Tables')
        path.on (tables, @unsub)=>
          @setState (prevState, props) -> {
            prevState...
            tables
          }
      @setState (prevState, props) -> {
        prevState...
        path, user
      }


  render: =>
    h 'div',
      h Header,
        leftImage: reactLogo,
        midImage: plusLogo,
        rightImage: coffeeLogo
      h Menu,
        loggedIn: !!@state.path
        username: @state.user?.displayName ? undefined
      if not @state.user
        h Container,
          text: true
          textAlign: 'center'
          content: 'Please login to continue'
      else
        h Tables,
          items: @state.tables.toArray()
          onAdd: (name)=>
            @state.path?.push { name }
export default App
