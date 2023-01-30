{
  dashboard+: {
    new(title):
      self.withTitle(title)
      + self.withTimezone('utc')
      + self.time.withFrom('now-6h')
      + self.time.withTo('now'),

    panels+: {
      'dashboard.GraphPanel'+:: {},
      graphPanel+: self['dashboard.GraphPanel'] {
        new(title):
          self.withTitle(title)
          + self.withType('graph'),
      },
      'dashboard.HeatmapPanel'+:: {},
      heatmapPanel+: self['dashboard.HeatmapPanel'] {
        new(title):
          self.withTitle(title)
          + self.withType('heatmap'),
      },
      'dashboard.Panel'+:: {},
      panel+: self['dashboard.Panel'] {
        new(title, type):
          self.withTitle(title)
          + self.withType(type),
      },
      'dashboard.RowPanel'+:: {},
      rowPanel+: self['dashboard.RowPanel'] {
        new(title):
          self.withTitle(title)
          + self.withType(),
      },
    },
  },
}
