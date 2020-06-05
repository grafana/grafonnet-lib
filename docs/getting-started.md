# Getting Started

## Prerequisites

You must first install Jsonnet.

See the instructions on its GitHub page:

[https://github.com/google/jsonnet#packages](https://github.com/google/jsonnet#packages)

There is also an implementation in Go if you'd prefer:

[https://github.com/google/go-jsonnet#installation-instructions](https://github.com/google/go-jsonnet#installation-instructions)

## Install Grafonnet

Simplest way to install Grafonnet is to clone the repository:

```
git clone https://github.com/grafana/grafonnet-lib.git
```

A slightly more advanced approach is to use
[jsonnet-bundler](https://github.com/jsonnet-bundler/jsonnet-bundler).

```
jb init
jb install https://github.com/grafana/grafonnet-lib/grafonnet
```

See the [Usage](usage) page for next steps.
