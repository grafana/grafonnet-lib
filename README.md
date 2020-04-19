# Grafonnet

[![CircleCI](https://circleci.com/gh/grafana/grafonnet-lib.svg?style=svg)](https://circleci.com/gh/grafana/grafonnet-lib)

A Jsonnet library for generating Grafana dashboards.

Grafonnet provides a simple way of writing Grafana dashboards. It leverages the
data templating language [Jsonnet][jsonnet]. It enables you to write reusable
components that you can use and reuse for multiple dashboards.

## Scope

Grafana has a wide ecosystem of plugins, and there is no reason why Grafonnet
could not be used to deploy dashboards containing resources provided by
these plugins.

However, *maintaining* Grafonnet, with support for all these plugins, would be
difficult. Therefore, into the future, Grafonnet will limit itself to features
that are present within Grafana without the use of additional plugins.

Fortunately, Grafonnet uses Jsonnet, and adding support for your own plugins
is easy. See the "[Adding Plugins to Grafonnet](#adding-plugins-to-grafonnet)"
section for details of how to do this.

## Adding Plugins to Grafonnet

As stated above, Grafonnet will be limiting itself to supporting features
that exist within core Grafana itself (without additional plugins).

However, the power of Jsonnet makes it easy to work with extensions to
Grafonnet library. If we maintain the Grafonnet code for the external
plugin separately from Grafonnet itself, we can create a `grafonnet`
object to use within our Jsonnet code that contains all the features we
need, like so:

```jsonnet
local grafonnet = (import 'grafonnet-lib/grafana.libsonnet')
                + (import 'my-plugin-lib/my-plugin.libsonnet');
{
  ....our dashboards
}
```

Moreover, we can add this to our own library, e.g. `my-grafonnet/grafonnet.libsonnet`:

```jsonnet
(import 'grafonnet-lib/grafana.libsonnet')
+ (import 'my-plugin-lib/my-plugin.libsonnet');
```
From now on, we can access this like so:

```jsonnet
local grafonnet = (import 'my-grafonnet/grafonnet.libsonnet');
{
  ....our dashboards
}
```

If we use [Jsonnet Bundler](https://github.com/jsonnet-bundler/jsonnet-bundler)
alongside our new library, we can have it import both the code for all the
plugins we depend upon, and Grafonnet itself, in one seamless step.

See a full list of community plugins for Grafonnet [here](https://grafana.github.io/grafonnet-lib/community-plugins).

[brew]:https://brew.sh/
[jsonnet]:http://jsonnet.org/
[jsonnetgh]:https://github.com/google/jsonnet
