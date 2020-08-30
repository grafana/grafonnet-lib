{
  /**
   * Creates a [Loki target](https://grafana.com/docs/grafana/latest/features/datasources/loki/)
   *
   * @name loki.target
   *
   * @param expr
   * @param hide (optional) Disable query on graph.
   */
  target(
    expr,
    hide=null,
  ):: {
    [if hide != null then 'hide']: hide,
    expr: expr,
  },
}
