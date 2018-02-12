// Generated by CoffeeScript 2.2.1
/*   eslint-disable import/first   */
var ModalLogout;

import {
  // ^^^ Required for React's Linter ^^^ #
  /*^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^*/
  Component
} from 'react';

import {
  PropTypes
} from 'prop-types';

import {
  Modal,
  Button
} from 'semantic-ui-react';

import {
  h
} from '@jhessin/react-hyperscript-helpers';

ModalLogout = (function() {
  class ModalLogout extends Component {
    render() {
      return h(Modal, {
        trigger: this.props.render()
      }, h(Modal.Content, "This is the ModalLogout component"), h(Modal.Actions, h(Button, {
        onClick: () => {
          return this.props.onLogout();
        }
      }, 'Logout')));
    }

  };

  ModalLogout.propTypes = {
    render: PropTypes.func.isRequired,
    onLogout: PropTypes.func.isRequired
  };

  ModalLogout.defaultProps = {
    render: function() {
      return h('p', 'ModalLogout');
    },
    onLogout: function() {}
  };

  ModalLogout.prototype.state = {};

  return ModalLogout;

}).call(this);

export {
  ModalLogout
};