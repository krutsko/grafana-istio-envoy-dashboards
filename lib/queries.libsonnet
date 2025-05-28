local g = import './g.libsonnet';
local prometheusQuery = g.query.prometheus;

local variables = import './variables.libsonnet';

{
  envoy_listener_downstream_cx_active:
    prometheusQuery.new(
      '$' + variables.datasource.name,
      |||
        sum by(pod) (envoy_listener_downstream_cx_active{namespace=~"$Namespace",pod=~"$pod"})
      |||
    )
    + prometheusQuery.withIntervalFactor(2)
    + prometheusQuery.withLegendFormat(|||
      {{pod}}
    |||),      

  envoy_cluster_upstream_cx_active:
    prometheusQuery.new(
      '$' + variables.datasource.name,
      |||
        sum by (pod, $clusterNameLabel) (
            envoy_cluster_upstream_cx_active{
                namespace=~"$Namespace",pod=~"$pod", $clusterNameLabel="$cluster"
            }
        )
      |||                    
    )
    + prometheusQuery.withIntervalFactor(2)
    + prometheusQuery.withLegendFormat(|||
      {{pod}} {{$clusterNameLabel}}
    |||),

  envoy_listener_manager_listener_added:
    prometheusQuery.new(
      '$' + variables.datasource.name,
      |||
        sum by (pod) (
            rate(
                envoy_listener_manager_listener_added{
                    namespace=~"$Namespace",pod=~"$pod"
                }
            [$__rate_interval])
        )
      |||                    
    )
    + prometheusQuery.withIntervalFactor(2)
    + prometheusQuery.withLegendFormat(|||
      {{pod}}
    |||),         

  envoy_listener_manager_listener_create_failure:
    prometheusQuery.new(
      '$' + variables.datasource.name,
      |||
        sum by (pod) (
            rate(
                envoy_listener_manager_listener_create_failure{
                    namespace=~"$Namespace",pod=~"$pod"
                }
            [$__rate_interval])
        )
      |||                    
    )
    + prometheusQuery.withIntervalFactor(2)
    + prometheusQuery.withLegendFormat(|||
      {{pod}}
    |||),       

  envoy_listener_manager_listener_create_success:
    prometheusQuery.new(
      '$' + variables.datasource.name,
      |||
        sum by (pod) (
            rate(
                envoy_listener_manager_listener_create_success{
                    namespace=~"$Namespace",pod=~"$pod"
                }
            [$__rate_interval])
        )
      |||                    
    )
    + prometheusQuery.withIntervalFactor(2)
    + prometheusQuery.withLegendFormat(|||
      {{pod}}
    |||),      

  envoy_listener_manager_listener_in_place_updated:
    prometheusQuery.new(
      '$' + variables.datasource.name,
      |||
        sum by (pod) (
            rate(
                envoy_listener_manager_listener_in_place_updated{
                    namespace=~"$Namespace",pod=~"$pod"
                }
            [$__rate_interval])
        )
      |||                    
    )
    + prometheusQuery.withIntervalFactor(2)
    + prometheusQuery.withLegendFormat(|||
      {{pod}}
    |||),     

  envoy_listener_manager_listener_modified:
    prometheusQuery.new(
      '$' + variables.datasource.name,
      |||
        sum by (pod) (
            rate(
                envoy_listener_manager_listener_modified{
                    namespace=~"$Namespace",pod=~"$pod"
                }
            [$__rate_interval])
        )
      |||                    
    )
    + prometheusQuery.withIntervalFactor(2)
    + prometheusQuery.withLegendFormat(|||
      {{pod}}
    |||),          

  envoy_listener_manager_listener_removed:
    prometheusQuery.new(
      '$' + variables.datasource.name,
      |||
        sum by (pod) (
            rate(
                envoy_listener_manager_listener_removed{
                    namespace=~"$Namespace",pod=~"$pod"
                }
            [$__rate_interval])
        )
      |||                    
    )
    + prometheusQuery.withIntervalFactor(2)
    + prometheusQuery.withLegendFormat(|||
      {{pod}}
    |||),    

  envoy_listener_manager_listener_stopped:
    prometheusQuery.new(
      '$' + variables.datasource.name,
      |||
        sum by (pod) (
            rate(
                envoy_listener_manager_listener_stopped{
                    namespace=~"$Namespace",pod=~"$pod"
                }
            [$__rate_interval])
        )
      |||                    
    )
    + prometheusQuery.withIntervalFactor(2)
    + prometheusQuery.withLegendFormat(|||
      {{pod}}
    |||),      

  envoy_listener_manager_total_listeners_active:
    prometheusQuery.new(
      '$' + variables.datasource.name,
      |||
        sum by(pod) (envoy_listener_manager_total_listeners_active{namespace=~"$Namespace",pod=~"$pod"})       
      |||                    
    )
    + prometheusQuery.withIntervalFactor(2)
    + prometheusQuery.withLegendFormat(|||
      {{pod}}
    |||),    

  envoy_listener_manager_total_listeners_draining:
    prometheusQuery.new(
      '$' + variables.datasource.name,
      |||
        sum by(pod) (envoy_listener_manager_total_listeners_draining{namespace=~"$Namespace",pod=~"$pod"})       
      |||                    
    )
    + prometheusQuery.withIntervalFactor(2)
    + prometheusQuery.withLegendFormat(|||
      {{pod}}
    |||),         

  envoy_listener_manager_total_listeners_warming:
    prometheusQuery.new(
      '$' + variables.datasource.name,
      |||
        sum by(pod) (envoy_listener_manager_total_listeners_warming{namespace=~"$Namespace",pod=~"$pod"})       
      |||                    
    )
    + prometheusQuery.withIntervalFactor(2)
    + prometheusQuery.withLegendFormat(|||
      {{pod}}
    |||),  

  envoy_cluster_manager_cluster_added:
    prometheusQuery.new(
      '$' + variables.datasource.name,
      |||
        sum by (pod) (
            rate(
                envoy_cluster_manager_cluster_added{
                    namespace=~"$Namespace",pod=~"$pod"
                }
            [$__rate_interval])
        )
      |||                    
    )
    + prometheusQuery.withIntervalFactor(2)
    + prometheusQuery.withLegendFormat(|||
      {{pod}}
    |||),
    
  envoy_cluster_manager_cluster_modified:
    prometheusQuery.new(
      '$' + variables.datasource.name,
      |||
        sum by (pod) (
            rate(
                envoy_cluster_manager_cluster_modified{
                    namespace=~"$Namespace",pod=~"$pod"
                }
            [$__rate_interval])
        )
      |||                    
    )
    + prometheusQuery.withIntervalFactor(2)
    + prometheusQuery.withLegendFormat(|||
      {{pod}}
    |||),
    
  envoy_cluster_manager_cluster_removed:
    prometheusQuery.new(
      '$' + variables.datasource.name,
      |||
        sum by (pod) (
            rate(
                envoy_cluster_manager_cluster_removed{
                    namespace=~"$Namespace",pod=~"$pod"
                }
            [$__rate_interval])
        )
      |||                    
    )
    + prometheusQuery.withIntervalFactor(2)
    + prometheusQuery.withLegendFormat(|||
      {{pod}}
    |||),
    
  envoy_cluster_manager_cluster_updated:
    prometheusQuery.new(
      '$' + variables.datasource.name,
      |||
        sum by (pod) (
            rate(
                envoy_cluster_manager_cluster_updated{
                    namespace=~"$Namespace",pod=~"$pod"
                }
            [$__rate_interval])
        )
      |||                    
    )
    + prometheusQuery.withIntervalFactor(2)
    + prometheusQuery.withLegendFormat(|||
      {{pod}}
    |||),
    
  envoy_cluster_manager_cluster_updated_via_merge:
    prometheusQuery.new(
      '$' + variables.datasource.name,
      |||
        sum by (pod) (
            rate(
                envoy_cluster_manager_cluster_updated_via_merge{
                    namespace=~"$Namespace",pod=~"$pod"
                }
            [$__rate_interval])
        )
      |||                    
    )
    + prometheusQuery.withIntervalFactor(2)
    + prometheusQuery.withLegendFormat(|||
      {{pod}}
    |||),
    
  envoy_cluster_manager_update_merge_cancelled:
    prometheusQuery.new(
      '$' + variables.datasource.name,
      |||
        sum by (pod) (
            rate(
                envoy_cluster_manager_update_merge_cancelled{
                    namespace=~"$Namespace",pod=~"$pod"
                }
            [$__rate_interval])
        )
      |||                    
    )
    + prometheusQuery.withIntervalFactor(2)
    + prometheusQuery.withLegendFormat(|||
      {{pod}}
    |||),
    
  envoy_cluster_manager_update_out_of_merge_window:
    prometheusQuery.new(
      '$' + variables.datasource.name,
      |||
        sum by (pod) (
            rate(
                envoy_cluster_manager_update_out_of_merge_window{
                    namespace=~"$Namespace",pod=~"$pod"
                }
            [$__rate_interval])
        )
      |||                    
    )
    + prometheusQuery.withIntervalFactor(2)
    + prometheusQuery.withLegendFormat(|||
      {{pod}}
    |||),

  envoy_cluster_manager_active_clusters:
    prometheusQuery.new(
      '$' + variables.datasource.name,
      |||
        sum by (pod, $clusterNameLabel) (
            envoy_cluster_manager_active_clusters{
                namespace=~"$Namespace",pod=~"$pod"
            }
        )
      |||                    
    )
    + prometheusQuery.withIntervalFactor(2)
    + prometheusQuery.withLegendFormat(|||
      {{pod}} {{$clusterNameLabel}}
    |||),

  envoy_cluster_manager_warming_clusters:
    prometheusQuery.new(
      '$' + variables.datasource.name,
      |||
        sum by (pod) (
            envoy_cluster_manager_warming_clusters{
                namespace=~"$Namespace",pod=~"$pod"
            }
        )
      |||                    
    )
    + prometheusQuery.withIntervalFactor(2)
    + prometheusQuery.withLegendFormat(|||
      {{pod}}
    |||),

  // New cluster statistics queries
  envoy_cluster_upstream_cx_total:
    prometheusQuery.new(
      '$' + variables.datasource.name,
      |||
        sum by (pod, $clusterNameLabel) (
            rate(
                envoy_cluster_upstream_cx_total{
                    namespace=~"$Namespace",pod=~"$pod", $clusterNameLabel="$cluster"
                }
            [$__rate_interval])
        )
      |||                    
    )
    + prometheusQuery.withIntervalFactor(2)
    + prometheusQuery.withLegendFormat(|||
      {{pod}} {{$clusterNameLabel}}
    |||),

  envoy_cluster_upstream_cx_connect_fail:
    prometheusQuery.new(
      '$' + variables.datasource.name,
      |||
        sum by (pod, $clusterNameLabel) (
            rate(
                envoy_cluster_upstream_cx_connect_fail{
                    namespace=~"$Namespace",pod=~"$pod", $clusterNameLabel="$cluster"
                }
            [$__rate_interval])
        )
      |||                    
    )
    + prometheusQuery.withIntervalFactor(2)
    + prometheusQuery.withLegendFormat(|||
      {{pod}} {{$clusterNameLabel}}
    |||),

  envoy_cluster_upstream_cx_connect_timeout:
    prometheusQuery.new(
      '$' + variables.datasource.name,
      |||
        sum by (pod, $clusterNameLabel) (
            rate(
                envoy_cluster_upstream_cx_connect_timeout{
                    namespace=~"$Namespace",pod=~"$pod", $clusterNameLabel="$cluster"
                }
            [$__rate_interval])
        )
      |||                    
    )
    + prometheusQuery.withIntervalFactor(2)
    + prometheusQuery.withLegendFormat(|||
      {{pod}} {{$clusterNameLabel}}
    |||),

  envoy_cluster_upstream_cx_destroy:
    prometheusQuery.new(
      '$' + variables.datasource.name,
      |||
        sum by (pod, $clusterNameLabel) (
            rate(
                envoy_cluster_upstream_cx_destroy{
                    namespace=~"$Namespace",pod=~"$pod", $clusterNameLabel="$cluster"
                }
            [$__rate_interval])
        )
      |||                    
    )
    + prometheusQuery.withIntervalFactor(2)
    + prometheusQuery.withLegendFormat(|||
      {{pod}} {{$clusterNameLabel}}
    |||),

  envoy_cluster_upstream_cx_destroy_local:
    prometheusQuery.new(
      '$' + variables.datasource.name,
      |||
        sum by (pod, $clusterNameLabel) (
            rate(
                envoy_cluster_upstream_cx_destroy_local{
                    namespace=~"$Namespace",pod=~"$pod", $clusterNameLabel="$cluster"
                }
            [$__rate_interval])
        )
      |||                    
    )
    + prometheusQuery.withIntervalFactor(2)
    + prometheusQuery.withLegendFormat(|||
      {{pod}} {{$clusterNameLabel}}
    |||),

  envoy_cluster_upstream_cx_destroy_remote:
    prometheusQuery.new(
      '$' + variables.datasource.name,
      |||
        sum by (pod, $clusterNameLabel) (
            rate(
                envoy_cluster_upstream_cx_destroy_remote{
                    namespace=~"$Namespace",pod=~"$pod", $clusterNameLabel="$cluster"
                }
            [$__rate_interval])
        )
      |||                    
    )
    + prometheusQuery.withIntervalFactor(2)
    + prometheusQuery.withLegendFormat(|||
      {{pod}} {{$clusterNameLabel}}
    |||),

  envoy_cluster_upstream_cx_destroy_with_active_rq:
    prometheusQuery.new(
      '$' + variables.datasource.name,
      |||
        sum by (pod, $clusterNameLabel) (
            rate(
                envoy_cluster_upstream_cx_destroy_with_active_rq{
                    namespace=~"$Namespace",pod=~"$pod", $clusterNameLabel="$cluster"
                }
            [$__rate_interval])
        )
      |||                    
    )
    + prometheusQuery.withIntervalFactor(2)
    + prometheusQuery.withLegendFormat(|||
      {{pod}} {{$clusterNameLabel}}
    |||),

  envoy_cluster_upstream_cx_destroy_local_with_active_rq:
    prometheusQuery.new(
      '$' + variables.datasource.name,
      |||
        sum by (pod, $clusterNameLabel) (
            rate(
                envoy_cluster_upstream_cx_destroy_local_with_active_rq{
                    namespace=~"$Namespace",pod=~"$pod", $clusterNameLabel="$cluster"
                }
            [$__rate_interval])
        )
      |||                    
    )
    + prometheusQuery.withIntervalFactor(2)
    + prometheusQuery.withLegendFormat(|||
      {{pod}} {{$clusterNameLabel}}
    |||),

  envoy_cluster_upstream_cx_destroy_remote_with_active_rq:
    prometheusQuery.new(
      '$' + variables.datasource.name,
      |||
        sum by (pod, $clusterNameLabel) (
            rate(
                envoy_cluster_upstream_cx_destroy_remote_with_active_rq{
                    namespace=~"$Namespace",pod=~"$pod", $clusterNameLabel="$cluster"
                }
            [$__rate_interval])
        )
      |||                    
    )
    + prometheusQuery.withIntervalFactor(2)
    + prometheusQuery.withLegendFormat(|||
      {{pod}} {{$clusterNameLabel}}
    |||),

  envoy_cluster_upstream_cx_overflow:
    prometheusQuery.new(
      '$' + variables.datasource.name,
      |||
        sum by (pod, $clusterNameLabel) (
            rate(
                envoy_cluster_upstream_cx_overflow{
                    namespace=~"$Namespace",pod=~"$pod", $clusterNameLabel="$cluster"
                }
            [$__rate_interval])
        )
      |||                    
    )
    + prometheusQuery.withIntervalFactor(2)
    + prometheusQuery.withLegendFormat(|||
      {{pod}} {{$clusterNameLabel}}
    |||),

  envoy_cluster_upstream_cx_protocol_error:
    prometheusQuery.new(
      '$' + variables.datasource.name,
      |||
        sum by (pod, $clusterNameLabel) (
            rate(
                envoy_cluster_upstream_cx_protocol_error{
                    namespace=~"$Namespace",pod=~"$pod", $clusterNameLabel="$cluster"
                }
            [$__rate_interval])
        )
      |||                    
    )
    + prometheusQuery.withIntervalFactor(2)
    + prometheusQuery.withLegendFormat(|||
      {{pod}} {{$clusterNameLabel}}
    |||),

  envoy_cluster_upstream_cx_max_requests:
    prometheusQuery.new(
      '$' + variables.datasource.name,
      |||
        sum by (pod, $clusterNameLabel) (
            rate(
                envoy_cluster_upstream_cx_max_requests{
                    namespace=~"$Namespace",pod=~"$pod", $clusterNameLabel="$cluster"
                }
            [$__rate_interval])
        )
      |||                    
    )
    + prometheusQuery.withIntervalFactor(2)
    + prometheusQuery.withLegendFormat(|||
      {{pod}} {{$clusterNameLabel}}
    |||),

  envoy_cluster_upstream_cx_none_healthy:
    prometheusQuery.new(
      '$' + variables.datasource.name,
      |||
        sum by (pod, $clusterNameLabel) (
            rate(
                envoy_cluster_upstream_cx_none_healthy{
                    namespace=~"$Namespace",pod=~"$pod", $clusterNameLabel="$cluster"
                }
            [$__rate_interval])
        )
      |||                    
    )
    + prometheusQuery.withIntervalFactor(2)
    + prometheusQuery.withLegendFormat(|||
      {{pod}} {{$clusterNameLabel}}
    |||),

  envoy_cluster_upstream_cx_rx_bytes_total:
    prometheusQuery.new(
      '$' + variables.datasource.name,
      |||
        sum by (pod, $clusterNameLabel) (
            rate(
                envoy_cluster_upstream_cx_rx_bytes_total{
                    namespace=~"$Namespace",pod=~"$pod", $clusterNameLabel="$cluster"
                }
            [$__rate_interval])
        )
      |||                    
    )
    + prometheusQuery.withIntervalFactor(2)
    + prometheusQuery.withLegendFormat(|||
      {{pod}} {{$clusterNameLabel}}
    |||),

  envoy_cluster_upstream_cx_tx_bytes_total:
    prometheusQuery.new(
      '$' + variables.datasource.name,
      |||
        sum by (pod, $clusterNameLabel) (
            rate(
                envoy_cluster_upstream_cx_tx_bytes_total{
                    namespace=~"$Namespace",pod=~"$pod", $clusterNameLabel="$cluster"
                }
            [$__rate_interval])
        )
      |||                    
    )
    + prometheusQuery.withIntervalFactor(2)
    + prometheusQuery.withLegendFormat(|||
      {{pod}} {{$clusterNameLabel}}
    |||),

  envoy_cluster_upstream_cx_pool_overflow:
    prometheusQuery.new(
      '$' + variables.datasource.name,
      |||
        sum by (pod, $clusterNameLabel) (
            rate(
                envoy_cluster_upstream_cx_pool_overflow{
                    namespace=~"$Namespace",pod=~"$pod", $clusterNameLabel="$cluster"
                }
            [$__rate_interval])
        )
      |||                    
    )
    + prometheusQuery.withIntervalFactor(2)
    + prometheusQuery.withLegendFormat(|||
      {{pod}} {{$clusterNameLabel}}
    |||),

  envoy_cluster_upstream_cx_connect_ms:
    prometheusQuery.new(
      '$' + variables.datasource.name,
      |||
        histogram_quantile(
          0.9,
          sum by (pod, $clusterNameLabel, le) (
            rate(
              envoy_cluster_upstream_cx_connect_ms_bucket{
                namespace=~"$Namespace",pod=~"$pod", $clusterNameLabel="$cluster"
              }
            [$__rate_interval])
          )
        )
      |||                    
    )
    + prometheusQuery.withIntervalFactor(2)
    + prometheusQuery.withLegendFormat(|||
      {{pod}} {{$clusterNameLabel}} 
    |||),

  envoy_cluster_upstream_cx_length_ms:
    prometheusQuery.new(
      '$' + variables.datasource.name,
      |||
        histogram_quantile(
          0.9,
          sum by (pod, $clusterNameLabel, le) (
            rate(
              envoy_cluster_upstream_cx_length_ms_bucket{
                namespace=~"$Namespace",pod=~"$pod", $clusterNameLabel="$cluster"
              }
            [$__rate_interval])
          )
        )
      |||                    
    )
    + prometheusQuery.withIntervalFactor(2)
    + prometheusQuery.withLegendFormat(|||
      {{pod}} {{$clusterNameLabel}} 
    |||),

  envoy_cluster_upstream_cx_http1_total:
    prometheusQuery.new(
      '$' + variables.datasource.name,
      |||
        sum by (pod, $clusterNameLabel) (
            rate(
                envoy_cluster_upstream_cx_http1_total{
                    namespace=~"$Namespace",pod=~"$pod", $clusterNameLabel="$cluster"
                }
            [$__rate_interval])
        )
      |||                    
    )
    + prometheusQuery.withIntervalFactor(2)
    + prometheusQuery.withLegendFormat(|||
      {{pod}} {{$clusterNameLabel}}
    |||),

  envoy_cluster_upstream_cx_http2_total:
    prometheusQuery.new(
      '$' + variables.datasource.name,
      |||
        sum by (pod, $clusterNameLabel) (
            rate(
                envoy_cluster_upstream_cx_http2_total{
                    namespace=~"$Namespace",pod=~"$pod", $clusterNameLabel="$cluster"
                }
            [$__rate_interval])
        )
      |||                    
    )
    + prometheusQuery.withIntervalFactor(2)
    + prometheusQuery.withLegendFormat(|||
      {{pod}} {{$clusterNameLabel}}
    |||),

  envoy_cluster_upstream_cx_http3_total:
    prometheusQuery.new(
      '$' + variables.datasource.name,
      |||
        sum by (pod, $clusterNameLabel) (
            rate(
                envoy_cluster_upstream_cx_http3_total{
                    namespace=~"$Namespace",pod=~"$pod", $clusterNameLabel="$cluster"
                }
            [$__rate_interval])
        )
      |||                    
    )
    + prometheusQuery.withIntervalFactor(2)
    + prometheusQuery.withLegendFormat(|||
      {{pod}} {{$clusterNameLabel}}
    |||),

  envoy_cluster_upstream_cx_connect_with_0_rtt:
    prometheusQuery.new(
      '$' + variables.datasource.name,
      |||
        sum by (pod, $clusterNameLabel) (
            rate(
                envoy_cluster_upstream_cx_connect_with_0_rtt{
                    namespace=~"$Namespace",pod=~"$pod", $clusterNameLabel="$cluster"
                }
            [$__rate_interval])
        )
      |||                    
    )
    + prometheusQuery.withIntervalFactor(2)
    + prometheusQuery.withLegendFormat(|||
      {{pod}} {{$clusterNameLabel}}
    |||),

  envoy_cluster_upstream_cx_idle_timeout:
    prometheusQuery.new(
      '$' + variables.datasource.name,
      |||
        sum by (pod, $clusterNameLabel) (
            rate(
                envoy_cluster_upstream_cx_idle_timeout{
                    namespace=~"$Namespace",pod=~"$pod", $clusterNameLabel="$cluster"
                }
            [$__rate_interval])
        )
      |||                    
    )
    + prometheusQuery.withIntervalFactor(2)
    + prometheusQuery.withLegendFormat(|||
      {{pod}} {{$clusterNameLabel}}
    |||),

  envoy_cluster_upstream_cx_connect_attempts_exceeded:
    prometheusQuery.new(
      '$' + variables.datasource.name,
      |||
        sum by (pod, $clusterNameLabel) (
            rate(
                envoy_cluster_upstream_cx_connect_attempts_exceeded{
                    namespace=~"$Namespace",pod=~"$pod", $clusterNameLabel="$cluster"
                }
            [$__rate_interval])
        )
      |||                    
    )
    + prometheusQuery.withIntervalFactor(2)
    + prometheusQuery.withLegendFormat(|||
      {{pod}} {{$clusterNameLabel}}
    |||),

  envoy_cluster_upstream_cx_close_notify:
    prometheusQuery.new(
      '$' + variables.datasource.name,
      |||
        sum by (pod, $clusterNameLabel) (
            rate(
                envoy_cluster_upstream_cx_close_notify{
                    namespace=~"$Namespace",pod=~"$pod", $clusterNameLabel="$cluster"
                }
            [$__rate_interval])
        )
      |||                    
    )
    + prometheusQuery.withIntervalFactor(2)
    + prometheusQuery.withLegendFormat(|||
      {{pod}} {{$clusterNameLabel}}
    |||),

  envoy_cluster_upstream_cx_rx_bytes_buffered:
    prometheusQuery.new(
      '$' + variables.datasource.name,
      |||
        sum by (pod, $clusterNameLabel) (
            envoy_cluster_upstream_cx_rx_bytes_buffered{
                namespace=~"$Namespace",pod=~"$pod", $clusterNameLabel="$cluster"
            }
        )
      |||                    
    )
    + prometheusQuery.withIntervalFactor(2)
    + prometheusQuery.withLegendFormat(|||
      {{pod}} {{$clusterNameLabel}}
    |||),

  envoy_cluster_upstream_cx_tx_bytes_buffered:
    prometheusQuery.new(
      '$' + variables.datasource.name,
      |||
        sum by (pod, $clusterNameLabel) (
            envoy_cluster_upstream_cx_tx_bytes_buffered{
                namespace=~"$Namespace",pod=~"$pod", $clusterNameLabel="$cluster"
            }
        )
      |||                    
    )
    + prometheusQuery.withIntervalFactor(2)
    + prometheusQuery.withLegendFormat(|||
      {{pod}} {{$clusterNameLabel}}
    |||),

  envoy_cluster_upstream_cx_max_duration_reached:
    prometheusQuery.new(
      '$' + variables.datasource.name,
      |||
        sum by (pod, $clusterNameLabel) (
            rate(
                envoy_cluster_upstream_cx_max_duration_reached{
                    namespace=~"$Namespace",pod=~"$pod", $clusterNameLabel="$cluster"
                }
            [$__rate_interval])
        )
      |||                    
    )
    + prometheusQuery.withIntervalFactor(2)
    + prometheusQuery.withLegendFormat(|||
      {{pod}} {{$clusterNameLabel}}
    |||),

}

// vim: foldmethod=indent shiftwidth=2 foldlevel=1
