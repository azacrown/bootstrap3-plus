Bootstrap3PlusView = require './bootstrap3-plus-view'
{CompositeDisposable} = require 'atom'

module.exports = Bootstrap3Plus =
  bootstrap3PlusView: null
  modalPanel: null
  subscriptions: null

  activate: (state) ->
    @bootstrap3PlusView = new Bootstrap3PlusView(state.bootstrap3PlusViewState)
    @modalPanel = atom.workspace.addModalPanel(item: @bootstrap3PlusView.getElement(), visible: false)

    # Events subscribed to in atom's system can be easily cleaned up with a CompositeDisposable
    @subscriptions = new CompositeDisposable

    # Register command that toggles this view
    @subscriptions.add atom.commands.add 'atom-workspace', 'bootstrap3-plus:toggle': => @toggle()

  deactivate: ->
    @modalPanel.destroy()
    @subscriptions.dispose()
    @bootstrap3PlusView.destroy()

  serialize: ->
    bootstrap3PlusViewState: @bootstrap3PlusView.serialize()

  toggle: ->
    console.log 'Bootstrap3Plus was toggled!'

    if @modalPanel.isVisible()
      @modalPanel.hide()
    else
      @modalPanel.show()
