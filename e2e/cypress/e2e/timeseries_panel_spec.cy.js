const fs = require('fs')

describe('Timeseries Panel', function() {

  let panelTitles = []

  before(function() {
    let testDir = './tests/timeseries_panel/test_compiled.json'
    let uid = 'timeseries-panel'
    panelTitles = cy.createDashboardFromUnitTests(testDir, uid)
  })

  it('renders all timeseries panels', function() {
    cy.visit('/d/timeseries-panel/timeseries-panel')
    for (const title of panelTitles) {
      cy.contains(title)
    }
  })
})
