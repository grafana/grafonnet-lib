const fs = require('fs')

describe('Stat Panel', function() {

  let panelTitles = []

  before(function() {
    cy.readFile('./tests/stat_panel/test_compiled.json').then(function(str) {
      let panels = []
      for (let [i, [name, panel]] of Object.entries(Object.entries(str))) {
        panel['id'] = parseInt(i)
        panel['gridPos'] = {'w': 6, 'h': 4, 'x': i * 6 % 24 }
        panelTitles.push(panel.title)
        panels.push(panel)
      }
      let dashboardJSON = {
        "uid": "stat-panel",
        "title": "Stat Panel",
        "panels": panels
      }
      cy.createDashboard(dashboardJSON)
    })
  })

  it('renders all stat panels', function() {
    cy.visit('/d/stat-panel/stat-panel')
    for (const title of panelTitles) {
      cy.contains(title)
    }
  })
})
