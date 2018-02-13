###   eslint-disable import/first   ###
# ^^^ Required for React's Linter ^^^ #
###^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^###
import { Component } from 'react'
import { PropTypes } from 'prop-types'
import { Modal, Button } from 'semantic-ui-react'
import { h } from '@jhessin/react-hyperscript-helpers'
import { firebase } from '../controllers'

class ModalLogout extends Component
  @propTypes: {
    render: PropTypes.func.isRequired
    onLogout: PropTypes.func.isRequired
  }
  @defaultProps: {
    render: -> h 'p', 'ModalLogout'
    onLogout: ->
  }
  state: {
    open: false
  }

  close: =>
    @setState { open: false }

  open: =>
    @setState { open: true }

  render: =>
    h Modal,
      trigger: @props.render()
      open: @state.open
      onOpen: @open
      onClose: @close
      h Modal.Content,
        'Are you sure you wish to Logout?'
      h Modal.Actions,
        h Button,
          color: 'green'
          onClick: -> firebase.auth().signOut()
          'Yes'
        h Button,
          color: 'red'
          onClick: @close
          'No'


export { ModalLogout }
