# ![Grafonnet logo](images/grafonnet.png)

Grafonnet provides an easy and maintainable way of writing
[grafana](https://grafana.org) dashboards. Instead of generating JSON files and
maintaining them, you can easily create your own dashboards using the many
helpers grafonnet-lib offers you, thanks to the data templating language
[jsonnet](http://jsonnet.org/).

## Grafana dashboard

[Grafana](https://grafana.org) is using JSON as format for the dashboards. While
this choice makes sense from a technical point of view, people who want to keep
those dashboards under version control end up putting large, independent JSON
files under source control.

When doing so, it is hard to maintain the same links, templates, or even
annotation between graphes. It usually requires a lot of custom tooling to
change and keep those Json files aligned. There are alternatives, like
[grafanalib](https://github.com/weaveworks/grafanalib), that makes thing easier.
However, as Grafonnet is using [jsonnet](http://jsonnet.org/), a superset of
Json, it gives you out of the box a very easy way to use any feature of grafana
that would not be covered by Grafonnet already.

## Scope

Grafonnet aims at supporting any basic feature of dashboards (annotations,
templates, rows, panels...) as well as a number of datasources and plugins.

We'd like to limit the Grafana plugins supported in Grafonnet to only official plugins.

We do, however, encourage development and use of community Grafonnet plugins.
See the [Community Plugins page](community-plugins) for more info on this.

## Code of Conduct

Grafonnet is developed within the Grafana community. Therefore we are following
the same [Code of Conduct as
Grafana](https://github.com/grafana/grafana/blob/master/CODE_OF_CONDUCT.md). You
need to agree and follow the code of conduct when you contribute to Grafonnet.

## License

We use the same
[license](https://github.com/grafana/grafonnet-lib/blob/master/LICENSE) as
[Grafana](https://github.com/grafana/grafana/blob/master/LICENSE) (ASL 2.0).
