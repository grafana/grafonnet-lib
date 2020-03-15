# Grafonnet End to End Testing

Grafonnet uses [Cypress](https://www.cypress.io).

## Purpose

These tests attempt to assert truth to the following:

* Does this library generate valid dashboard JSON?
* Are dashboard elements displayed as expected?
* Do elements get configured as intended?
* Do the configured elements do what they're expected to do?

Some of this is automated here. However, the visual aspects are difficult for machines to cover. Even some behavioral aspects are as well because they incur an impractical amount of complexity, time, or cost. For those aspects, these tests provide a way to quickly generate dashboards consistently so we can use our human abilities to assert truth.

## Usage

Install dependencies:

```
yarn install
```

Run a Grafana instance to test with:

```
yarn run grafana-instance
```

Launch the [Cypress Test Runner](https://docs.cypress.io/guides/core-concepts/test-runner.html):

```
yarn run cypress open
```

## Notes

Tests depend on compiled artifacts in [tests](../tests) for generating dashboards.

Tests do not destroy the dashboards they create after they're run. This is to facilitate manual inspection. Restart your Grafana instance to start fresh.
