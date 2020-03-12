# Grafonnet Plugins

Jsonnet makes it easy to patch an existing library. Therefore,
although the base Grafonnet only supports core Grafana features,
it is easy to extend it with additional 'plugins', which are
simply a directories of libsonnet files, and can be used like
so:

```jsonnet
local grafonnet = (import 'grafonnet-lib/grafana.libsonnet')
                + (import 'my-plugin-lib/my-plugin.libsonnet');
{
  ....our dashboards
}
```

## Plugin List

(the idea of plugins is new. Please submit a PR to add your plugin
here).
