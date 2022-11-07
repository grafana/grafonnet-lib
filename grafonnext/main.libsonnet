local crdsonnet = import 'github.com/Duologic/crdsonnet/crdsonnet/main.libsonnet';
local render = import 'github.com/Duologic/crdsonnet/crdsonnet/render.libsonnet';
local schemas = import 'schemas.libsonnet';

function(version='v9.2.3', render='dynamic')

  local schema = {
    [s.info.title]: s
    for s in schemas[version]
  }.dashboard;
  local component = schema.components.schemas.dashboard;

  (if render == 'dynamic'
   then {}
   else '// Generated with `make static-%s.libsonnet`\n' % version)
  + crdsonnet.fromOpenAPI(
    'dashboard',
    component,
    schema,
    render=render,
  )
  + (if render == 'dynamic'
     then (import 'veneer.libsonnet')
     else "\n+ (import 'veneer.libsonnet')")
