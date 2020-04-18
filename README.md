# Grafonnet, a Jsonnet library for generating Grafana dashboards

[![CircleCI](https://circleci.com/gh/grafana/grafonnet-lib.svg?style=svg)](https://circleci.com/gh/grafana/grafonnet-lib)

Grafonnet provides a simple way of writing Grafana dashboards. It leverages the
data templating language [Jsonnet][jsonnet]. It enables you to write reusable
components that you can use and reuse for multiple dashboards.

![screenshot](screenshot.png)

## Contribution Guidelines
Grafana has a wide ecosystem of plugins, and there is no reason why Grafonnet
could not be used to deploy dashboards containing resources provided by
these plugins.

However, *maintaining* Grafonnet, with support for all these plugins, would be
difficult. Therefore, into the future, Grafonnet will limit itself to features
that are present within Grafana without the use of additional plugins.

Fortunately, Grafonnet uses Jsonnet, and adding support for your own plugins
is easy. See the "[Adding Plugins to Grafonnet](#adding-plugins-to-grafonnet)"
section for details of how to do this.

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

## Examples

Simple Grafana 5.x dashboard:

Please note that the layout has changed, no `row` objects and new possible
nesting of `panel` objects. You need to set `schemaVersion` parameter on
dashboard object to at least 16.

```jsonnet
local grafana = import 'grafonnet/grafana.libsonnet';
local dashboard = grafana.dashboard;
local row = grafana.row;
local singlestat = grafana.singlestat;
local prometheus = grafana.prometheus;
local template = grafana.template;

dashboard.new(
  'JVM',
  schemaVersion=16,
  tags=['java'],
)
.addTemplate(
  grafana.template.datasource(
    'PROMETHEUS_DS',
    'prometheus',
    'Prometheus',
    hide='label',
  )
)
.addTemplate(
  template.new(
    'env',
    '$PROMETHEUS_DS',
    'label_values(jvm_threads_current, env)',
    label='Environment',
    refresh='time',
  )
)
.addTemplate(
  template.new(
    'job',
    '$PROMETHEUS_DS',
    'label_values(jvm_threads_current{env="$env"}, job)',
    label='Job',
    refresh='time',
  )
)
.addTemplate(
  template.new(
    'instance',
    '$PROMETHEUS_DS',
    'label_values(jvm_threads_current{env="$env",job="$job"}, instance)',
    label='Instance',
    refresh='time',
  )
)
.addPanel(
  singlestat.new(
    'uptime',
    format='s',
    datasource='Prometheus',
    span=2,
    valueName='current',
  )
  .addTarget(
    prometheus.target(
      'time() - process_start_time_seconds{env="$env", job="$job", instance="$instance"}',
    )
  ), gridPos={
    x: 0,
    y: 0,
    w: 24,
    h: 3,
  }
)
```

Simple Grafana 4.x dashboard:

```jsonnet
local grafana = import 'grafonnet/grafana.libsonnet';
local dashboard = grafana.dashboard;
local row = grafana.row;
local singlestat = grafana.singlestat;
local prometheus = grafana.prometheus;
local template = grafana.template;

dashboard.new(
  'JVM',
  tags=['java'],
)
.addTemplate(
  grafana.template.datasource(
    'PROMETHEUS_DS',
    'prometheus',
    'Prometheus',
    hide='label',
  )
)
.addTemplate(
  template.new(
    'env',
    '$PROMETHEUS_DS',
    'label_values(jvm_threads_current, env)',
    label='Environment',
    refresh='time',
  )
)
.addTemplate(
  template.new(
    'job',
    '$PROMETHEUS_DS',
    'label_values(jvm_threads_current{env="$env"}, job)',
    label='Job',
    refresh='time',
  )
)
.addTemplate(
  template.new(
    'instance',
    '$PROMETHEUS_DS',
    'label_values(jvm_threads_current{env="$env",job="$job"}, instance)',
    label='Instance',
    refresh='time',
  )
)
.addRow(
  row.new()
  .addPanel(
    singlestat.new(
      'uptime',
      format='s',
      datasource='Prometheus',
      span=2,
      valueName='current',
    )
    .addTarget(
      prometheus.target(
        'time() - process_start_time_seconds{env="$env", job="$job", instance="$instance"}',
      )
    )
  )
)
```

Find more examples in the [examples](examples/) directory.

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

See a full list of public 'plugins' for Grafonnet [here](plugins.md).

[brew]:https://brew.sh/
[jsonnet]:http://jsonnet.org/
[jsonnetgh]:https://github.com/google/jsonnet
