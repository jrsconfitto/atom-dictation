{WorkspaceView} = require 'atom'
AtomDictation = require '../lib/atom-dictation'

# Use the command `window:run-package-specs` (cmd-alt-ctrl-p) to run specs.
#
# To run a specific `it` or `describe` block add an `f` to the front (e.g. `fit`
# or `fdescribe`). Remove the `f` to unfocus the block.

describe "AtomDictation", ->
  activationPromise = null

  beforeEach ->
    atom.workspaceView = new WorkspaceView
    activationPromise = atom.packages.activatePackage('atom-dictation')

  describe "when the atom-dictation:listen event is triggered", ->
    it "does something", ->
      expect(true).toBe(true)
