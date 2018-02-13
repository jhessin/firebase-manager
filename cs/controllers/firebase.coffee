###   eslint-disable import/first   ###
# ^^^ Required for React's Linter ^^^ #
###^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^###
import * as firebase from 'firebase'
# import key from './firestoreKey.json'
import config from './firebaseConfig.json'
# import * as admin from 'firebase-admin'
require('firebase/firestore')

# Create your data
firebaseApp = firebase.initializeApp config

admin.initializeApp credential:
  admin.credential.cert key

db = admin.firestore

# Export it here
export {
  firebaseApp as firebase
  db
}
