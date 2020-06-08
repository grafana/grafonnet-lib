# Grafonnet End to End Testing

Grafonnet uses [Cypress](https://www.cypress.io).

## Purpose

These tests attempt to assert truth to the following:

* Does this library generate valid dashboard JSON?
* Are dashboard elements displayed as expected?
* Do elements get configured as intended?
* Do the configured elements do what they're expected to do?

Some of this is automated here. However, the visual aspects are difficult for
machines to cover. Even some behavioral aspects are as well because they incur
an impractical amount of complexity, time, or cost. For those aspects, these
tests provide a way to quickly generate dashboards consistently so we can use
our human abilities to assert truth.

## Usage

`docker-compose` is used to run Cypress and Grafana. Run the tests with:

```
GRAFANA_VERSION=latest \
docker-compose up \
  --abort-on-container-exit \
  --exit-code-from e2e
```

See also the `e2e` target in [Makefile](../Makefile). This is intended to be
used with CI.

## Notes

Tests depend on compiled artifacts in [tests](../tests) for generating
dashboards.
