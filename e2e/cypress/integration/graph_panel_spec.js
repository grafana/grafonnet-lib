const fs = require('fs')

describe('Graph Panel', function() {

  let panelTitles = []

  before(function() {
    cy.readFile('../tests/graph_panel/test_compiled.json').then(function(str) {
      let panels = []
      for (let [i, [name, panel]] of Object.entries(Object.entries(str))) {
        panel['id'] = parseInt(i)
        panel['gridPos'] = {'w': 6, 'h': 4, 'x': i * 6 % 24 }
        if (name == "alerts" || name == "alertsWithMultipleConditions") {
          // Skip panels with alerts. They are incompatible with the
          // test datasource and result in 500 errors.
          continue
        }
        panelTitles.push(panel.title)
        panels.push(panel)
      }
      let dashboardJSON = {
        "uid": "graph-panel",
        "title": "Graph Panel",
        "panels": panels
      }
      cy.createDashboard(dashboardJSON)
    })
  })

  it('renders all graph panels', function() {
    cy.visit('/d/graph-panel/graph-panel')
    for (const title of panelTitles) {
      cy.contains(title)
    }
  })
})
