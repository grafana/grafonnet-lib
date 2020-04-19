# Style Guide

## Code Style

Grafonnet carries no specific code style opinions. Only to use and enforce those
of [Jsonnet tooling](https://jsonnet.org/learning/tools.html). Particularly
`jsonnetfmt`.

Running `make test-update` will run the repository's unit tests while updating
files with `jsonnetfmt`. This is a good way to ensure your contributions are
formatted correctly.

## Component Composition

Grafonnet is, however, opinionated about component composition. This is to
ensure consistency among components and hopefully keep the codebase simple.

### Interfaces

All panels should implement the same one function interface, `panel.new`.

All datasource targets should implement the same one function interface,
`datasource.target`.

Most components are either panels or datasource targets so these two interfaces
cover the bases for the most part. An exception is `template` which implements a
function for each template type.

### Mutator Functions and Chaining

Being that components are to implement a single function, they are expected to
have mutator functions to build upon them. Each function should return the
component itself so mutator functions can be chained. A common example is
`panel.addTarget` for appending a datasource target.

```libsonnet
graphPanel.new(
  'My Graph'
).addTarget(
  prometheus.target('up'),
)
```
