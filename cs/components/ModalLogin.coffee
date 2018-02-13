###   eslint-disable import/first   ###
# ^^^ Required for React's Linter ^^^ #
###^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^###
import { Component } from 'react'
import { PropTypes } from 'prop-types'
import {
  Modal, Form, Popup
  Label, Icon
} from 'semantic-ui-react'
import { h } from '@jhessin/react-hyperscript-helpers'
import { firebase } from '../controllers'


class ModalLogin extends Component
  @propTypes: {
    render: PropTypes.func.isRequired
  }
  @defaultProps: {
    render: -> h 'div', 'Create User'
  }
  state: {
    email: ''
    password: ''
    error: false
  }

  handleChange: ( e, { name, value } ) =>
    # because coffeelint is stupid!
    # coffeelint: disable=coffeescript_error
    @setState {
      [name]: value
    }
    # coffeelint: enable=coffeescript_error

  handleSubmit: =>
    # get the current state
    { email, password } = @state

    # clear any errors
    @setState { error: false }

    # login
    firebase.auth().signInWithEmailAndPassword email, password
      .catch (error) =>
        @setState error: error.message

    # clear all the fields
    @setState {
      email, password
    }

  render: ->
    { email, password } = @state
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
            h Form,
              onSubmit: @handleSubmit
              h Form.Input,
                label: 'Email'
                name: 'email'
                value: email
                onChange: @handleChange
              h Form.Input,
                label: 'Password'
                name: 'password'
                value: password
                onChange: @handleChange
              h Form.Button,
                content: 'Submit'

export { ModalLogin }
