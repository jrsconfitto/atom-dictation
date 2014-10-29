module.exports =
  activate: (state) ->
    console.log "activating..."
    atom.workspaceView.command "atom-dictation:listen", => @listen()
    atom.workspaceView.command "atom-dictation:speak", => @speak()

  deactivate: ->
    console.log "Deactivate me!"

  serialize: ->
    console.log "Is there anything to serialize here?"

  listen: ->
    console.log "Listening to you!"

  speak: ->
    console.log "Speaking to you!"
