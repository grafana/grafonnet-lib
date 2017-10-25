# Grafonnet-lib, a Jsonnet library for generating Grafana dashboards

[![CircleCI](https://circleci.com/gh/grafana/grafonnet-lib.svg?style=svg)](https://circleci.com/gh/grafana/grafonnet-lib)

grafonnet provides a simple way of writing Grafana dashboards. It leverages the
data templating language [Jsonnet][jsonnet]. It enables you to write reusable
components that you can use and reuse for multiple dashboards.

![screenshot](screenshot.png)

## Getting started

### Prerequisites

Grafonnet requires Jsonnet.

#### Linux

You must build the binary. For details, [see the GitHub
repository][jsonnetgh].

#### Mac OS X

Jsonnet is available in Homebrew. If you do not have Homebrew installed,
[install it][brew].

Then run:

```
brew install jsonnet
```

[brew]:https://brew.sh/
[jsonnet]:http://jsonnet.org/
[jsonnetgh]:https://github.com/google/jsonnet
