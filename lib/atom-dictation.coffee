AtomDictationView = require './atom-dictation-view'

module.exports =
  atomDictationView: null

  activate: (state) ->
    @atomDictationView = new AtomDictationView(state.atomDictationViewState)

  deactivate: ->
    @atomDictationView.destroy()

  serialize: ->
    atomDictationViewState: @atomDictationView.serialize()
