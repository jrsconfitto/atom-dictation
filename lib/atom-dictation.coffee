recognition = {}
listening = false
speaking = false

module.exports =
  activate: (state) ->
    console.log "activating..."
    atom.workspaceView.command "atom-dictation:listen", => @listen()
    atom.workspaceView.command "atom-dictation:speak", => @speak()
    recognition = new webkitSpeechRecognition()
    recognition.continuous = true
    recognition.interimResults = true
    #todo: should be a setting
    recognition.lang = 'en-US'

  deactivate: ->
    console.log "Deactivate me!"
    #todo clean up recognition object
    recognition = null

  serialize: ->
    console.log "Is there anything to serialize here?"

  listen: ->

    if not listening
      recognition.onresult = (event) ->
        console.log(event)

        finalTranscript = ""
        interimTranscript = ""
        i = event.resultIndex

        while i < event.results.length
          if event.results[i].isFinal
            finalTranscript += event.results[i][0].transcript
          else
            interimTranscript += event.results[i][0].transcript
          ++i

        editor = atom.workspace.getActivePaneItem()
        editor.insertText(finalTranscript)

      recognition.start()
      console.log "Listening to you!"
    else
      recognition.stop()
      console.log "Done listening to you!"

    # toggle whether we're listening or not
    listening = not listening

  speak: ->
    if not speaking
      console.log "Speaking to you!"
    else
      console.log "Done speaking to you!"
