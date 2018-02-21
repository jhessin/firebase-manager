###       eslint-disable        ###
### Required for React's Linter ###
###*****************************###
import { Component } from 'react'
import { PropTypes } from 'prop-types'
import {
  Modal, Input, Button
  Popup, Label, Icon
} from 'semantic-ui-react'
import { h } from '@jhessin/react-hyperscript-helpers'
import { firebase } from '../controllers'

class ModalCreateUser extends Component
  @propTypes: {
    render: PropTypes.func.isRequired
  }
  @defaultProps: {
    render: -> h 'div', 'Create User'
  }
  state: {
    email: ''
    password: ''
    confirmPass: ''
    error: false
  }

  handleChange: ( e, { name, value } ) =>
    @setState {
      [name]: value
    }

  handleSubmit: =>
    # get the current state
    { email, password, confirmPass } = @state

    # clear any errors
    @setState { error: false }

    # test inputs
    if password isnt confirmPass
      @setState {
        error: 'Passwords do not match'
        password: ''
        confirmPass: ''
      }
      return

    # create the User
    firebase.auth().createUserWithEmailAndPassword email, password
      .catch (error) =>
        @setState error: error.message

    # clear all the fields
    @setState {
      email, password, confirmPass
    }

  render: ->
    { email, password, confirmPass } = @state
    h Popup,
      open: !!@state.error
      position: 'bottom center'
      content: h Label,
        color: 'red'
        h Icon,
          name: 'exclamation'
        @state.error
      trigger:
        h Modal,
          trigger: @props.render()
          onClose: => @setState { error: false }
          h Modal.Content,
            h Input,
              label: 'Email'
              name: 'email'
              type: 'email'
              value: email
              onChange: @handleChange
            h Input,
              label: 'Password'
              name: 'password'
              type: 'password'
              value: password
              onChange: @handleChange
            h Input,
              label: 'Confirm Password'
              name: 'confirmPass'
              type: 'password'
              value: confirmPass
              onChange: @handleChange
          h Modal.Actions,
            h Button,
              onClick: @handleSubmit
              content: 'Submit'

export { ModalCreateUser }
