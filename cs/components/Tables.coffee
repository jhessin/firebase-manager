###   eslint-disable import/first   ###
# ^^^ Required for React's Linter ^^^ #
###^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^###
import { Component } from 'react'
import { PropTypes } from 'prop-types'
import { Item, Form } from 'semantic-ui-react'

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
    @setState {
      newTableName: ''
    }
    @props.onAdd @state.newTableName

  renderItem: (item)->
    h Item,
      header: item.name

  render: =>
    h Item.Group,
      divided: true
      @renderItem item for item in @props.items
      h Form,
        onSubmit: @onSubmit
        h Form.Input,
          placeholder: 'New Table'
          name: 'newTableName'
          value: @state.newTableName
          onChange: @onChange
          onSubmit: @onSubmit

export { Tables }
