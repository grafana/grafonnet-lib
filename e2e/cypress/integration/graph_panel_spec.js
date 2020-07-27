describe('Graph Panel', function() {

  let panelTitles = []

  before(function() {
    let testDir = './tests/graph_panel/test_compiled.json'
    let uid = 'graph-panel'

    // Exclude panels with alerts. They are incompatible with the test
    // datasource. They will cause dashboard creation to fail.
    let excludePanels = ["alerts", "alertsWithMultipleConditions"]

    panelTitles = cy.createDashboardFromUnitTests(testDir, uid, excludePanels)
  })

  it('renders all graph panels', function() {
    cy.visit('/d/graph-panel/graph-panel')
    for (const title of panelTitles) {
      cy.contains(title)
    }
  })
})
