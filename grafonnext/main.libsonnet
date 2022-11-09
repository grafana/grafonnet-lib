local crdsonnet = import 'github.com/Duologic/crdsonnet/crdsonnet/main.libsonnet';
local renderer = import 'github.com/Duologic/crdsonnet/crdsonnet/render.libsonnet';
local schemasRaw = import 'schemas.libsonnet';

function(version='latest', render='dynamic')

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
    for s in schemasRaw[version]
  };

  (if render == 'dynamic'
   then {}
   else '// Generated with `make static-%s.libsonnet`\n' % version)
  + std.foldl(
    function(acc, k)
      local schema = schemas[k];
      local component = schema.components.schemas[k];
      acc +
      crdsonnet.fromOpenAPI(
        k,
        component,
        schema,
        render=render,
      ),
    std.objectFields(schemas),
    renderer[render].nilvalue
  )
  + (if render == 'dynamic'
     then (import 'veneer.libsonnet')
     else "\n+ (import 'veneer.libsonnet')")
