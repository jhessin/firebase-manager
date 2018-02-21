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

import { Path } from '../controllers'

class PathView extends Component
  @propTypes: {
    path: PropTypes.instanceOf(Path).isRequired
    onSelect: PropTypes.func
  }
  @defaultProps: {
    onSelect: ->
  }
  state: {
    data: new Set()
  }

  componentWillReceiveProps: (nextProps) ->
    # unsubscribe from the old
    @props.path?.unsubscribeAll()

    # subscribe to the new
    nextProps.path.on (data)=> @setState { data }

  renderSet: ->
    for item in @state.data
      h Grid.Row,
        key: item.get 'id'
        h Grid.Column,
          for key, value of item.toObject()
            h Label,
              key: key
              header: key
              content: value

  renderMap: ->
    for key, value of @state.data
      h Grid.Row,
        key: key
        header: key
        content: value

  render: =>
    h Container,
      textAlign: 'center'
      h Grid,
        centered: true
        stretched: true
        columns: 2
        if @props.data instanceof Set
          @renderSet()
        else
          @renderMap()

export { PathView }
