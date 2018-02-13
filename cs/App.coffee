###   eslint-disable import/first   ###
# ^^^ Required for React's Linter ^^^ #
###^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^###
import { Component } from 'react'
# import { PropTypes } from 'prop-types'
import { h } from '@jhessin/react-hyperscript-helpers'
import {
  coffeeLogo
  reactLogo
  plusLogo
} from './images'
import { firebase, db } from './controllers'

import {
  Header
  Menu
} from './components'

class App extends Component
  @propTypes: {}
  @defaultProps: {}
  state: {
    loggedIn: false
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

export default App
