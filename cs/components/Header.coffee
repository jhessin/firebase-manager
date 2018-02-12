###   eslint-disable import/first   ###
# ^^^ Required for React's Linter ^^^ #
###^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^###
import { Component } from 'react'
import { PropTypes } from 'prop-types'
import {
  Header as Base
  Image
  Segment
} from 'semantic-ui-react'
import { h } from '@jhessin/react-hyperscript-helpers'

# import styles
import '../styles/App.css'

class Header extends Component
  @propTypes: {
    leftImage: PropTypes.string.isRequired
    midImage: PropTypes.string.isRequired
    rightImage: PropTypes.string.isRequired
  }
  @defaultProps: {}
  state: {}

  render: ->
    h Segment,
      inverted: true
      h Base,
        as: 'h2'
        textAlign: 'center'
        inverted: true
        color: 'blue'
        h Image,
          '.App-logo-spin'
          centered: true
          src: @props.leftImage
        h Image,
          '.App-plus'
          centered: true
          src: @props.midImage
        h Image,
          '.App-logo'
          centered: true
          src: @props.rightImage
      h Base,
        as: 'h1'
        textAlign: 'center'
        inverted: true
        color: 'blue'
        "Welcome to Databases!"

export { Header }
