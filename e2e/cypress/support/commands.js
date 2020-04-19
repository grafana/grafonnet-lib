const http = require("http")

Cypress.Commands.add('createDashboard', function(dashboardJSON) {

  const payload = JSON.stringify({
    dashboard: dashboardJSON,
    overwrite: true
  })

  const options = {
    auth: 'admin:admin',
    hostname: 'localhost',
    port: 3030,
    path: '/api/dashboards/db',
    method: 'POST',
    headers: {
      'Content-Type': 'application/json',
    }
  }

  const req = http.request(options)
  req.write(payload)
  req.end()
})
