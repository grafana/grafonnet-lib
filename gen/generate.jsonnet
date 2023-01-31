local filesFor(version) = {
  'grafana-version': version,

  'main.libsonnet': |||
    local grafonnet = import 'github.com/grafana/grafonnet-lib/gen/grafonnet-gen/main.libsonnet';
    local schemas = import './schemas.libsonnet';
    local version = importstr './grafana-version';
    grafonnet.new(schemas, version)
  |||,

  'schemas.libsonnet': |||
    import 'github.com/grafana/grok/jsonnet/%s/imports.libsonnet'
  ||| % version,

  'docs.libsonnet': |||
    local grafonnet = import 'github.com/grafana/grafonnet-lib/gen/grafonnet-gen/main.libsonnet';
    local main = import './main.libsonnet';
    grafonnet.docs(main)
  |||,

  'jsonnetfile.json': std.manifestJsonEx({
    version: 1,
    dependencies: [
      {
        source: {
          git: {
            remote: 'https://github.com/grafana/grafonnet-lib.git',
            subdir: 'gen/grafonnet-gen',
          },
        },
        version: 'malcolmholmes/generated-grafonnet-mk2',
      },
      {
        source: {
          git: {
            remote: 'https://github.com/grafana/grok.git',
            subdir: 'jsonnet/%s' % version,
          },
        },
        version: 'malcolmholmes/add-jsonnet-support',
      },
    ],
    legacyImports: false,
  }, '  '),
};

local versions = [
  'v9.4.0',
];

local baseDir = 'grafonnet';

std.foldl(
  function(acc, version)
    local files = filesFor(version);
    acc + {
      [std.join('/', [baseDir, version, filename])]: files[filename]
      for filename in std.objectFields(files)
    },
  versions,
  {}
)
