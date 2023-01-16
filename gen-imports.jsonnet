local composableKinds = import 'schemas/composable-index.json';
local coreKinds = import 'schemas/core-index.json';


local start = '{\n';
local makeImport(kinds, schemaInterface) = function(kind, acc) acc + "  %(name)s: import 'schemas/%(file)s', // %(schemaInterface)s\n" % { name: kind.kind, file: kinds[kind.kind][kind.version], schemaInterface: schemaInterface };
local coreImports(reg) = std.foldr(makeImport(coreKinds, 'Core'), reg, '');
local schemaInterfaces(reg) = std.map(function(v) v.schemaInterface, std.set(reg, function(v) v.schemaInterface));
local filterComposables(reg, schemaInterface) = std.filter(function(kind) kind.schemaInterface == schemaInterface, reg);
local composableImportsFor(reg, schemaInterface) = std.foldr(makeImport(composableKinds, schemaInterface), filterComposables(reg, schemaInterface), '');
local composableImports(reg) = std.foldr(function(schemaInterface, acc) acc + composableImportsFor(reg, schemaInterface), schemaInterfaces(reg), '');
local end = '}\n';

function(coreRegistry, composableRegistry)
  start
  + coreImports(coreRegistry)
  + composableImports(composableRegistry)
  + end

/*
CORE REGISTRY: [
  {
    "kind": "dashboard",
    "version": "x"
  },
  {
    "kind": "playlist",
    "version": "x"
  },
  {
    "kind": "team",
    "version": "x"
  }
]
CORE INDEX: {
  "dashboard": {
    "x": "kinds/core/dashboard/x/dashboard_types_gen.json"
  },
  "playlist": {
    "x": "kinds/core/playlist/x/playlist_types_gen.json"
  },
  "team": {
    "x": "kinds/core/team/x/team_types_gen.json"
  }
}
COMPOSABLE {
  "annolist": {
    "x": "kinds/composable/annolist/x/annolist_types_gen.json"
  },
  "barchart": {
    "x": "kinds/composable/barchart/x/barchart_types_gen.json"
  },
  "bargauge": {
    "x": "kinds/composable/bargauge/x/bargauge_types_gen.json"
  },
  "dashlist": {
    "x": "kinds/composable/dashlist/x/dashlist_types_gen.json"
  },
  "gauge": {
    "x": "kinds/composable/gauge/x/gauge_types_gen.json"
  },
  "histogram": {
    "x": "kinds/composable/histogram/x/histogram_types_gen.json"
  },
  "news": {
    "x": "kinds/composable/news/x/news_types_gen.json"
  },
  "piechart": {
    "x": "kinds/composable/piechart/x/piechart_types_gen.json"
  },
  "stat": {
    "x": "kinds/composable/stat/x/stat_types_gen.json"
  },
  "text": {
    "x": "kinds/composable/text/x/text_types_gen.json"
  }
}

*/
