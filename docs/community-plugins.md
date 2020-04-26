# Community Plugins

Jsonnet makes it easy to patch an existing library.
Although Grafonnet only supports core Grafana features,
it is easy to extend it with additional 'plugins', which are
simply directories of libsonnet files, and can be used like
so:

```jsonnet
local grafonnet = (import 'grafonnet-lib/grafana.libsonnet')
                + (import 'my-plugin-lib/my-plugin.libsonnet');
{
  ....our dashboards
}
```

## Plugin List

* [Status panel (by Vonage)](https://grafana.com/grafana/plugins/vonage-status-panel) template plugin: [link](https://github.com/DifferentialOrange/grafonnet-status-panel).
