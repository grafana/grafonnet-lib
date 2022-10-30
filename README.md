# Grafonnet

Jsonnet libraries for writing Grafana dashboards as code.

This is a fork of grafonnet-lib from Grafana Labs, with improved support for
recent Grafana features.

Grafana's docs are here: https://grafana.github.io/grafonnet-lib/ although this
codebase has diverged somewhat from the API described there.

# Grafonnet 7

In the [grafonnet-7.0](./grafonnet-7.0) directory you will find code generated
from a new project,
[grafana/dashboard-spec](https://github.com/grafana/dashboard-spec). The
generated code is still incomplete, however, the components present are
useable.  We very much appreciate contributions in
[grafana/dashboard-spec](https://github.com/grafana/dashboard-spec) for
components yet to be added.


## Contributing

Please contribute! If you're interested, please start by reading the
[contributing guide](CONTRIBUTING.md). Before you begin work please take note of
our code of conduct and ensure that what you'd like to contribute is within the
scope of what Grafonnet attempts to support.

## Upgrading Cypress

- Update version numbers in e2e/package.json and e2e/docker-compose.dev.yml
- `make e2e-npm-install` to update e2e/package-lock.json
