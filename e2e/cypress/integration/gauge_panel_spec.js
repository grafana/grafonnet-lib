const fs = require('fs')

describe('Gauge Panel', function() {

  let panelTitles = []

  before(function() {
    cy.readFile('./tests/gauge_panel/test_compiled.json').then(function(str) {
      let panels = []
      for (let [i, [name, panel]] of Object.entries(Object.entries(str))) {
        panel['id'] = parseInt(i)
        panel['gridPos'] = {'w': 6, 'h': 4, 'x': i * 6 % 24 }
        panelTitles.push(panel.title)
        panels.push(panel)
      }
      let dashboardJSON = {
        "uid": "gauge-panel",
        "title": "Gauge Panel",
        "panels": panels
      }
      cy.createDashboard(dashboardJSON)
    })
  })

  it('renders all gauge panels', function() {
    cy.visit('/d/gauge-panel/gauge-panel')
    for (const title of panelTitles) {
      cy.contains(title)
    }
  })
})
