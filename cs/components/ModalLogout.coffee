###   eslint-disable import/first   ###
# ^^^ Required for React's Linter ^^^ #
###^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^###
import { Component } from 'react'
import { PropTypes } from 'prop-types'
import { Modal, Button } from 'semantic-ui-react'
import { h } from '@jhessin/react-hyperscript-helpers'

class ModalLogout extends Component
  @propTypes: {
    render: PropTypes.func.isRequired
    onLogout: PropTypes.func.isRequired
  }
  @defaultProps: {
    render: -> h 'p', 'ModalLogout'
    onLogout: ->
  }
  state: {}

  render: ->
    h Modal,
      trigger: @props.render()
      h Modal.Content,
        "This is the ModalLogout component"
      h Modal.Actions,
        h Button,
          onClick: => @props.onLogout()
          'Logout'


export { ModalLogout }
