local grafana = import 'grafonnet/grafana.libsonnet';
local dashboard = grafana.dashboard;
local row = grafana.row;
local link = grafana.link;


[
  dashboard.new('test')
  .addTemplate({ test1: true })
  .addTemplates([{ test2: true }, { test3: true }])
  .addRow(row.new(title='1', height='250px'))
  .addRow(row.new(title='2', height='250px'))
  .addRows([row.new(title='1', height='250px'), row.new(title='2', height='250px')])
  .addAnnotation('foo')
  .addAnnotation('bar')
  .addAnnotations(['foo2', 'bar2'])
  .addLink('foolinks')
  .addLink('barlinks')
  .addLinks([link.dashboards('foo', ['foo', 'bar']), link.dashboards('bar', ['foo', 'bar'])]),
  dashboard.new('test2')
  .addPanel(row.new(title='id0'), { x: 14, y: 42, w: 33, h: 26 })
  .addPanel(row.new(title='id1'), { x: 24, y: 52, w: 43, h: 36 })
  .addPanel(row.new(title='id2'), { x: 34, y: 62, w: 53, h: 36 })
  .addPanel(row.new(title='id5'), { x: 44, y: 72, w: 63, h: 46 })
  .addPanels([row.new(title='id5') + { x: 41, y: 71, w: 61, h: 41 }]),
  dashboard.new('test2')
  .addPanel(row.new(title='id0'), { x: 14, y: 42, w: 33, h: 26 })
  .addPanel(row.new(title='id1'), { x: 24, y: 52, w: 43, h: 36 })
  .addPanel(row.new(title='id2'), { x: 34, y: 62, w: 53, h: 36 })
  .addPanel(row.new(title='id5'), { x: 44, y: 72, w: 63, h: 46 }),
  dashboard.new('subId')
  .addPanels(
    [
      row.new(title='id0', height='250px') + {
        panels: [
          { foo: 'id1' },
          { bar: 'id2' },
        ],
      },
      row.new(title='id3', height='250px'),
      row.new(title='id4', height='250px'),
      { title: 'id5' },
      { title: 'id6' },
      { title: 'id7' },
      { title: 'id8' },
      row.new(title='id9', height='250px') + {
        panels: [
          { foo: 'id10' },
          { bar: 'id11' },
        ],
      },
      { title: 'id12' },
      { title: 'id13' },
      { title: 'id14' },
    ]
  )
  .addPanels(
    [
      row.new(title='id15') + {
        panels: [
          { foo: 'id16' },
          { bar: 'id17' },
        ],
      },
      row.new(title='id18'),
      row.new(title='id19'),
      { title: 'id20' },
      { title: 'id21' },
      { title: 'id22' },
      { title: 'id23' },
    ]
  ),
  dashboard.new('test3')
  .addPanel({ foo: 'bar' }, { x: 14, y: 42, w: 33, h: 26 })
  .addPanel({ foo: 'bar' }, { x: 24, y: 52, w: 43, h: 36 })
  .addPanel({ foo: 'bar' }, { x: 34, y: 62, w: 53, h: 36 })
  .addPanel({ foo: 'bar' }, { x: 44, y: 72, w: 63, h: 46 }),
]
