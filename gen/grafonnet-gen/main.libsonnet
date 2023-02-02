local veneer = import './veneer.libsonnet';
local crdsonnet = import 'github.com/Duologic/crdsonnet/crdsonnet/main.libsonnet';
local d = import 'github.com/jsonnet-libs/docsonnet/doc-util/main.libsonnet';

{
  local root = self,

  new(schemas, version):
    local dashboardSchema = std.filter(
      function(schema) schema.info.title == 'dashboard',
      schemas
    )[0];

    {
      [schema.info.title]:
        (
          if 'PanelOptions' in schema.components.schemas[schema.info.title].properties
          then root.panelLib.new(dashboardSchema, schema)
          else root.coreLib.new(schema)
        )
        + {
          '#':
            d.package.new(
              schema.info.title,
              'github.com/grafana/grafonnet-lib/grafonnet/%s' % version,
              '',
              'main.libsonnet',
            )
            + self.withUsageTemplate(
              |||
                local grafonnet = import 'github.com/grafana/grafonnet-lib/grafonnet/%(version)s/main.libsonnet';
                grafonnet.%(name)s
              ||| % { version: version, name: schema.info.title }
            ),
        }
      for schema in schemas
    }
    + {
      '#':
        d.package.new(
          'grafonnet',
          'github.com/grafana/grafonnet-lib/grafonnet/%s' % version,
          'Jsonnet library for rendering Grafana resources',
          'main.libsonnet',
        ),
    }
    + veneer
  ,

  docs(main):
    d.render(main),

  coreLib: {
    new(schema):
      crdsonnet.fromOpenAPI(
        'lib',
        schema.components.schemas[schema.info.title],
        schema,
        render='dynamic',
      ).lib,
  },

  panelLib: {
    // The panelSchema has PanelOptions and PanelFieldConfig that need to replace certain
    // fiels in the upstream Panel schema This function fits these schemas in the right
    // place for CRDsonnet.
    new(dashboardSchema, panelSchema):
      local baseSchema = {
        properties+: {
          PanelOptions+: {},
          PanelFieldConfig+: {},
        },
      } + panelSchema;

      local customSchema =
        panelSchema.components.schemas[panelSchema.info.title] {
          type: 'object',
          properties+: {
            options: baseSchema.properties.PanelOptions,
            fieldConfig+: {
              type: 'object',
              properties+: {
                defaults+: {
                  type: 'object',
                  properties+: {
                    custom: baseSchema.properties.PanelFieldConfig,
                  },
                },
              },
            },
          },
        };

      local parsed =
        crdsonnet.fromOpenAPI(
          'customLib',
          customSchema,
          panelSchema,
          render='dynamic',
        )
        + crdsonnet.fromOpenAPI(
          'panelLib',
          dashboardSchema.components.schemas.Panel,
          dashboardSchema,
          render='dynamic',
        );

      parsed.panelLib {
        options: parsed.customLib.options,
        fieldConfig+: {
          defaults+: {
            custom: parsed.customLib.fieldConfig.defaults.custom,
          },
        },
      },
  },
}
