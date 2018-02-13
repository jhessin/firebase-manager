###   eslint-disable import/first   ###
# ^^^ Required for React's Linter ^^^ #
###^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^###
import { Component } from 'react'
import { PropTypes } from 'prop-types'
import {
  Dropdown
  Menu as Base
} from 'semantic-ui-react'
import { h } from '@jhessin/react-hyperscript-helpers'
import {
  ModalCreateUser
  ModalLogin
  ModalLogout
} from './index'


class Menu extends Component
  @propTypes: {
    userName: PropTypes.string
    loggedIn: PropTypes.bool.isRequired
  }
  @defaultProps: {}
  state: {}

  render: =>
    h Base,
      inverted: true
      h Base.Item,
        h Dropdown,
          simple: true
          text: @props.userName ? 'User'
          h Dropdown.Menu,
            h ModalCreateUser,
              render: ->
                h Dropdown.Item,
                  text: 'Create'
            if @props.loggedIn
              h ModalLogout,
                render: ->
                  h Dropdown.Item,
                    text: 'Logout'
            else
              h ModalLogin,
                render: ->
                  h Dropdown.Item,
                    text: 'Login'


export { Menu }
