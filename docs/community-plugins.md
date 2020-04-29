# Community Plugins

Jsonnet makes it easy to patch an existing library. Although Grafonnet only
supports core Grafana features, it is easy to extend. For example:

```jsonnet
local grafonnet = (import 'grafonnet-lib/grafana.libsonnet')
                  + (import 'my-plugin-lib/my-plugin.libsonnet');
{
  ...
}
```

## Plugin List

If you've developed a Grafonnet extension for supporting a community plugin,
please submit a pull request to get it added to this list.

* [Status panel (by Vonage)](https://grafana.com/grafana/plugins/vonage-status-panel) template plugin: [link](https://github.com/DifferentialOrange/grafonnet-status-panel).
