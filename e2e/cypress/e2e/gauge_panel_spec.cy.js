describe('Gauge Panel', function() {

  let panelTitles = []

  before(function() {
    let testDir = './tests/gauge_panel/test_compiled.json'
    let uid = 'gauge-panel'
    panelTitles = cy.createDashboardFromUnitTests(testDir, uid)
  })

  it('renders all gauge panels', function() {
    cy.visit('/d/gauge-panel/gauge-panel')
    for (const title of panelTitles) {
      cy.contains(title)
    }
  })
})
