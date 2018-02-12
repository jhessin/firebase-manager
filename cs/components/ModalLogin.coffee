###   eslint-disable import/first   ###
# ^^^ Required for React's Linter ^^^ #
###^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^###
import { Component } from 'react'
import { PropTypes } from 'prop-types'
import { Modal, Button } from 'semantic-ui-react'
import { h } from '@jhessin/react-hyperscript-helpers'

class ModalLogin extends Component
  @propTypes: {
    render: PropTypes.func.isRequired
    onLogin: PropTypes.func.isRequired
  }
  @defaultProps: {
    render: -> h 'p', 'ModalLogin'
    onLogin: ->
  }
  state: {}

  render: ->
    h Modal,
      trigger: @props.render()
      h Modal.Content,
        "This is the ModalLogin component"
      h Modal.Actions,
        h Button,
          onClick: => @props.onLogin()
          'Login'


export { ModalLogin }
