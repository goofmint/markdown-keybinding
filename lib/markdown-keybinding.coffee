MarkdownKeybindingView = require './markdown-keybinding-view'
{CompositeDisposable} = require 'atom'
console.log("Load MarkdownKeybinding")
module.exports = MarkdownKeybinding =
  markdownKeybindingView: null
  modalPanel: null
  subscriptions: null

  activate: (state) ->
    @markdownKeybindingView = new MarkdownKeybindingView(state.markdownKeybindingViewState)
    console.log "Load markdown-keybinding"
    # @modalPanel = atom.workspace.addModalPanel(item: @markdownKeybindingView.getElement(), visible: false)

    # Events subscribed to in atom's system can be easily cleaned up with a CompositeDisposable
    @subscriptions = new CompositeDisposable

    # Register command that toggles this view
    @subscriptions.add atom.commands.add 'atom-workspace', 'markdown-keybinding:insert-image-tag': => @insertImageTag()
    @subscriptions.add atom.commands.add 'atom-workspace', 'markdown-keybinding:insert-link-tag': => @insertLinkTag()
  insertImageTag: ->
    if editor = atom.workspace.getActiveTextEditor()
      selection = editor.getSelectedText()
      if typeof selection == "undefined"
        selection = ""
      editor.insertText("![#{selection}]()\n")
  insertLinkTag: (e) ->
    if editor = atom.workspace.getActiveTextEditor()
      selection = editor.getSelectedText()
      if typeof selection == "undefined"
        selection = ""
      editor.insertText("[#{selection}]()")
      
  deactivate: ->
    @modalPanel.destroy()
    @subscriptions.dispose()
    @markdownKeybindingView.destroy()

  serialize: ->
    markdownKeybindingViewState: @markdownKeybindingView.serialize()
