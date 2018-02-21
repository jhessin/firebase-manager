###       eslint-disable        ###
### Required for React's Linter ###
###*****************************###
import { Component } from 'react'
import { PropTypes } from 'prop-types'
import { Set } from 'immutable'
import {
  Container, Label
  Form, Grid
} from 'semantic-ui-react'

import { h } from '@jhessin/react-hyperscript-helpers'

class Tables extends Component
  @propTypes: {
    path: PropTypes.object.isRequired
    items: PropTypes.instanceOf(Set)
  }
  @defaultProps: {
  }
  state: {
    newTableName: ''
  }

  onChange: (e, { name, value })=>
    @setState {
      [name]: value
    }

  onSubmit: =>
    existing = @props.items.find(
      (value) =>
        value.get('name').trim() is
        @state.newTableName.trim()
      @props.items
      false
    )
    if not existing
      @props.path?.push { name: @state.newTableName }
      @setState {
        newTableName: ''
      }

  renderItem: (item)->
    h Grid.Row,
      key: item.get 'id'
      h Grid.Column,
        h Label,
          size: 'massive'
          content: item.get 'name'

  render: =>
    h Container,
      textAlign: 'center'
      h Grid,
        centered: true
        stretched: true
        columns: 2
        @renderItem item for item in @props.items.toArray()
      h Grid.Row,
        columns: 1
        h Form,
          size: 'massive'
          onSubmit: @onSubmit
          h Form.Input,
            placeholder: 'New Table'
            name: 'newTableName'
            value: @state.newTableName
            onChange: @onChange

export { Tables }
