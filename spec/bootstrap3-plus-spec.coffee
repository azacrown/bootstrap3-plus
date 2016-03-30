Bootstrap3Plus = require '../lib/bootstrap3-plus'

# Use the command `window:run-package-specs` (cmd-alt-ctrl-p) to run specs.
#
# To run a specific `it` or `describe` block add an `f` to the front (e.g. `fit`
# or `fdescribe`). Remove the `f` to unfocus the block.

describe "Bootstrap3Plus", ->
  [workspaceElement, activationPromise] = []

  beforeEach ->
    workspaceElement = atom.views.getView(atom.workspace)
    activationPromise = atom.packages.activatePackage('bootstrap3-plus')

  describe "when the bootstrap3-plus:toggle event is triggered", ->
    it "hides and shows the modal panel", ->
      # Before the activation event the view is not on the DOM, and no panel
      # has been created
      expect(workspaceElement.querySelector('.bootstrap3-plus')).not.toExist()

      # This is an activation event, triggering it will cause the package to be
      # activated.
      atom.commands.dispatch workspaceElement, 'bootstrap3-plus:toggle'

      waitsForPromise ->
        activationPromise

      runs ->
        expect(workspaceElement.querySelector('.bootstrap3-plus')).toExist()

        bootstrap3PlusElement = workspaceElement.querySelector('.bootstrap3-plus')
        expect(bootstrap3PlusElement).toExist()

        bootstrap3PlusPanel = atom.workspace.panelForItem(bootstrap3PlusElement)
        expect(bootstrap3PlusPanel.isVisible()).toBe true
        atom.commands.dispatch workspaceElement, 'bootstrap3-plus:toggle'
        expect(bootstrap3PlusPanel.isVisible()).toBe false

    it "hides and shows the view", ->
      # This test shows you an integration test testing at the view level.

      # Attaching the workspaceElement to the DOM is required to allow the
      # `toBeVisible()` matchers to work. Anything testing visibility or focus
      # requires that the workspaceElement is on the DOM. Tests that attach the
      # workspaceElement to the DOM are generally slower than those off DOM.
      jasmine.attachToDOM(workspaceElement)

      expect(workspaceElement.querySelector('.bootstrap3-plus')).not.toExist()

      # This is an activation event, triggering it causes the package to be
      # activated.
      atom.commands.dispatch workspaceElement, 'bootstrap3-plus:toggle'

      waitsForPromise ->
        activationPromise

      runs ->
        # Now we can test for view visibility
        bootstrap3PlusElement = workspaceElement.querySelector('.bootstrap3-plus')
        expect(bootstrap3PlusElement).toBeVisible()
        atom.commands.dispatch workspaceElement, 'bootstrap3-plus:toggle'
        expect(bootstrap3PlusElement).not.toBeVisible()
