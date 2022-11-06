local crdsonnet = import 'github.com/Duologic/crdsonnet/crdsonnet/main.libsonnet';
local render = import 'github.com/Duologic/crdsonnet/crdsonnet/render.libsonnet';
local schemas = import 'schemas.libsonnet';

function(version='v9.2.3')

  local schema = {
    [s.info.title]: s
    for s in schemas[version]
  }.dashboard;
  local component = schema.components.schemas.dashboard;

  crdsonnet.fromOpenAPI(
    'dashboard',
    component,
    schema,
    render='dynamic',
  )
  + {
    dashboard+: {
      new(title):
        self.withTitle(title)
        + self.withTimezone('utc')
        + self.time.withFrom('now-6h')
        + self.time.withTo('now'),

      panels+: {
        'dashboard.GraphPanel'+:: {},
        graphPanel+: self['dashboard.GraphPanel'] {
          new(title):
            self.withTitle(title)
            + self.withType('graph'),
        },
        'dashboard.HeatmapPanel'+:: {},
        heatmapPanel+: self['dashboard.HeatmapPanel'] {
          new(title):
            self.withTitle(title)
            + self.withType('heatmap'),
        },
        'dashboard.Panel'+:: {},
        panel+: self['dashboard.Panel'] {
          new(title, type):
            self.withTitle(title)
            + self.withType(type),
        },
        'dashboard.RowPanel'+:: {},
        rowPanel+: self['dashboard.RowPanel'] {
          new(title):
            self.withTitle(title)
            + self.withType(),
        },
      },
    },
  }
