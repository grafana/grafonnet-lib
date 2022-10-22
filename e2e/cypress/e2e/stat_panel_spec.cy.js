const fs = require('fs')

describe('Stat Panel', function() {

  let panelTitles = []

  before(function() {
    let testDir = './tests/stat_panel/test_compiled.json'
    let uid = 'stat-panel'
    panelTitles = cy.createDashboardFromUnitTests(testDir, uid)
  })

  it('renders all stat panels', function() {
    cy.visit('/d/stat-panel/stat-panel')
    for (const title of panelTitles) {
      cy.contains(title)
    }
  })
})
