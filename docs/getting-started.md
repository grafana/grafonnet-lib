# Getting Started

## Prerequisites

Grafonnet requires Jsonnet.

### Linux

You must build the binary. For details, [see the GitHub
repository][jsonnetgh].

### Mac OS X

Jsonnet is available in Homebrew. If you do not have Homebrew installed,
[install it][brew].

Then run:

```
brew install jsonnet
```

## Install Grafonnet

Clone this git repository:

```
git clone https://github.com/grafana/grafonnet-lib.git
```

Then import the grafonnet in your jsonnet code:

```
local grafana = import 'grafonnet/grafana.libsonnet';
```

To be able to find the grafonnet library, you must pass the root of the git
repository to grafonnet using the `-J` option:

```
jsonnet -J <path> dashboard.jsonnet
```

As you build your own mixins/dashboards, you should add additional `-J` paths.
