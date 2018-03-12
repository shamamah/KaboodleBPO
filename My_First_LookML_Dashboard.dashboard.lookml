- dashboard: MyFirstLookMLDashboard
  title: LookML Dashboard P & D Performance
  layout: newspaper
  query_timezone: query_saved
  elements:
  - name: Previous 1 Month
    title: Previous 1 Month
    model: KaboodleBPO
    explore: print_and_distribution
    type: looker_bar
    fields:
    - service_job_type.dscr
    - print_and_distribution.aggregate_pass_count
    - print_and_distribution.aggregate_fail_count
    - print_and_distribution.aggregate_total_count
    - print_and_distribution.aggregate_sla_expected
    filters:
      print_and_distribution.sla_month_month: 1 months ago for 1 months
      customer.customer_name: ''
    sorts:
    - service_job_type.dscr desc
    limit: 500
    dynamic_fields:
    - table_calculation: actual
      label: Actual
      expression: "${print_and_distribution.aggregate_pass_count}*100/${print_and_distribution.aggregate_total_count}"
      value_format:
      value_format_name: decimal_1
      _kind_hint: measure
      _type_hint: number
    - table_calculation: sla
      label: SLA
      expression: "${print_and_distribution.aggregate_sla_expected}"
      value_format:
      value_format_name: decimal_1
      _kind_hint: measure
      _type_hint: number
    query_timezone: America/Los_Angeles
    stacking: ''
    show_value_labels: true
    label_density: 25
    legend_position: center
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: true
    limit_displayed_rows: false
    y_axis_combined: true
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: false
    show_x_axis_ticks: true
    x_axis_scale: auto
    y_axis_scale_mode: linear
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    series_types: {}
    hidden_fields:
    - print_and_distribution.aggregate_pass_count
    - print_and_distribution.aggregate_fail_count
    - print_and_distribution.aggregate_total_count
    - print_and_distribution.aggregate_sla_expected
    x_axis_reversed: true
    x_axis_label: ''
    y_axis_reversed: false
    y_axes:
    - label: ''
      maxValue: 100
      minValue: 0
      orientation: bottom
      showLabels: true
      showValues: true
      tickDensity: default
      tickDensityCustom: 5
      type: linear
      unpinAxis: false
      valueFormat: ''
      series:
      - id: sla_actual
        name: SLA Actual
        axisId: sla_actual
      - id: print_and_distribution.aggregate_sla_expected
        name: Print and Distribution SLA Expected
        axisId: print_and_distribution.aggregate_sla_expected
    label_value_format: 0\%
    listen:
      Customer: customer.customer_name
    row: 0
    col: 0
    width: 8
    height: 8
  - name: Volume YTD
    title: Volume YTD
    model: KaboodleBPO
    explore: print_and_distribution
    type: looker_bar
    fields:
    - service_job_type.dscr
    - print_and_distribution.aggregate_pass_count
    - print_and_distribution.aggregate_fail_count
    - print_and_distribution.aggregate_total_count
    filters:
      print_and_distribution.sla_month_month: 1 years
    sorts:
    - print_and_distribution.aggregate_pass_count desc
    limit: 500
    dynamic_fields:
    - table_calculation: met_sla
      label: Met SLA
      expression: "${print_and_distribution.aggregate_pass_count}"
      value_format: "#,##0"
      value_format_name:
      _kind_hint: measure
      _type_hint: number
    - table_calculation: total_volume
      label: Total Volume
      expression: "${print_and_distribution.aggregate_total_count}"
      value_format: "#,##0"
      value_format_name:
      _kind_hint: measure
      _type_hint: number
    query_timezone: America/Los_Angeles
    stacking: ''
    show_value_labels: true
    label_density: 25
    legend_position: center
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: false
    limit_displayed_rows: false
    y_axis_combined: true
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: false
    show_x_axis_ticks: true
    x_axis_scale: auto
    y_axis_scale_mode: linear
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    font_size: '12'
    map_plot_mode: points
    heatmap_gridlines: false
    heatmap_gridlines_empty: false
    heatmap_opacity: 0.5
    show_region_field: true
    draw_map_labels_above_data: true
    map_tile_provider: positron
    map_position: fit_data
    map_scale_indicator: 'off'
    map_pannable: true
    map_zoomable: true
    map_marker_type: circle
    map_marker_icon_name: default
    map_marker_radius_mode: proportional_value
    map_marker_units: meters
    map_marker_proportional_scale_type: linear
    map_marker_color_mode: fixed
    show_legend: true
    quantize_map_value_colors: false
    reverse_map_value_colors: false
    value_labels: legend
    label_type: labPer
    show_null_points: true
    point_style: none
    interpolation: linear
    hidden_series: []
    hide_legend: false
    limit_displayed_rows_values:
      show_hide: hide
      first_last: first
      num_rows: 0
    series_colors:
      print_and_distribution.aggregate_fail_count: "#cc2b67"
      print_and_distribution.aggregate_pass_count: "#1ac115"
      print_and_distribution.aggregate_total_count: "#1e2f7f"
    series_types: {}
    hidden_fields:
    - print_and_distribution.aggregate_fail_count
    - print_and_distribution.aggregate_pass_count
    - print_and_distribution.aggregate_total_count
    x_axis_label: ''
    y_axes:
    - label: ''
      maxValue:
      minValue:
      orientation: bottom
      showLabels: true
      showValues: true
      tickDensity: default
      tickDensityCustom: 5
      type: linear
      unpinAxis: false
      valueFormat:
      series:
      - id: print_and_distribution.aggregate_pass_count
        name: Pass Count
        axisId: print_and_distribution.aggregate_pass_count
      - id: print_and_distribution.aggregate_total_count
        name: Total Count
        axisId: print_and_distribution.aggregate_total_count
    x_axis_reversed: true
    listen:
      Customer: customer.customer_name
    row: 8
    col: 12
    width: 12
    height: 8
  - name: Previous 3 Months
    title: Previous 3 Months
    model: KaboodleBPO
    explore: print_and_distribution
    type: looker_bar
    fields:
    - service_job_type.dscr
    - print_and_distribution.aggregate_pass_count
    - print_and_distribution.aggregate_fail_count
    - print_and_distribution.aggregate_total_count
    - print_and_distribution.aggregate_sla_expected
    filters:
      customer.customer_name: ''
      print_and_distribution.sla_month_month: 3 months ago for 3 months
    sorts:
    - service_job_type.dscr desc
    limit: 500
    dynamic_fields:
    - table_calculation: actual
      label: Actual
      expression: "${print_and_distribution.aggregate_pass_count}*100/${print_and_distribution.aggregate_total_count}"
      value_format:
      value_format_name: decimal_1
      _kind_hint: measure
      _type_hint: number
    - table_calculation: sla
      label: SLA
      expression: "${print_and_distribution.aggregate_sla_expected}"
      value_format:
      value_format_name: decimal_1
      _kind_hint: measure
      _type_hint: number
    query_timezone: America/Los_Angeles
    stacking: ''
    show_value_labels: true
    label_density: 25
    legend_position: center
    x_axis_gridlines: true
    y_axis_gridlines: true
    show_view_names: true
    limit_displayed_rows: false
    y_axis_combined: true
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: false
    show_x_axis_ticks: true
    x_axis_scale: auto
    y_axis_scale_mode: linear
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    series_types: {}
    hidden_fields:
    - print_and_distribution.aggregate_pass_count
    - print_and_distribution.aggregate_fail_count
    - print_and_distribution.aggregate_total_count
    - print_and_distribution.aggregate_sla_expected
    x_axis_reversed: true
    x_axis_label: Job Types
    y_axis_reversed: false
    y_axes:
    - label: ''
      maxValue: 100
      minValue: 0
      orientation: bottom
      showLabels: true
      showValues: true
      tickDensity: default
      tickDensityCustom: 5
      type: linear
      unpinAxis: false
      valueFormat: ''
      series:
      - id: sla_actual
        name: SLA Actual
        axisId: sla_actual
      - id: print_and_distribution.aggregate_sla_expected
        name: Print and Distribution SLA Expected
        axisId: print_and_distribution.aggregate_sla_expected
    label_value_format: 0\%
    listen:
      Customer: customer.customer_name
    row: 0
    col: 8
    width: 8
    height: 8
  - name: Previous 6 Months
    title: Previous 6 Months
    model: KaboodleBPO
    explore: print_and_distribution
    type: looker_bar
    fields:
    - service_job_type.dscr
    - print_and_distribution.aggregate_pass_count
    - print_and_distribution.aggregate_fail_count
    - print_and_distribution.aggregate_total_count
    - print_and_distribution.aggregate_sla_expected
    filters:
      customer.customer_name: ''
      print_and_distribution.sla_month_month: 6 months ago for 6 months
    sorts:
    - service_job_type.dscr desc
    limit: 500
    dynamic_fields:
    - table_calculation: actual
      label: Actual
      expression: "${print_and_distribution.aggregate_pass_count}*100/${print_and_distribution.aggregate_total_count}"
      value_format:
      value_format_name: decimal_1
      _kind_hint: measure
      _type_hint: number
    - table_calculation: sla
      label: SLA
      expression: "${print_and_distribution.aggregate_sla_expected}"
      value_format:
      value_format_name: decimal_1
      _kind_hint: measure
      _type_hint: number
    query_timezone: America/Los_Angeles
    stacking: ''
    show_value_labels: true
    label_density: 25
    legend_position: center
    x_axis_gridlines: true
    y_axis_gridlines: true
    show_view_names: true
    limit_displayed_rows: false
    y_axis_combined: true
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: false
    show_x_axis_ticks: true
    x_axis_scale: auto
    y_axis_scale_mode: linear
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    series_types: {}
    hidden_fields:
    - print_and_distribution.aggregate_pass_count
    - print_and_distribution.aggregate_fail_count
    - print_and_distribution.aggregate_total_count
    - print_and_distribution.aggregate_sla_expected
    x_axis_reversed: true
    x_axis_label: Job Types
    y_axis_reversed: false
    y_axes:
    - label: ''
      maxValue: 100
      minValue: 0
      orientation: bottom
      showLabels: true
      showValues: true
      tickDensity: default
      tickDensityCustom: 5
      type: linear
      unpinAxis: false
      valueFormat: ''
      series:
      - id: sla_actual
        name: SLA Actual
        axisId: sla_actual
      - id: print_and_distribution.aggregate_sla_expected
        name: Print and Distribution SLA Expected
        axisId: print_and_distribution.aggregate_sla_expected
    label_value_format: 0\%
    listen:
      Customer: customer.customer_name
    row: 0
    col: 16
    width: 8
    height: 8
  - name: Volume Last Month
    title: Volume Last Month
    model: KaboodleBPO
    explore: print_and_distribution
    type: looker_bar
    fields:
    - service_job_type.dscr
    - print_and_distribution.aggregate_pass_count
    - print_and_distribution.aggregate_fail_count
    - print_and_distribution.aggregate_total_count
    filters:
      print_and_distribution.sla_month_month: 1 months ago for 1 months
    sorts:
    - print_and_distribution.aggregate_pass_count desc
    limit: 500
    dynamic_fields:
    - table_calculation: met_sla
      label: Met SLA
      expression: "${print_and_distribution.aggregate_pass_count}"
      value_format: "#,##0"
      value_format_name:
      _kind_hint: measure
      _type_hint: number
    - table_calculation: total_volume
      label: Total Volume
      expression: "${print_and_distribution.aggregate_total_count}"
      value_format: "#,##0"
      value_format_name:
      _kind_hint: measure
      _type_hint: number
    query_timezone: America/Los_Angeles
    stacking: ''
    show_value_labels: true
    label_density: 25
    legend_position: center
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: false
    limit_displayed_rows: false
    y_axis_combined: true
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: false
    show_x_axis_ticks: true
    x_axis_scale: auto
    y_axis_scale_mode: linear
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    font_size: '12'
    map_plot_mode: points
    heatmap_gridlines: false
    heatmap_gridlines_empty: false
    heatmap_opacity: 0.5
    show_region_field: true
    draw_map_labels_above_data: true
    map_tile_provider: positron
    map_position: fit_data
    map_scale_indicator: 'off'
    map_pannable: true
    map_zoomable: true
    map_marker_type: circle
    map_marker_icon_name: default
    map_marker_radius_mode: proportional_value
    map_marker_units: meters
    map_marker_proportional_scale_type: linear
    map_marker_color_mode: fixed
    show_legend: true
    quantize_map_value_colors: false
    reverse_map_value_colors: false
    value_labels: legend
    label_type: labPer
    show_null_points: true
    point_style: none
    interpolation: linear
    hidden_series: []
    hide_legend: false
    limit_displayed_rows_values:
      show_hide: hide
      first_last: first
      num_rows: 0
    series_colors:
      print_and_distribution.aggregate_fail_count: "#cc2b67"
      print_and_distribution.aggregate_pass_count: "#1ac115"
      print_and_distribution.aggregate_total_count: "#1e2f7f"
    series_types: {}
    hidden_fields:
    - print_and_distribution.aggregate_fail_count
    - print_and_distribution.aggregate_pass_count
    - print_and_distribution.aggregate_total_count
    x_axis_label: ''
    y_axes:
    - label: ''
      maxValue:
      minValue:
      orientation: bottom
      showLabels: true
      showValues: true
      tickDensity: default
      tickDensityCustom: 5
      type: linear
      unpinAxis: false
      valueFormat:
      series:
      - id: print_and_distribution.aggregate_pass_count
        name: Pass Count
        axisId: print_and_distribution.aggregate_pass_count
      - id: print_and_distribution.aggregate_total_count
        name: Total Count
        axisId: print_and_distribution.aggregate_total_count
    x_axis_reversed: true
    listen:
      Customer: customer.customer_name
    row: 8
    col: 0
    width: 12
    height: 8
  filters:
  - name: Customer
    title: Customer
    type: field_filter
    default_value: ''
    model: KaboodleBPO
    explore: print_and_distribution
    field: customer.customer_name
    listens_to_filters: []
    allow_multiple_values: true
    required: false
