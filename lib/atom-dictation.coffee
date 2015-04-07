AtomDictationView = require './atom-dictation-view'
{CompositeDisposable} = require 'atom'

module.exports =
  atomDictationView: null

  activate: (state) ->
    @atomDictationView = new AtomDictationView(state.atomDictationViewState)

    # Events subscribed to in atom's system can be easily cleaned up with a CompositeDisposable
    @subscriptions = new CompositeDisposable

    # Register command that listens to the user's dictation
    @subscriptions.add atom.commands.add 'atom-workspace', 'atom-dictation:listen': => @toggleListening()

    # Register command that reads starting from the cursor
    # @subscriptions.add atom.commands.add 'atom-workspace', 'atom-dictation:speak': => @toggleSpeaking()

  deactivate: ->
    @atomDictationView.destroy()

  serialize: ->
    atomDictationViewState: @atomDictationView.serialize()

  toggleListening: ->
    @atomDictationView.listen()
