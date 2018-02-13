###   eslint-disable import/first   ###
# ^^^ Required for React's Linter ^^^ #
###^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^###
import { Component } from 'react'
import { PropTypes } from 'prop-types'
import { Item } from 'semantic-ui-react'

import { h } from '@jhessin/react-hyperscript-helpers'

class Tables extends Component
  @propTypes: {
    items: PropTypes.arrayOf(PropTypes.object)
  }
  @defaultProps: {}
  state: {}

  renderItem: (item)->
    h Item,
      header: item.name

  render: =>
    h Item.Group,
      divided: true
      @renderItem item for item in @props.items

export { Tables }
