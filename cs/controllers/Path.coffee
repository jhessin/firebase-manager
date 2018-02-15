###   eslint-disable import/first   ###
# ^^^ Required for React's Linter ^^^ #
###^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^###
import { firebase } from './firebase'
require('firebase/firestore')

db = firebase.firestore()

class Path
  @DEFAULT_COLLECTION: 'sub'

  @fromRef: (ref)->
    new Path { fromRef: ref }

  constructor: ({ fromRef })->
    @isCollection = fromRef? instanceOf firebase.firestore.CollectionReference
    @ref = fromRef ? db

  to: (path)->
    switch typeof path
      when 'string'
        ref = if @isCollection
          @ref.doc path
        else
          @ref.collection path
        return Path.fromRef ref
      when 'object'
        key = Object.keys(path)[0]
        value = Object.values(path)[0]
        ref = if @isCollection
          @ref.doc(key).collection value
        else
          @ref.collection(key).doc value
        return Path.fromRef ref

  # Pushes new data to the server
  # If this is not a collection then the data is pushed to a new
  # subcollection of Path.DEFAULT_COLLECTION
  push: (data)->
    ref =
    if @isCollection
      @ref.doc()
    else
      @ref.collection(Path.DEFAULT_COLLECTION).doc()
    ref.set(data)
    new Path
      fromRef: ref

  # on() returns a promise resolving to:
  # data: an array for collections or just the data for a document
  # unsub: an unsubscribe function to call and unsubscribe as a listener
  on: ->
    new Promise (resolve, reject)=>
      unsub = if @isCollection
        @ref.onSnapshot (querySnapshot)->
          data = []
          querySnapshot.forEach (doc)->
            data.push doc.data()
          resolve data, unsub
      else
        @ref.onSnapshot (doc)->
          resolve doc.data(), unsub


Object.defineProperty Path.prototype, 'isCollection',
  # coffeelint: disable=missing_fat_arrows
  get: ->
    # coffeelint: enable=missing_fat_arrows
    @ref instanceOf firebase.firestore.CollectionReference

Object.defineProperty Path.prototype, 'isDoc',
  # coffeelint: disable=missing_fat_arrows
  get: ->
    # coffeelint: enable=missing_fat_arrows
    @ref instanceOf firebase.firestore.DocumentReference

# Export it here
export {
  Path
}
