###   eslint-disable import/first   ###
# ^^^ Required for React's Linter ^^^ #
###^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^###

import { Component } from 'react'
import { PropTypes } from 'prop-types'
import { Set, Map } from 'immutable'
import { h } from '@jhessin/react-hyperscript-helpers'

import { Path } from '../controllers'

class PathView extends Component
  @propTypes: {
    path: PropTypes.instanceOf(Path).isRequired
  }
  @defaultProps: {}
  state: {
    data: new Set()
  }

  render: =>
    h 'div',
      'This is the PathView component'
      @props.children

export { PathView }
