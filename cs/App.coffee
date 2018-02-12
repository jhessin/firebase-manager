###   eslint-disable import/first   ###
# ^^^ Required for React's Linter ^^^ #
###^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^###
import { Component } from 'react'
# import { PropTypes } from 'prop-types'
import { h } from '@jhessin/react-hyperscript-helpers'
import { Grid } from 'semantic-ui-react'


import {
  coffeeLogo
  reactLogo
  plusLogo
} from './images'
import { Header } from './components'

class App extends Component
  @propTypes: {}
  @defaultProps: {}
  state: {}

  render: ->
    h Grid,
      h Grid.Column,
        h Grid.Row,
          stretched: true
          h Header,
            leftImage: reactLogo,
            midImage: plusLogo,
            rightImage: coffeeLogo

export default App
