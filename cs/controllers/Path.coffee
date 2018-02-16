###   eslint-disable import/first   ###
# ^^^ Required for React's Linter ^^^ #
###^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^###
import { firebase } from './firebase'
import { Set, Map } from 'immutable'
require('firebase/firestore')

db = firebase.firestore()

class Path
  @new: (args...)->
    new Path(args...)
  @fromRef: (ref)->
    new Path { fromRef: ref }

  constructor: ({ fromRef })->
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
      else
        @

  # Pushes new data to the server
  # If this is not a collection then the data is pushed to a new
  # sibling document in the parent
  push: (data)->
    ref =
    if @isCollection
      @ref.doc()
    else
      @ref.parent.doc()
    ref.set(data)
    Path.fromRef ref

  # Updates the data in a DocumentReference
  # Otherwise it updates the data at the parent
  # document if this is a subcollection or does nothing otherwise.
  update: (data)->
    if @isDoc
      @ref.update(data)
    else
      @ref.parent?.update(data)
    @

  # on() returns a promise resolving to:
  # data: an array for collections or just the data for a document
  # unsub: an unsubscribe function to call and unsubscribe as a listener
  on: (cb)->
    unsub = if @isCollection
      @ref.onSnapshot (querySnapshot)->
        data = new Set()
        querySnapshot.forEach (doc)->
          if doc.exists
            # coffeelint: disable=coffeescript_error
            data = data.add Map({ doc.data()..., id: doc.id })
            # coffeelint: enable=coffeescript_error
        cb data, unsub
    else
      @ref.onSnapshot (doc)->
        if doc.exists
          # coffeelint: disable=coffeescript_error
          cb Map({ doc.data()..., id: doc.id }), unsub
          # coffeelint: enable=coffeescript_error
    @

  # delete a document
  delete: (id)->
    if @isDoc
      ref = @ref.parent
      @ref.delete()
      return Path.fromRef ref
    @ref.doc(id).delete()
    return @

Object.defineProperty Path.prototype, 'isCollection',
  # coffeelint: disable=missing_fat_arrows
  get: ->
    @ref instanceof firebase.firestore.CollectionReference

Object.defineProperty Path.prototype, 'isDoc',
  get: ->
    # coffeelint: enable=missing_fat_arrows
    @ref instanceof firebase.firestore.DocumentReference

# Export it here
export {
  Path
}
