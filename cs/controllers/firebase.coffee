###       eslint-disable        ###
### Required for React's Linter ###
###*****************************###
import * as firebase from 'firebase'
import config from './firebaseConfig.json'
# Create your data
firebaseApp = firebase.initializeApp config

# Export it here
export {
  firebaseApp as firebase
}
