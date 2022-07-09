{
  /**
   * Creates a Bosun target
   * to be added to panels.
   *
   * @name bosun.target
   *
   * @param expr Bosun query expression to be executed. Checkout [Bosun documentation](https://bosun.org/expressions).
   * @param hide (optional) Set to `true` to hide the target from the panel.
   *
   * @return A Bousn Query target to be added to panels.
   */

  target(
    expr,
    alias=null,
    expandHelper=0,
    hide=null,
  ):: {
    [if alias != null then 'alias']: alias,
    [if hide != null then 'hide']: hide,
    expr: expr,
    expandHelper: expandHelper,
  },
}
