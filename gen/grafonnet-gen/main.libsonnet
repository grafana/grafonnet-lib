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
            + d.package.withUsageTemplate(
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
      local customSchema =
        panelSchema.components.schemas[panelSchema.info.title] {
          type: 'object',
          [if 'properties' in panelSchema then 'properties']+: {
            [if 'PanelOptions' in panelSchema.properties then 'options']:
              panelSchema.properties.PanelOptions,
            [if 'PanelFieldConfig' in panelSchema.properties then 'fieldConfig']: {
              type: 'object',
              properties+: {
                defaults+: {
                  type: 'object',
                  properties+: {
                    custom: panelSchema.properties.PanelFieldConfig,
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
        [if 'options' in parsed.customLib then 'options']:
          parsed.customLib.options,
        fieldConfig+: {
          defaults+: {
            [if 'custom' in parsed.customLib.fieldConfig.defaults then 'custom']:
              parsed.customLib.fieldConfig.defaults.custom,
          },
        },
      },
  },
}
