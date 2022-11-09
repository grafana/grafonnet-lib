local crdsonnet = import 'github.com/Duologic/crdsonnet/crdsonnet/main.libsonnet';
local renderer = import 'github.com/Duologic/crdsonnet/crdsonnet/render.libsonnet';
local schemasRaw = import 'schemas.libsonnet';

function(version='latest', render='static')

  local schemas = {
    [s.info.title]: s
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
