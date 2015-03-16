recognition = {}
speaking = false
listening = false

module.exports =
class AtomDictationView
  constructor: (serializeState) ->
    # Create root element
    @element = document.createElement('div')
    @element.classList.add('atom-dictation',  'overlay', 'from-top')
    atom.workspaceView.append(@element)

    recognition = new webkitSpeechRecognition()
    recognition.continuous = true
    recognition.interimResults = true

    #todo: should be a setting
    recognition.lang = 'en-US'

  # Returns an object that can be retrieved when package is activated
  serialize: ->

  # Tear down any state and detach
  destroy: ->
    @element.remove()

  listen: ->
    console.log 'AtomDictationView is listening!'

    # Create message elements
    interimTranscriptElement = document.createElement('div')
    interimTranscriptElement.classList.add('interim')
    interimTranscriptElement.textContent = ""

    finalTranscriptElement = document.createElement('div')
    finalTranscriptElement.id = 'final'
    finalTranscriptElement.classList.add('final')
    finalTranscriptElement.textContent = ""

    insertButton = document.createElement('button')
    insertButton.innerText = "Insert into document"
    insertButton.onclick = @insertText

    @element.appendChild(finalTranscriptElement)
    @element.appendChild(interimTranscriptElement)
    @element.appendChild(insertButton)

    # if @element.parentElement?
    #   @element.remove()
    # else
    #   atom.workspaceView.append(@element)

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

        finalTranscriptElement.textContent += finalTranscript
        interimTranscriptElement.textContent = interimTranscript

      recognition.start()
      console.log "Listening to you!"
    else
      recognition.stop()
      console.log "Done listening to you!"

    # toggle whether we're listening or not
    listening = not listening

  insertText: (text) ->
    atom.workspaceView.insertText(text)

# speak: ->
#   console.log 'AtomDictationView is speaking!'
#
#   if not speaking
#     console.log "Speaking to you!"
#   else
#     console.log "Done speaking to you!"
#
#   # Create message element
#   message = document.createElement('div')
#   message.textContent = "The AtomDictation package about to speak to you!"
#   message.classList.add('message')
#   @element.appendChild(message)
#
#   # if @element.parentElement?
#   #   @element.remove()
#   # else
#   #   atom.workspaceView.append(@element)
