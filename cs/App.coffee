###   eslint-disable import/first   ###
# ^^^ Required for React's Linter ^^^ #
###^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^###
import { Component } from 'react'
# import { PropTypes } from 'prop-types'
import { h } from '@jhessin/react-hyperscript-helpers'
import { Container } from 'semantic-ui-react'
import {
  coffeeLogo
  reactLogo
  plusLogo
} from './images'
import { firebase } from './controllers'

import {
  Header
  Menu
  Tables
} from './components'

class App extends Component
  @propTypes: {}
  @defaultProps: {}
  state: {
    loggedIn: false
    tables: []
  }

  componentWillMount: ->
    firebase.auth().onAuthStateChanged (user)=>
      @setState { user }

  render: =>
    h 'div',
      h Header,
        leftImage: reactLogo,
        midImage: plusLogo,
        rightImage: coffeeLogo
      h Menu,
        loggedIn: !!@state.user
        username: @state.user?.displayName ? undefined
      if not @state.user
        h Container,
          text: true
          textAlign: 'center'
          content: 'Please login to continue'
      else
        h Tables,
          items: @state.tables
          onAdd: (name)=>
            tables = [@state.tables...]
            tables.push { name }
            @setState { tables }
export default App
