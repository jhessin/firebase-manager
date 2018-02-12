###   eslint-disable import/first   ###
# ^^^ Required for React's Linter ^^^ #
###^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^###
import { Component } from 'react'
import { PropTypes } from 'prop-types'
import { Modal } from 'semantic-ui-react'
import { h } from '@jhessin/react-hyperscript-helpers'

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
  }

  handleChange: ( e, { name, value } ) =>
    # because coffeelint is stupid!
    # coffeelint: disable=coffeescript_error
    @setState({ [name]: value })
    # coffeelint: enable=coffeescript_error

  handleSubmit: =>
    { email, password, confirmPass } = @state
    
  render: ->
    h Modal,
      trigger: @props.render()
      h Modal.Content,
        "This is the ModalCreateUser component"

export { ModalCreateUser }
