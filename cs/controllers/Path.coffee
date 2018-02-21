###       eslint-disable        ###
### Required for React's Linter ###
###*****************************###
import { firebase } from './firebase'
import { Set, Map } from 'immutable'
require('firebase/firestore')

db = firebase.firestore()

class Path
  @fromRef: (ref)->
    new Path ref

  constructor: (@ref = db)->
    @subs = []

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
        cb data
    else
      @ref.onSnapshot (doc)->
        if doc.exists
          # coffeelint: disable=coffeescript_error
          cb Map({ doc.data()..., id: doc.id })
          # coffeelint: enable=coffeescript_error
    @subs.push(unsub)
    @

  #clear all subscriptions
  unsubscribeAll: ->
    for unsub in @subs
      unsub?()

  # delete a document
  delete: (id)->
    if @isDoc
      ref = @ref.parent
      @ref.delete()
      return Path.fromRef ref
    @ref.doc(id?).delete()
    @

Object.defineProperty Path.prototype, 'isCollection',
  # coffeelint: disable=missing_fat_arrows
  get: ->
    @ref.doc? and @ref.firestore?

Object.defineProperty Path.prototype, 'isDoc',
  get: ->
    # coffeelint: enable=missing_fat_arrows
    not @isCollection

Object.defineProperty Path, 'new',
  # coffeelint: disable=missing_fat_arrows
  get: -> new Path()
  # coffeelint: enable=missing_fat_arrows

# Export it here
export { Path }
