local crdsonnet = import 'github.com/Duologic/crdsonnet/crdsonnet/main.libsonnet';
local renderer = import 'github.com/Duologic/crdsonnet/crdsonnet/render.libsonnet';
local schemasRaw = import 'github.com/grafana/grok/jsonnet/v9.4.0/imports.libsonnet';
local version="v9.4.0";

local schemas = {
  [s.info.title]:
    s
    + (if 'PanelOptions' in s.components.schemas[s.info.title].properties
       then { components+: { schemas+: {
         [s.info.title]: { '$ref': '#/components/schemas/PanelOptions' },
         PanelOptions: s.components.schemas[s.info.title].properties.PanelOptions,
       } } }
       else {})
    + (if 'PanelLayout' in s.components.schemas[s.info.title].properties
       then { components+: { schemas+: {
         PanelLayout: s.components.schemas[s.info.title].properties.PanelLayout,
       } } }
       else {})
  for s in schemasRaw
};

std.foldl(
  function(acc, k)
    local schema = schemas[k];
    local component = schema.components.schemas[k];
    acc +
    crdsonnet.fromOpenAPI(
      k,
      component,
      schema,
      render='dynamic',
    ),
  std.objectFields(schemas),
  renderer.dynamic.nilvalue
) + (import 'veneer.libsonnet')
