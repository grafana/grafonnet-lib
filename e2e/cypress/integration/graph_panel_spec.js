const fs = require('fs')

describe('Graph Panel', function() {

  let panelTitles = []

  before(function() {
    cy.readFile('../tests/graph_panel/test_compiled.json').then(function(str) {
      let panels = []
      for (let [i, [name, panel]] of Object.entries(Object.entries(str))) {
        panel['id'] = parseInt(i)
        panel['gridPos'] = {'w': 24, 'h': 6 }
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
    cy.visit('http://admin:admin@localhost:3030/d/graph-panel/graph-panel')
    cy.get('.custom-scrollbar .view:first-child').scrollTo('bottom') // lazy loading
    for (const title of panelTitles) {
      cy.contains(title)
    }
  })
})
