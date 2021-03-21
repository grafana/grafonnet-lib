# Community Plugins

Jsonnet makes it easy to patch an existing library. Although Grafonnet only
supports core Grafana features and plugins, it is easy to extend. For example:

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
* [Statusmap panel (by Flant)](https://grafana.com/grafana/plugins/flant-statusmap-panel) template plugin: [link](https://github.com/blablacar/grafonnet-lib-plugins).
* [Polystat panel (by Grafana Labs)](https://grafana.com/grafana/plugins/grafana-polystat-panel) template plugin: [link](https://github.com/thelastpickle/grafonnet-polystat-panel).
* [Bigquery panel (by DoiT International)](https://grafana.com/grafana/plugins/doitintl-bigquery-datasource) template plugin: [link](https://github.com/gojekfarm/grafonnet-bigquery-panel).
