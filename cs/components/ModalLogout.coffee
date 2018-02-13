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
  state: {}

  render: =>
    h Modal,
      trigger: @props.render()
      h Modal.Content,
        'Are you sure you wish to Logout?'
      h Modal.Actions,
        h Button,
          onClick: -> firebase.auth().signOut()
          'Yes'


export { ModalLogout }
