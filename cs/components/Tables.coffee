###   eslint-disable import/first   ###
# ^^^ Required for React's Linter ^^^ #
###^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^###
import { Component } from 'react'
import { PropTypes } from 'prop-types'
import {
  Container, Label
  Form, Grid
} from 'semantic-ui-react'

import { h } from '@jhessin/react-hyperscript-helpers'

class Tables extends Component
  @propTypes: {
    items: PropTypes.arrayOf(PropTypes.object)
    onAdd: PropTypes.func
  }
  @defaultProps: {
    onAdd: ->
  }
  state: {
    newTableName: ''
  }

  onChange: (e, { name, value })=>
    @setState {
      [name]: value
    }

  onSubmit: =>
    @props.onAdd @state.newTableName
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
        @renderItem item for item in @props.items
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
