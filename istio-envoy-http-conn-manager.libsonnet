local g = import 'lib/g.libsonnet';

local row = g.panel.row;

local panels = import 'lib/panels.libsonnet';
local variables = import 'lib/variables.libsonnet';
local queries = import 'lib/queries.libsonnet';
local server_stats_queries = import 'lib/server_stats_queries.libsonnet';
local http_conn_manager_queries = import 'lib/http_conn_manager_queries.libsonnet';

g.dashboard.new('Istio Envoy HTTP Connection Manager')
+ g.dashboard.withDescription(|||
  Dashboard showing Istio Envoy HTTP Connection Manager metrics
|||)
+ g.dashboard.graphTooltip.withSharedCrosshair()
+ g.dashboard.withVariables([
  variables.datasource,
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
      uid: '$datasource'
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
      uid: '$datasource'
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
    name: 'http_conn_manager_prefix',
    type: 'query',
    datasource: {
      type: 'prometheus',
      uid: '$datasource'
    },
    definition: 'label_values(envoy_http_downstream_cx_total{namespace="$Namespace",pod=~"$pod"},http_conn_manager_prefix)',
    query: 'label_values(envoy_http_downstream_cx_total{namespace="$Namespace",pod=~"$pod"},http_conn_manager_prefix)',
    hide: 0,
    options: [],
    regex: '',
    skipUrlSync: false,
    multi: true,
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
      uid: '$datasource'
    },
    definition: '0.9',
    query: '0.9',
    hide: 2,
    options: [],
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
    row.new('HTTP Response Codes')
    + row.withCollapsed(false)
    + row.withPanels([
        panels.timeSeries.rate('HTTP Responses by Code Class', http_conn_manager_queries.envoy_http_downstream_rq_by_code),
        panels.timeSeries.rate('HTTP Responses by Individual Code', http_conn_manager_queries.envoy_http_downstream_rq_by_response_code),
        panels.timeSeries.rate('5xx Errors by Response Code', http_conn_manager_queries.envoy_http_downstream_rq_5xx_response_code),
    ]),
    row.new('HTTP Connection Manager')
    + row.withCollapsed(false)
    + row.withPanels([
        panels.text.markdown('HTTP Connection Manager Info', 'This section shows metrics related to HTTP connection management, including connection statistics, request metrics, and performance data.'),
        // Connection Overview
        panels.timeSeries.rate('HTTP Connection Statistics', http_conn_manager_queries.envoy_http_downstream_cx_total),
        panels.timeSeries.short('Active HTTP Connections', http_conn_manager_queries.envoy_http_downstream_cx_active),
        // Request Overview
        panels.timeSeries.rate('HTTP Request Statistics', http_conn_manager_queries.envoy_http_downstream_rq_total),
        panels.timeSeries.short('Active HTTP Requests', http_conn_manager_queries.envoy_http_downstream_rq_active),
        // Performance Metrics
        panels.timeSeries.durationQuantileMs('HTTP Request Timing (p90)', http_conn_manager_queries.envoy_http_downstream_rq_time),
        panels.timeSeries.durationQuantileMs('HTTP Connection Duration (p90)', http_conn_manager_queries.envoy_http_downstream_cx_length_ms),
        // Error and Traffic
        panels.timeSeries.rate('HTTP Protocol Errors', http_conn_manager_queries.envoy_http_downstream_cx_protocol_error),
        panels.timeSeries.rate('HTTP Request Reset Received', http_conn_manager_queries.envoy_http_downstream_rq_rx_reset),
        panels.timeSeries.rate('HTTP Request Reset Sent', http_conn_manager_queries.envoy_http_downstream_rq_tx_reset),
        panels.timeSeries.bytes('HTTP Received Bytes', http_conn_manager_queries.envoy_http_downstream_cx_rx_bytes_total),
        panels.timeSeries.bytes('HTTP Transmitted Bytes', http_conn_manager_queries.envoy_http_downstream_cx_tx_bytes_total),
        panels.timeSeries.bytes('HTTP Buffered Received Bytes', http_conn_manager_queries.envoy_http_downstream_cx_rx_bytes_buffered),
        panels.timeSeries.bytes('HTTP Buffered Transmitted Bytes', http_conn_manager_queries.envoy_http_downstream_cx_tx_bytes_buffered),
    ]),
  ], panelWidth=8)
)
+ g.dashboard.withUid(std.md5('Istio Envoy HTTP Connection Manager'))
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
]) 