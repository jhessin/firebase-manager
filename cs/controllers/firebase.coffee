###   eslint-disable import/first   ###
# ^^^ Required for React's Linter ^^^ #
###^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^###
import * as firebase from 'firebase'
import * as admin from 'firebase-admin'

key = # Your JSON key from google cloud goes here

# Create your data
firebaseApp = firebase.initializeApp {
  # Your firebase setup keys go here
}

admin.initializeApp credential:
  admin.credential.cert key

db = admin.firestore

# Export it here
export {
  firebaseApp as firebase
  db
}
