local g = import 'lib/g.libsonnet';

local row = g.panel.row;

local panels = import 'lib/panels.libsonnet';
local variables = import 'lib/variables.libsonnet';
local queries = import 'lib/queries.libsonnet';
local server_stats_queries = import 'lib/server_stats_queries.libsonnet';
local envoy_cluster_upstream_queries = import 'lib/envoy_cluster_upstream_queries.libsonnet';
local listener_stats_queries = import 'lib/listener_stats_queries.libsonnet';
local listener_manager_queries = import 'lib/listener_manager_queries.libsonnet';
local lds_stats_queries = import 'lib/lds_stats_queries.libsonnet';

// Create base dashboard first
local baseDashboard = g.dashboard.new('Istio Envoy Listeners')
+ g.dashboard.withDescription(|||
  Dashboard showing Istio Envoy Listeners
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
    includeAll: true,
    refresh: 2,
    sort: 1,
    options: [],
    allValue: '$app.*',
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
    row.new('Server Stats')
    + row.withCollapsed(false)    
    + row.withPanels([
        panels.stat.uptime('Uptime', server_stats_queries.envoy_server_uptime),
        panels.stat.serverLive('Server Live', server_stats_queries.envoy_server_live),
        panels.timeSeries.short('Worker Threads', server_stats_queries.envoy_server_concurrency),
        panels.timeSeries.memoryUsage('Memory Allocated', server_stats_queries.envoy_server_memory_allocated),
        panels.timeSeries.memoryUsage('Memory Heap Size', server_stats_queries.envoy_server_memory_heap_size),
        panels.timeSeries.memoryUsage('Memory Physical Size', server_stats_queries.envoy_server_memory_physical_size),
        panels.timeSeries.short('Total Connections', server_stats_queries.envoy_server_total_connections),
    ]),    
    row.new('Listener Manager')
    + row.withCollapsed(true)
    + row.withPanels([
        panels.timeSeries.short('Number of currently active listeners.', listener_manager_queries.envoy_listener_manager_total_listeners_active),
        panels.timeSeries.short('Number of currently draining listeners.', listener_manager_queries.envoy_listener_manager_total_listeners_draining),
        panels.timeSeries.short('Number of currently warming listeners.', listener_manager_queries.envoy_listener_manager_total_listeners_warming),
        panels.timeSeries.short('Number of currently draining filter chains.', listener_manager_queries.envoy_listener_manager_total_filter_chains_draining),
        panels.timeSeries.short('Workers started', listener_manager_queries.envoy_listener_manager_workers_started),
        panels.timeSeries.rate('Total listeners added (either via static config or LDS).', listener_manager_queries.envoy_listener_manager_listener_added),
        panels.timeSeries.rate('Total failed listener object additions to workers.', listener_manager_queries.envoy_listener_manager_listener_create_failure),
        panels.timeSeries.rate('Total listener objects successfully added to workers.', listener_manager_queries.envoy_listener_manager_listener_create_success),
        panels.timeSeries.rate('Total listener objects created to execute filter chain update path.', listener_manager_queries.envoy_listener_manager_listener_in_place_updated),
        panels.timeSeries.rate('Total listeners modified (via LDS).', listener_manager_queries.envoy_listener_manager_listener_modified),
        panels.timeSeries.rate('Total listeners removed (via LDS).', listener_manager_queries.envoy_listener_manager_listener_removed),
        panels.timeSeries.rate('Total listeners stopped.', listener_manager_queries.envoy_listener_manager_listener_stopped),
    ]),
    row.new('Listener Discover Server Stats')
    + row.withCollapsed(true)
    + row.withPanels([
        panels.text.markdown('LDS Stats Info', 'This section shows metrics related to the Listener Discovery Service (LDS) and Control Plane connection state. LDS allows Envoy to dynamically discover and update listener configurations at runtime. The metrics below track API fetch attempts, successes, failures, and configuration changes, providing visibility into the health and activity of the LDS subsystem and its connection to the management server.'),
        panels.timeSeries.rate('Total API fetches attempted', lds_stats_queries.envoy_listener_manager_lds_update_attempt),
        panels.timeSeries.rate('Total API fetches completed successfully', lds_stats_queries.envoy_listener_manager_lds_update_success),
        panels.timeSeries.rate('Total API fetches that failed because of network errors', lds_stats_queries.envoy_listener_manager_lds_update_failure),
        panels.timeSeries.rate('Total API fetches that failed because of schema/validation errors', lds_stats_queries.envoy_listener_manager_lds_update_rejected),
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