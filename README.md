# Grafonnet-lib, a Jsonnet library for generating Grafana dashboards

[![CircleCI](https://circleci.com/gh/grafana/grafonnet-lib.svg?style=svg)](https://circleci.com/gh/grafana/grafonnet-lib)

Grafonnet provides a simple way of writing Grafana dashboards. It leverages the
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

### Install grafonnet

Clone this git repository:

```
git clone git@github.com:grafana/grafonnet-lib.git
```

Then import the grafonnet in your jsonnet code:

```
local grafana = import "grafonnet/grafana.libsonnet";
```

To be able to find the grafonnet library, you must pass the root of the git
repository to grafonnet using the `-J` option:

```
jsonnet -j <path> dashboard.jsonnet
```

As you build your own mixins/dashboards, you should add additional `-J` paths.

## Examples

Empty dashboard:

```jsonnet
local grafana = import "grafonnet/grafana.libsonnet";

grafana.dashboard.new("test")
```


[brew]:https://brew.sh/
[jsonnet]:http://jsonnet.org/
[jsonnetgh]:https://github.com/google/jsonnet
