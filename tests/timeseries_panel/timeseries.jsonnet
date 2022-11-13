local grafana = import 'grafonnet/grafana.libsonnet';

local overrides = grafana.timeseriesPanel.overrides;
{
  check_defaults:
    local dash = grafana.timeseriesPanel.new(title='A title');
    {
      sets_title: std.assertEqual('A title', dash.title),
      no_description: std.assertEqual(false, std.objectHas(dash, 'description')),
      transparent_not_set: std.assertEqual(false, std.objectHas(dash, 'transparent')),
      no_links: std.assertEqual([], dash.links),
      no_repeat: std.assertEqual([false, false, false], [
        std.objectHas(dash, 'maxPerRow'),
        std.objectHas(dash, 'repeat'),
        std.objectHas(dash, 'repeatDirection'),
      ]),
      no_targets: std.assertEqual([], dash.targets),
      legend_mode_table_at_bottom: std.assertEqual(
        {
          displayMode: 'list',
          placement: 'bottom',
          calcs: [],
        },
        dash.options.legend
      ),
      tooltip_mode_single: std.assertEqual(
        ['single', 'none'],
        [dash.options.tooltip.mode, dash.options.tooltip.sort]
      ),
      graph_style: {
        lines: std.assertEqual('line', dash.fieldConfig.defaults.custom.drawStyle),
        linear_interpolation: std.assertEqual('linear', dash.fieldConfig.defaults.custom.lineInterpolation),
        line_width_is_1: std.assertEqual(1, dash.fieldConfig.defaults.custom.lineWidth),
        line_is_not_filled: std.assertEqual(0, dash.fieldConfig.defaults.custom.fillOpacity),
        no_gradient: std.assertEqual('none', dash.fieldConfig.defaults.custom.gradientMode),
        line_style_is_solid: std.assertEqual('solid', dash.fieldConfig.defaults.custom.lineStyle.fill),
        nulls_are_not_connected: std.assertEqual(false, dash.fieldConfig.defaults.custom.spanNulls),
        show_points_set_to_auto: std.assertEqual('auto', dash.fieldConfig.defaults.custom.showPoints),
        point_size_is_5: std.assertEqual(5, dash.fieldConfig.defaults.custom.pointSize),
        series_not_stacked: std.assertEqual('none', dash.fieldConfig.defaults.custom.stacking.mode),
        bars_aligned_centre: std.assertEqual(0, dash.fieldConfig.defaults.custom.barAlignment),
      },
      axis_auto_placement: std.assertEqual('auto', dash.fieldConfig.defaults.custom.axisPlacement),
      axis_label_blank: std.assertEqual('', dash.fieldConfig.defaults.custom.axisLabel),
      axis_width_not_set: std.assertEqual(false, std.objectHas(dash.fieldConfig.defaults.custom, 'axisWidth')),
      axis_soft_min_not_set: std.assertEqual(false, std.objectHas(dash.fieldConfig.defaults.custom, 'axisSoftMin')),
      axis_soft_max_not_set: std.assertEqual(false, std.objectHas(dash.fieldConfig.defaults.custom, 'axisSoftMax')),
      axis_show_grid_lines_not_set: std.assertEqual(false, std.objectHas(dash.fieldConfig.defaults.custom, 'showGridLines')),
      axis_linear_scale: std.assertEqual('linear', dash.fieldConfig.defaults.custom.scaleDistribution.type),
      unitless_values: std.assertEqual(false, std.objectHas(dash.fieldConfig.defaults, 'unit')),
      no_minimum: std.assertEqual(false, std.objectHas(dash.fieldConfig.defaults, 'min')),
      no_maximum: std.assertEqual(false, std.objectHas(dash.fieldConfig.defaults, 'max')),
      no_decimals: std.assertEqual(false, std.objectHas(dash.fieldConfig.defaults, 'decimals')),
      classic_palette: std.assertEqual('palette-classic', dash.fieldConfig.defaults.color.mode),
      colored_by_last: std.assertEqual(false, std.objectHas(dash.fieldConfig.defaults.color, 'seriesBy')),
      missing_values_not_mapped: std.assertEqual(false, std.objectHas(dash.fieldConfig.defaults, 'noValue')),
      no_value_mappings: std.assertEqual([], dash.fieldConfig.defaults.mappings),
      thresholds_not_displayed: std.assertEqual('off', dash.fieldConfig.defaults.custom.thresholdsStyle.mode),
      thresholds_are_absolute: std.assertEqual('absolute', dash.fieldConfig.defaults.thresholds.mode),
      no_threshold_steps: std.assertEqual([], dash.fieldConfig.defaults.thresholds.steps),
      no_overrides: std.assertEqual([], dash.fieldConfig.overrides),
    },
  can_set_description: std.assertEqual(
    'A description',
    grafana.timeseriesPanel.new(title='', description='A description').description
  ),
  can_make_transparent: std.assertEqual(
    true,
    grafana.timeseriesPanel.new(title='', transparent=true).transparent
  ),
  can_set_unit: std.assertEqual('s', grafana.timeseriesPanel.new(title='', unit='s').fieldConfig.defaults.unit),
  can_set_min: std.assertEqual(1234, grafana.timeseriesPanel.new(title='', min=1234).fieldConfig.defaults.min),
  can_set_max: std.assertEqual(5678, grafana.timeseriesPanel.new(title='', max=5678).fieldConfig.defaults.max),
  can_set_decimals: std.assertEqual(3, grafana.timeseriesPanel.new(title='', decimals=3).fieldConfig.defaults.decimals),
  can_override_display_name: std.assertEqual('display name', grafana.timeseriesPanel.new(title='', displayName='display name').fieldConfig.defaults.displayName),
  can_set_fixed_color: std.assertEqual({ mode: 'fixed', fixedColor: 'blue' }, grafana.timeseriesPanel.new(title='', colorMode='fixed', fixedColor='blue').fieldConfig.defaults.color),
  can_color_by_min: std.assertEqual('min', grafana.timeseriesPanel.new(title='', colorBy='min').fieldConfig.defaults.color.seriesBy),
  can_map_missing_values: std.assertEqual(123, grafana.timeseriesPanel.new(title='', noValue=123).fieldConfig.defaults.noValue),
  can_display_thresholds: std.assertEqual('line', grafana.timeseriesPanel.new(title='', thresholdDisplay='line').fieldConfig.defaults.custom.thresholdsStyle.mode),
  thresholds_can_be_percentages: std.assertEqual('percentage', grafana.timeseriesPanel.new(title='', thresholdMode='percentage').fieldConfig.defaults.thresholds.mode),
  legend_tests: {
    can_hide: std.assertEqual('hidden', grafana.timeseriesPanel.new(title='', legendMode='hidden').options.legend.displayMode),
    can_display_as_table: std.assertEqual('table', grafana.timeseriesPanel.new(title='', legendMode='table').options.legend.displayMode),
    can_position_at_right: std.assertEqual('right', grafana.timeseriesPanel.new(title='', legendPlacement='right').options.legend.placement),
    can_calculate_summaries: std.assertEqual(['min', 'max', 'mean'], grafana.timeseriesPanel.new(title='', legendValues=['min', 'max', 'mean']).options.legend.calcs),
  },
  graph_style_line_tests: {
    can_set_interpolation: std.assertEqual('smooth', grafana.timeseriesPanel.new(title='', lineInterpolation='smooth').fieldConfig.defaults.custom.lineInterpolation),
    can_set_line_width: std.assertEqual(5, grafana.timeseriesPanel.new(title='', lineWidth=5).fieldConfig.defaults.custom.lineWidth),
    can_set_fill_opacity: std.assertEqual(50, grafana.timeseriesPanel.new(title='', fillOpacity=50).fieldConfig.defaults.custom.fillOpacity),
    can_set_gradient_mode: std.assertEqual('opacity', grafana.timeseriesPanel.new(title='', gradientMode='opacity').fieldConfig.defaults.custom.gradientMode),
    can_set_dashed_line: std.assertEqual({ fill: 'dash', dash: [10, 10] }, grafana.timeseriesPanel.new(title='', lineStyle='dash').fieldConfig.defaults.custom.lineStyle),
    can_set_custom_dash_pattern: std.assertEqual({ fill: 'dash', dash: [12, 34] }, grafana.timeseriesPanel.new(title='', lineStyle='dash', lineDashSegments=[12, 34]).fieldConfig.defaults.custom.lineStyle),
    can_set_dotted_line: std.assertEqual({ fill: 'dot', dash: [0, 10] }, grafana.timeseriesPanel.new(title='', lineStyle='dot').fieldConfig.defaults.custom.lineStyle),
    can_span_null_values: std.assertEqual(true, grafana.timeseriesPanel.new(title='', connectNullValues=true).fieldConfig.defaults.custom.spanNulls),
    can_span_null_values_with_threshold: std.assertEqual(1234, grafana.timeseriesPanel.new(title='', connectNullValues=1234).fieldConfig.defaults.custom.spanNulls),
    can_force_points_to_be_shown: std.assertEqual('always', grafana.timeseriesPanel.new(title='', showPoints='always').fieldConfig.defaults.custom.showPoints),
    can_force_points_to_be_hidden: std.assertEqual('never', grafana.timeseriesPanel.new(title='', showPoints='never').fieldConfig.defaults.custom.showPoints),
    can_set_point_size: std.assertEqual(123, grafana.timeseriesPanel.new(title='', pointSize=123).fieldConfig.defaults.custom.pointSize),
    can_stack_series: std.assertEqual('normal', grafana.timeseriesPanel.new(title='', stackSeries='normal').fieldConfig.defaults.custom.stacking.mode),
    can_stack_series_normalised: std.assertEqual('percent', grafana.timeseriesPanel.new(title='', stackSeries='100%').fieldConfig.defaults.custom.stacking.mode),
    can_align_bars_left: std.assertEqual(-1, grafana.timeseriesPanel.new(title='', barAlignment='left').fieldConfig.defaults.custom.barAlignment),
    can_align_bars_right: std.assertEqual(1, grafana.timeseriesPanel.new(title='', barAlignment='right').fieldConfig.defaults.custom.barAlignment),
  },
  axis_tests: {
    can_align_axis_right: std.assertEqual('right', grafana.timeseriesPanel.new(title='', axisPlacement='right').fieldConfig.defaults.custom.axisPlacement),
    can_label_axis: std.assertEqual('Axis label', grafana.timeseriesPanel.new(title='', axisLabel='Axis label').fieldConfig.defaults.custom.axisLabel),
    can_set_axis_width: std.assertEqual(123, grafana.timeseriesPanel.new(title='', axisWidth=123).fieldConfig.defaults.custom.axisWidth),
    can_set_axis_soft_min: std.assertEqual(123, grafana.timeseriesPanel.new(title='', axisSoftMin=123).fieldConfig.defaults.custom.axisSoftMin),
    can_set_axis_soft_max: std.assertEqual(123, grafana.timeseriesPanel.new(title='', axisSoftMax=123).fieldConfig.defaults.custom.axisSoftMax),
    can_set_log_scale: std.assertEqual({ type: 'log', log: 2 }, grafana.timeseriesPanel.new(title='', axisLogBase=2).fieldConfig.defaults.custom.scaleDistribution),
  },
  repeat_tests: {
    repeats_horizontally_by_default:
      local repeatPanel = grafana.timeseriesPanel.new(title='', repeat='var');
      std.assertEqual(
        ['var', 'h', false],
        [repeatPanel.repeat, repeatPanel.repeatDirection, std.objectHas(repeatPanel, 'maxPerRow')]
      ),
    can_set_direction:
      local repeatPanel = grafana.timeseriesPanel.new(title='', repeat='var', repeatDirection='v');
      std.assertEqual(
        ['var', 'v', false],
        [repeatPanel.repeat, repeatPanel.repeatDirection, std.objectHas(repeatPanel, 'maxPerRow')]
      ),
    can_limit_horizontal_repeat:
      local repeatPanel = grafana.timeseriesPanel.new(title='', repeat='var', repeatMaxPerRow=6);
      std.assertEqual(
        ['var', 'h', 6],
        [repeatPanel.repeat, repeatPanel.repeatDirection, repeatPanel.maxPerRow]
      ),
    horizontal_repeat_ignored_when_vertical:
      std.assertEqual(false, std.objectHas(grafana.timeseriesPanel.new(title='', repeat='var', repeatDirection='v', repeatMaxPerRow=6), 'maxPerRow')),
  },
  targets_tests: {
    can_add_a_target:
      local target = {
        datasource: {
          type: 'datasource',
          uid: 'grafana',
        },
        hide: false,
        refId: 'A',
      };
      std.assertEqual(
        [target],
        grafana.timeseriesPanel.new(title='').addTarget(target).targets
      ),
    can_add_two_targets:
      local target1 = {
        datasource: {
          type: 'datasource',
          uid: 'grafana',
        },
        hide: false,
        refId: 'A',
      };
      local target2 = {
        datasource: {
          type: 'datasource',
          uid: 'grafana',
        },
        hide: false,
        refId: 'B',
      }
      ;
      std.assertEqual(
        [target1, target2],
        grafana.timeseriesPanel.new(title='')
        .addTarget(target1)
        .addTarget(target2)
        .targets
      ),
    can_add_list_of_targets:
      local targets = [
        {
          datasource: {
            type: 'datasource',
            uid: 'grafana',
          },
          hide: false,
          refId: 'A',
        },
        {
          datasource: {
            type: 'datasource',
            uid: 'grafana',
          },
          hide: false,
          refId: 'B',
        },
      ];
      std.assertEqual(
        targets,
        grafana.timeseriesPanel.new(title='')
        .addTargets(targets)
        .targets
      ),
    calculates_refids:
      local targets = [
        {
          datasource: {
            type: 'datasource',
            uid: 'grafana',
          },
          hide: false,
        },
        {
          datasource: {
            type: 'datasource',
            uid: 'grafana',
          },
          hide: false,
        },
      ];
      std.assertEqual(
        [
          targets[0] { refId: 'A' },
          targets[1] { refId: 'B' },
        ],
        grafana.timeseriesPanel.new(title='')
        .addTarget(targets[0])
        .addTarget(targets[1])
        .targets
      ),
  },
  datalinks_tests: {
    can_add_a_data_link:
      std.assertEqual(
        [
          {
            title: '',
            url: 'https://example.org',
          },
        ],
        grafana.timeseriesPanel.new(title='')
        .addDataLink(url='https://example.org')
        .fieldConfig.defaults.links
      ),
    can_add_two_data_links:
      std.assertEqual(
        [
          {
            title: '',
            url: 'https://example.org',
          },
          {
            title: 'A title',
            url: 'https://example.org/path',
            targetBlank: true,
          },
        ],
        grafana.timeseriesPanel.new(title='')
        .addDataLink(url='https://example.org')
        .addDataLink(url='https://example.org/path', title='A title', newWindow=true)
        .fieldConfig.defaults.links
      ),
  },
  mappings_tests: {
    can_add_a_value_mapping:
      std.assertEqual(
        [
          {
            type: 'value',
            options: {
              '123': {
                color: 'purple',
                index: 0,
              },
            },
          },
        ],
        grafana.timeseriesPanel.new(title='')
        .addValueMapping(value='123', color='purple').fieldConfig.defaults.mappings
      ),
    can_add_two_value_mappings:
      std.assertEqual(
        [
          {
            type: 'value',
            options: {
              '123': {
                color: 'purple',
                index: 0,
              },
            },
          },
          {
            type: 'value',
            options: {
              '234': {
                text: 'hello mum',
                color: 'blue',
                index: 1,
              },
            },
          },
        ],
        grafana.timeseriesPanel.new(title='')
        .addValueMapping(value='123', color='purple')
        .addValueMapping(value='234', color='blue', displayText='hello mum')
        .fieldConfig.defaults.mappings
      ),
    can_add_a_range_mapping:
      std.assertEqual(
        [
          {
            type: 'range',
            options: {
              from: 1,
              to: 3,
              result: {
                color: 'yellow',
                index: 0,
              },
            },
          },
        ],
        grafana.timeseriesPanel.new(title='')
        .addRangeMapping(from=1, to=3, color='yellow')
        .fieldConfig.defaults.mappings
      ),
    can_add_two_range_mappings:
      std.assertEqual(
        [
          {
            type: 'range',
            options: {
              from: 1,
              to: 3,
              result: {
                color: 'yellow',
                index: 0,
              },
            },
          },
          {
            type: 'range',
            options: {
              from: 4,
              to: 5,
              result: {
                color: 'orange',
                index: 1,
                text: 'some text',
              },
            },
          },
        ],
        grafana.timeseriesPanel.new(title='')
        .addRangeMapping(from=1, to=3, color='yellow')
        .addRangeMapping(from=4, to=5, color='orange', displayText='some text')
        .fieldConfig.defaults.mappings
      ),
    can_add_a_regex_mapping:
      std.assertEqual(
        [
          {
            type: 'regex',
            options: {
              pattern: 'abc',
              result: {
                color: 'yellow',
                index: 0,
              },
            },
          },
        ],
        grafana.timeseriesPanel.new(title='')
        .addRegexMapping(pattern='abc', color='yellow')
        .fieldConfig.defaults.mappings
      ),
    can_add_two_regex_mappings:
      std.assertEqual(
        [
          {
            type: 'regex',
            options: {
              pattern: 'a.*',
              result: {
                color: 'yellow',
                index: 0,
              },
            },
          },
          {
            type: 'regex',
            options: {
              pattern: 'b.*',
              result: {
                color: 'orange',
                index: 1,
                text: 'some text',
              },
            },
          },
        ],
        grafana.timeseriesPanel.new(title='')
        .addRegexMapping(pattern='a.*', color='yellow')
        .addRegexMapping(pattern='b.*', color='orange', displayText='some text')
        .fieldConfig.defaults.mappings
      ),
    can_add_a_special_mapping:
      std.assertEqual(
        [
          {
            type: 'special',
            options: {
              match: 'null+nan',
              result: {
                color: 'yellow',
                index: 0,
              },
            },
          },
        ],
        grafana.timeseriesPanel.new(title='')
        .addSpecialMapping(match='null+nan', color='yellow')
        .fieldConfig.defaults.mappings
      ),
    can_add_two_special_mappings:
      std.assertEqual(
        [
          {
            type: 'special',
            options: {
              match: 'null+nan',
              result: {
                color: 'yellow',
                index: 0,
              },
            },
          },
          {
            type: 'special',
            options: {
              match: 'false',
              result: {
                color: 'orange',
                index: 1,
                text: 'some text',
              },
            },
          },
        ],
        grafana.timeseriesPanel.new(title='')
        .addSpecialMapping(match='null+nan', color='yellow')
        .addSpecialMapping(match='false', color='orange', displayText='some text')
        .fieldConfig.defaults.mappings
      ),
  },
  override_tests: {
    can_override_a_named_field:
      local overrides = [{ id: 'custom.drawStyle', value: 'bars' }];
      std.assertEqual(
        [
          {
            matcher: { id: 'byName', options: 'A-series' },
            properties: [{ id: 'custom.drawStyle', value: 'bars' }],
          },
        ],
        grafana.timeseriesPanel.new(title='')
        .addOverridesForField(field='A-series', overrides=overrides)
        .fieldConfig.overrides
      ),
    can_override_fields_matching_regex:
      local overrides = [{ id: 'custom.drawStyle', value: 'bars' }];
      std.assertEqual(
        [
          {
            matcher: { id: 'byRegexp', options: '^[ab].*' },
            properties: [{ id: 'custom.drawStyle', value: 'bars' }],
          },
        ],
        grafana.timeseriesPanel.new(title='')
        .addOverridesForFieldsMatchingRegex(regex='^[ab].*', overrides=overrides)
        .fieldConfig.overrides
      ),
    can_override_fields_of_a_type:
      local overrides = [{ id: 'custom.drawStyle', value: 'bars' }];
      std.assertEqual(
        [
          {
            matcher: { id: 'byType', options: 'number' },
            properties: [{ id: 'custom.drawStyle', value: 'bars' }],
          },
        ],
        grafana.timeseriesPanel.new(title='')
        .addOverridesForFieldsOfType(type='number', overrides=overrides)
        .fieldConfig.overrides
      ),
    can_override_fields_from_query:
      std.assertEqual(
        [
          {
            matcher: { id: 'byFrameRefID', options: 'A' },
            properties: [{ id: 'custom.drawStyle', value: 'bars' }],
          },
        ],
        grafana.timeseriesPanel.new(title='')
        .addOverridesForQuery(queryId='A', overrides=[overrides.graphStyle('bars')])
        .fieldConfig.overrides
      ),
  },
  tooltip_tests: {
    can_hide: std.assertEqual({
      mode: 'none',
      sort: 'none',
    }, grafana.timeseriesPanel.new(title='', tooltip='hidden').options.tooltip),
    can_show_all: std.assertEqual({
      mode: 'multi',
      sort: 'none',
    }, grafana.timeseriesPanel.new(title='', tooltip='all').options.tooltip),
    can_sort_when_all: std.assertEqual({
      mode: 'multi',
      sort: 'asc',
    }, grafana.timeseriesPanel.new(title='', tooltip='all', tooltipSort='ascending').options.tooltip),
    sort_ignored_when_not_all: std.assertEqual({
      mode: 'single',
      sort: 'none',
    }, grafana.timeseriesPanel.new(title='', tooltip='single', tooltipSort='ascending').options.tooltip),
  },
  can_add_a_threshold:
    std.assertEqual(
      [{ color: 'green', value: null }],
      grafana.timeseriesPanel.new(title='')
      .addThreshold(color='green')
      .fieldConfig.defaults.thresholds.steps
    ),
  can_add_two_thresholds:
    std.assertEqual(
      [
        {
          color: 'green',
          value: null,
        },
        {
          color: 'red',
          value: 80,
        },
      ],
      grafana.timeseriesPanel.new(title='')
      .addThreshold(color='green')
      .addThreshold(color='red', value=80)
      .fieldConfig.defaults.thresholds.steps
    ),
}
