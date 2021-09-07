// layout.libsonnet - a little mixin for the Grafana dashboard type that
// automatically arranges panels on a dashboard, so you don't have to manually
// manage the positions anymore.
//
// We track a cursor in the dashboard and add panels at the cursor, moving
// the cursor to the right after each new panel.  We also expose a function
// to move the cursor to the next row, and track the height of the panels added
// to make this possible.
//
// Usage
//   local grafana = import 'grafonnet-7.0/grafana.libsonnet';
//   local layout = import "grafonnet-7.0/layout.libsonnet";
//
//   local dashboard = grafana.dashboard.new('Empty Dashboard') + layout;
//
//   dashboard
//     .addPanel(...)
//     .addPanel(...)
//     .nextRow()
//     .addPanel(...)
//     .addPanel(...)

{
  // Track where the next panel should go using these private variables, aka "the cursor".
  _cursor:: {
    x: 0,
    y: 0,
    h: 0,
  },

  // addPanels add a panel at the cursor and moves the cursor to the right by the panel width.
  addPanel(panel)::
    local cursor = self._cursor;
    local panelWithPos = panel {
      gridPos+: {
        x: cursor.x,
        y: cursor.y,
      },
    };
    super.addPanel(panelWithPos) + {
      _cursor+:: {
        x+: panel.gridPos.w,
        h:
          if cursor.h > panel.gridPos.h
          then cursor.h
          else panel.gridPos.h,
      },
    },

  // Start a new row beneath the current cursor.
  nextRow():: self + {
    _cursor+:: {
      x: 0,
      y+: super.h,
      h: 0,
    },
  },
}
