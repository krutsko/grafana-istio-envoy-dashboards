local g = import 'lib/g.libsonnet';

local row = g.panel.row;

local panels = import 'lib/panels.libsonnet';
local variables = import 'lib/variables.libsonnet';
local queries = import 'lib/queries.libsonnet';
local outlier_detection_queries = import 'lib/outlier_detection_queries.libsonnet';

// Create base dashboard first
local baseDashboard = g.dashboard.new('Istio Envoy Outlier Detection')
+ g.dashboard.withDescription(|||
  Dashboard showing Istio Envoy Outlier Detection metrics for monitoring service health and failure patterns
|||)
+ g.dashboard.graphTooltip.withSharedCrosshair()
+ g.dashboard.withVariables([
  // Fixed datasource variable for external sharing
  {
    name: 'datasource',
    type: 'datasource',
    query: 'prometheus',
    current: {
      selected: false,
      text: 'Prometheus',
      value: 'Prometheus'
    },
    hide: 0,
    includeAll: false,
    multi: false,
    options: [],
    refresh: 1,
    regex: '',
    skipUrlSync: false,
    label: 'Data Source'
  },
  {
    name: 'clusterNameLabel',
    type: 'custom',
    datasource: {
      type: 'prometheus',
      uid: '${datasource}'
    },
    definition: 'cluster_name',
    query: 'cluster_name',
    hide: 2,
    options: [
      {
        selected: true,
        text: 'cluster_name',
        value: 'cluster_name'
      }
    ],
    current: {
      selected: false,
      text: 'cluster_name',
      value: 'cluster_name'
    },
    regex: '',
    skipUrlSync: false,
    multi: false,
    includeAll: false,
    allValue: '.*',
    refresh: 1,
    sort: 0
  },
  {
    name: 'Namespace',
    type: 'query',
    datasource: {
      type: 'prometheus',
      uid: '${datasource}'
    },
    definition: 'label_values(envoy_cluster_upstream_rq_total,namespace)',
    query: 'label_values(envoy_cluster_upstream_rq_total,namespace)',
    hide: 0,
    options: [],
    regex: '',
    skipUrlSync: false,
    multi: false,
    includeAll: false,
    allValue: '.*',
    refresh: 1,
    sort: 0
  },
  {
    name: 'app',
    type: 'query',
    allowCustomValue: true,
    datasource: {
      type: 'prometheus',
      uid: '${datasource}'
    },
    definition: 'query_result(sum({namespace="$Namespace",__name__="envoy_server_version"}) by (pod))',
    query: {
      qryType: 3,
      query: 'query_result(sum({namespace="$Namespace",__name__="envoy_server_version"}) by (pod))',
      refId: 'PrometheusVariableQueryEditor-VariableQuery'
    },
    regex: '/^{pod="([^-"]+).*$/',
    includeAll: false,
    options: [],
    refresh: 1,
    sort: 1,
    allValue: '.*',
  },
  {
    name: 'pod',
    type: 'query',
    datasource: {
      type: 'prometheus',
      uid: '${datasource}'
    },
    definition: 'query_result(sum({namespace="$Namespace",__name__="envoy_server_version", pod=~"$app-.*"}) by (pod))',
    query: {
      qryType: 3,
      query: 'query_result(sum({namespace="$Namespace",__name__="envoy_server_version", pod=~"$app-.*"}) by (pod))',
      refId: 'PrometheusVariablePod'
    },
    regex: '/pod="([^"]+)"/',
    multi: true,
    includeAll: false,
    refresh: 2,
    sort: 1,
    options: [],
    allValue: '.*',
  },
  {
    name: 'cluster',
    type: 'query',
    datasource: {
      type: 'prometheus',
      uid: '${datasource}'
    },
    definition: 'query_result(sum({namespace="$Namespace",__name__="envoy_cluster_upstream_rq_total", pod=~"$app-.*"}) by ($clusterNameLabel))',
    query: {
      qryType: 3,
      query: 'query_result(sum({namespace="$Namespace",__name__="envoy_cluster_upstream_rq_total", pod=~"$app-.*"}) by ($clusterNameLabel))',
      refId: 'PrometheusVariableQueryEditor-VariableQuery'
    },
    hide: 0,
    options: [],
    regex: '/^{.*="(.*)"}/',
    skipUrlSync: false,
    multi: false,
    includeAll: false,
    allValue: '.*',
    refresh: 1,
    sort: 0
  },
  {
    name: 'quantiles',
    type: 'custom',
    datasource: {
      type: 'prometheus',
      uid: '${datasource}'
    },
    definition: '0.9',
    query: '0.9',
    hide: 2,
    options: [
      {
        selected: true,
        text: '0.9',
        value: '0.9'
      }
    ],
    current: {
      selected: false,
      text: '0.9',
      value: '0.9'
    },
    regex: '',
    skipUrlSync: false,
    multi: false,
    includeAll: false,
    allValue: '.*',
    refresh: 1,
    sort: 0
  }
])
+ g.dashboard.withPanels(
    g.util.grid.makeGrid([
  
    row.new('Outlier Detection Overview')
    + row.withCollapsed(false)
    + row.withPanels([
        panels.text.markdown('Outlier Detection Overview', 'This section shows basic outlier detection metrics across all clusters.'),
        // Basic overview metrics
        panels.timeSeries.rate('All Enforced Ejections by Cluster', outlier_detection_queries.outlier_detection_ejections_enforced_total_overview),
        panels.timeSeries.short('Currently Ejected Hosts by Cluster', outlier_detection_queries.outlier_detection_ejections_active_overview),
    ]),
    row.new('Outlier Detection Ejections')
    + row.withCollapsed(false)
    + row.withPanels([
        panels.text.markdown('Outlier Detection Info', 'This section shows Envoy outlier detection metrics that help identify unhealthy upstream hosts and automatically eject them from load balancing.'),
        // Overview Metrics
        panels.timeSeries.rate('Total Enforced Ejections', outlier_detection_queries.envoy_cluster_outlier_detection_ejections_enforced_total),
        panels.timeSeries.short('Currently Ejected Hosts', outlier_detection_queries.envoy_cluster_outlier_detection_ejections_active),
        panels.timeSeries.rate('Ejections Overflow (Max % Reached)', outlier_detection_queries.envoy_cluster_outlier_detection_ejections_overflow),
    ]),
    row.new('Consecutive 5xx Ejections')
    + row.withCollapsed(false)
    + row.withPanels([
        panels.text.markdown('Consecutive 5xx Ejections', 'Metrics for hosts ejected due to consecutive 5xx responses.'),
        panels.timeSeries.rate('Enforced Consecutive 5xx Ejections', outlier_detection_queries.envoy_cluster_outlier_detection_ejections_enforced_consecutive_5xx),
        panels.timeSeries.rate('Detected Consecutive 5xx Ejections', outlier_detection_queries.envoy_cluster_outlier_detection_ejections_detected_consecutive_5xx),
    ]),
    row.new('Success Rate Ejections')
    + row.withCollapsed(false)
    + row.withPanels([
        panels.text.markdown('Success Rate Ejections', 'Metrics for hosts ejected due to low success rates.'),
        panels.timeSeries.rate('Enforced Success Rate Ejections', outlier_detection_queries.envoy_cluster_outlier_detection_ejections_enforced_success_rate),
        panels.timeSeries.rate('Detected Success Rate Ejections', outlier_detection_queries.envoy_cluster_outlier_detection_ejections_detected_success_rate),
    ]),
    row.new('Gateway Failure Ejections')
    + row.withCollapsed(false)
    + row.withPanels([
        panels.text.markdown('Gateway Failure Ejections', 'Metrics for hosts ejected due to consecutive gateway failures.'),
        panels.timeSeries.rate('Enforced Gateway Failure Ejections', outlier_detection_queries.envoy_cluster_outlier_detection_ejections_enforced_consecutive_gateway_failure),
        panels.timeSeries.rate('Detected Gateway Failure Ejections', outlier_detection_queries.envoy_cluster_outlier_detection_ejections_detected_consecutive_gateway_failure),
    ]),
    row.new('Local Origin Failure Ejections')
    + row.withCollapsed(false)
    + row.withPanels([
        panels.text.markdown('Local Origin Failure Ejections', 'Metrics for hosts ejected due to consecutive local origin failures.'),
        panels.timeSeries.rate('Enforced Local Origin Failure Ejections', outlier_detection_queries.envoy_cluster_outlier_detection_ejections_enforced_consecutive_local_origin_failure),
        panels.timeSeries.rate('Detected Local Origin Failure Ejections', outlier_detection_queries.envoy_cluster_outlier_detection_ejections_detected_consecutive_local_origin_failure),
    ]),
    row.new('Local Origin Success Rate Ejections')
    + row.withCollapsed(false)
    + row.withPanels([
        panels.text.markdown('Local Origin Success Rate Ejections', 'Metrics for hosts ejected due to low local origin success rates.'),
        panels.timeSeries.rate('Enforced Local Origin Success Rate Ejections', outlier_detection_queries.envoy_cluster_outlier_detection_ejections_enforced_local_origin_success_rate),
        panels.timeSeries.rate('Detected Local Origin Success Rate Ejections', outlier_detection_queries.envoy_cluster_outlier_detection_ejections_detected_local_origin_success_rate),
    ]),
    row.new('Failure Percentage Ejections')
    + row.withCollapsed(false)
    + row.withPanels([
        panels.text.markdown('Failure Percentage Ejections', 'Metrics for hosts ejected due to high failure percentages.'),
        panels.timeSeries.rate('Enforced Failure Percentage Ejections', outlier_detection_queries.envoy_cluster_outlier_detection_ejections_enforced_failure_percentage),
        panels.timeSeries.rate('Detected Failure Percentage Ejections', outlier_detection_queries.envoy_cluster_outlier_detection_ejections_detected_failure_percentage),
    ]),
    row.new('Local Origin Failure Percentage Ejections')
    + row.withCollapsed(false)
    + row.withPanels([
        panels.text.markdown('Local Origin Failure Percentage Ejections', 'Metrics for hosts ejected due to high local origin failure percentages.'),
        panels.timeSeries.rate('Enforced Local Origin Failure Percentage Ejections', outlier_detection_queries.envoy_cluster_outlier_detection_ejections_enforced_failure_percentage_local_origin),
        panels.timeSeries.rate('Detected Local Origin Failure Percentage Ejections', outlier_detection_queries.envoy_cluster_outlier_detection_ejections_detected_failure_percentage_local_origin),
    ]),
    row.new('Deprecated Metrics (Reference)')
    + row.withCollapsed(true)
    + row.withPanels([
        panels.text.markdown('Deprecated Metrics', 'These metrics are deprecated but included for reference.'),
        panels.timeSeries.rate('Total Ejections (Deprecated)', outlier_detection_queries.envoy_cluster_outlier_detection_ejections_total),
        panels.timeSeries.rate('Consecutive 5xx Ejections (Deprecated)', outlier_detection_queries.envoy_cluster_outlier_detection_ejections_consecutive_5xx),
    ]),
  ], panelWidth=8)
)
+ g.dashboard.withUid('')  // Empty UID for sharing
+ g.dashboard.time.withFrom('now-1h')
+ g.dashboard.time.withTo('now')
+ g.dashboard.timepicker.withRefreshIntervals([
  '5s',
  '10s', 
  '30s',
  '1m',
  '5m',
  '15m',
  '30m',
  '1h',
  '2h',
  '1d'
]);

// Simply add the required external sharing fields
baseDashboard + {
  // Required for grafana.com uploads
  '__inputs': [
    {
      name: 'DS_PROMETHEUS',
      label: 'Prometheus',
      description: 'Prometheus data source',
      type: 'datasource',
      pluginId: 'prometheus',
      pluginName: 'Prometheus'
    }
  ],
  '__elements': {},
  '__requires': [
    {
      type: 'grafana',
      id: 'grafana',
      name: 'Grafana',
      version: '11.4.0'
    },
    {
      type: 'datasource',
      id: 'prometheus', 
      name: 'Prometheus',
      version: '1.0.0'
    },
    {
      type: 'panel',
      id: 'stat',
      name: 'Stat',
      version: ''
    },
    {
      type: 'panel',
      id: 'timeseries',
      name: 'Time series', 
      version: ''
    },
    {
      type: 'panel',
      id: 'text',
      name: 'Text',
      version: ''
    }
  ],
  // Reset for sharing
  id: null,
  uid: '',
  version: 0
}
