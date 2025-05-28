local g = import './g.libsonnet';
local prometheusQuery = g.query.prometheus;

local variables = import './variables.libsonnet';

{
  envoy_listener_downstream_cx_total:
    prometheusQuery.new(
      '$' + variables.datasource.name,
      |||
        sum by(pod, listener_address) (
            rate(
                envoy_listener_downstream_cx_total{
                    namespace=~"$Namespace",pod=~"$pod"
                }
            [$__rate_interval])
        )
      |||
    )
    + prometheusQuery.withIntervalFactor(2)
    + prometheusQuery.withLegendFormat(|||
      {{pod}} {{listener_address}}
    |||),

  envoy_listener_downstream_cx_destroy:
    prometheusQuery.new(
      '$' + variables.datasource.name,
      |||
        sum by(pod, listener_address) (
            rate(
                envoy_listener_downstream_cx_destroy{
                    namespace=~"$Namespace",pod=~"$pod"
                }
            [$__rate_interval])
        )
      |||
    )
    + prometheusQuery.withIntervalFactor(2)
    + prometheusQuery.withLegendFormat(|||
      {{pod}} {{listener_address}}
    |||),

  envoy_listener_downstream_cx_active:
    prometheusQuery.new(
      '$' + variables.datasource.name,
      |||
        sum by(pod, listener_address) (envoy_listener_downstream_cx_active{namespace=~"$Namespace",pod=~"$pod"})
      |||
    )
    + prometheusQuery.withIntervalFactor(2)
    + prometheusQuery.withLegendFormat(|||
      {{pod}} {{listener_address}}
    |||),

  envoy_listener_downstream_cx_length_ms:
    prometheusQuery.new(
      '$' + variables.datasource.name,
      |||
        histogram_quantile(
          $quantiles,
          sum by (pod, listener_address, le) (
            rate(
              envoy_listener_downstream_cx_length_ms_bucket{
                namespace=~"$Namespace",pod=~"$pod"
              }
            [$__rate_interval])
          )
        )
      |||
    )
    + prometheusQuery.withIntervalFactor(2)
    + prometheusQuery.withLegendFormat(|||
      {{pod}} {{listener_address}}
    |||),

  envoy_listener_downstream_cx_transport_socket_connect_timeout:
    prometheusQuery.new(
      '$' + variables.datasource.name,
      |||
        sum by(pod, listener_address) (
            rate(
                envoy_listener_downstream_cx_transport_socket_connect_timeout{
                    namespace=~"$Namespace",pod=~"$pod"
                }
            [$__rate_interval])
        )
      |||
    )
    + prometheusQuery.withIntervalFactor(2)
    + prometheusQuery.withLegendFormat(|||
      {{pod}} {{listener_address}}
    |||),

  envoy_listener_downstream_cx_overflow:
    prometheusQuery.new(
      '$' + variables.datasource.name,
      |||
        sum by(pod, listener_address) (
            rate(
                envoy_listener_downstream_cx_overflow{
                    namespace=~"$Namespace",pod=~"$pod"
                }
            [$__rate_interval])
        )
      |||
    )
    + prometheusQuery.withIntervalFactor(2)
    + prometheusQuery.withLegendFormat(|||
      {{pod}} {{listener_address}}
    |||),

  envoy_listener_downstream_cx_overload_reject:
    prometheusQuery.new(
      '$' + variables.datasource.name,
      |||
        sum by(pod, listener_address) (
            rate(
                envoy_listener_downstream_cx_overload_reject{
                    namespace=~"$Namespace",pod=~"$pod"
                }
            [$__rate_interval])
        )
      |||
    )
    + prometheusQuery.withIntervalFactor(2)
    + prometheusQuery.withLegendFormat(|||
      {{pod}} {{listener_address}}
    |||),

  envoy_listener_downstream_global_cx_overflow:
    prometheusQuery.new(
      '$' + variables.datasource.name,
      |||
        sum by(pod, listener_address) (
            rate(
                envoy_listener_downstream_global_cx_overflow{
                    namespace=~"$Namespace",pod=~"$pod"
                }
            [$__rate_interval])
        )
      |||
    )
    + prometheusQuery.withIntervalFactor(2)
    + prometheusQuery.withLegendFormat(|||
      {{pod}} {{listener_address}}
    |||),

  envoy_listener_connections_accepted_per_socket_event:
    prometheusQuery.new(
      '$' + variables.datasource.name,
      |||
        histogram_quantile(
          $quantiles,
          sum by (pod, listener_address, le) (
            rate(
              envoy_listener_connections_accepted_per_socket_event_bucket{
                namespace=~"$Namespace",pod=~"$pod"
              }
            [$__rate_interval])
          )
        )
      |||
    )
    + prometheusQuery.withIntervalFactor(2)
    + prometheusQuery.withLegendFormat(|||
      {{pod}} {{listener_address}}
    |||),

  envoy_listener_downstream_pre_cx_timeout:
    prometheusQuery.new(
      '$' + variables.datasource.name,
      |||
        sum by(pod, listener_address) (
            rate(
                envoy_listener_downstream_pre_cx_timeout{
                    namespace=~"$Namespace",pod=~"$pod"
                }
            [$__rate_interval])
        )
      |||
    )
    + prometheusQuery.withIntervalFactor(2)
    + prometheusQuery.withLegendFormat(|||
      {{pod}} {{listener_address}}
    |||),

  envoy_listener_downstream_pre_cx_active:
    prometheusQuery.new(
      '$' + variables.datasource.name,
      |||
        sum by(pod, listener_address) (envoy_listener_downstream_pre_cx_active{namespace=~"$Namespace",pod=~"$pod"})
      |||
    )
    + prometheusQuery.withIntervalFactor(2)
    + prometheusQuery.withLegendFormat(|||
      {{pod}} {{listener_address}}
    |||),

  envoy_listener_extension_config_missing:
    prometheusQuery.new(
      '$' + variables.datasource.name,
      |||
        sum by(pod, listener_address) (
            rate(
                envoy_listener_extension_config_missing{
                    namespace=~"$Namespace",pod=~"$pod"
                }
            [$__rate_interval])
        )
      |||
    )
    + prometheusQuery.withIntervalFactor(2)
    + prometheusQuery.withLegendFormat(|||
      {{pod}} {{listener_address}}
    |||),

  envoy_listener_network_extension_config_missing:
    prometheusQuery.new(
      '$' + variables.datasource.name,
      |||
        sum by(pod, listener_address) (
            rate(
                envoy_listener_network_extension_config_missing{
                    namespace=~"$Namespace",pod=~"$pod"
                }
            [$__rate_interval])
        )
      |||
    )
    + prometheusQuery.withIntervalFactor(2)
    + prometheusQuery.withLegendFormat(|||
      {{pod}} {{listener_address}}
    |||),

  envoy_listener_no_filter_chain_match:
    prometheusQuery.new(
      '$' + variables.datasource.name,
      |||
        sum by(pod, listener_address) (
            rate(
                envoy_listener_no_filter_chain_match{
                    namespace=~"$Namespace",pod=~"$pod"
                }
            [$__rate_interval])
        )
      |||
    )
    + prometheusQuery.withIntervalFactor(2)
    + prometheusQuery.withLegendFormat(|||
      {{pod}} {{listener_address}}
    |||),

  envoy_listener_downstream_listener_filter_remote_close:
    prometheusQuery.new(
      '$' + variables.datasource.name,
      |||
        sum by(pod, listener_address) (
            rate(
                envoy_listener_downstream_listener_filter_remote_close{
                    namespace=~"$Namespace",pod=~"$pod"
                }
            [$__rate_interval])
        )
      |||
    )
    + prometheusQuery.withIntervalFactor(2)
    + prometheusQuery.withLegendFormat(|||
      {{pod}} {{listener_address}}
    |||),

  envoy_listener_downstream_listener_filter_error:
    prometheusQuery.new(
      '$' + variables.datasource.name,
      |||
        sum by(pod, listener_address) (
            rate(
                envoy_listener_downstream_listener_filter_error{
                    namespace=~"$Namespace",pod=~"$pod"
                }
            [$__rate_interval])
        )
      |||
    )
    + prometheusQuery.withIntervalFactor(2)
    + prometheusQuery.withLegendFormat(|||
      {{pod}} {{listener_address}}
    |||),

  // Per-worker listener statistics
  envoy_listener_worker_downstream_cx_total:
    prometheusQuery.new(
      '$' + variables.datasource.name,
      |||
        sum by(pod, listener_address) (
            rate(
                envoy_listener_worker_[0-9]+_downstream_cx_total{
                    namespace=~"$Namespace",pod=~"$pod"
                }
            [$__rate_interval])
        )
      |||
    )
    + prometheusQuery.withIntervalFactor(2)
    + prometheusQuery.withLegendFormat(|||
      {{pod}} {{listener_address}}
    |||),

  envoy_listener_worker_downstream_cx_active:
    prometheusQuery.new(
      '$' + variables.datasource.name,
      |||
        sum by(pod, listener_address) (
            envoy_listener_worker_[0-9]+_downstream_cx_active{
                namespace=~"$Namespace",pod=~"$pod"
            }
        )
      |||
    )
    + prometheusQuery.withIntervalFactor(2)
    + prometheusQuery.withLegendFormat(|||
      {{pod}} {{listener_address}}
    |||),

  envoy_listener_worker_downstream_cx_destroy:
    prometheusQuery.new(
      '$' + variables.datasource.name,
      |||
        sum by(pod, listener_address) (
            rate(
                envoy_listener_worker_[0-9]+_downstream_cx_destroy{
                    namespace=~"$Namespace",pod=~"$pod"
                }
            [$__rate_interval])
        )
      |||
    )
    + prometheusQuery.withIntervalFactor(2)
    + prometheusQuery.withLegendFormat(|||
      {{pod}} {{listener_address}}
    |||),

  envoy_listener_worker_downstream_cx_length_ms:
    prometheusQuery.new(
      '$' + variables.datasource.name,
      |||
        histogram_quantile(
          $quantiles,
          sum by (pod, listener_address, le) (
            rate(
              envoy_listener_worker_[0-9]+_downstream_cx_length_ms_bucket{
                namespace=~"$Namespace",pod=~"$pod"
              }
            [$__rate_interval])
          )
        )
      |||
    )
    + prometheusQuery.withIntervalFactor(2)
    + prometheusQuery.withLegendFormat(|||
      {{pod}} {{listener_address}}
    |||),

  envoy_listener_worker_downstream_cx_overflow:
    prometheusQuery.new(
      '$' + variables.datasource.name,
      |||
        sum by(pod, listener_address) (
            rate(
                envoy_listener_worker_[0-9]+_downstream_cx_overflow{
                    namespace=~"$Namespace",pod=~"$pod"
                }
            [$__rate_interval])
        )
      |||
    )
    + prometheusQuery.withIntervalFactor(2)
    + prometheusQuery.withLegendFormat(|||
      {{pod}} {{listener_address}}
    |||),

  envoy_listener_worker_downstream_cx_overload_reject:
    prometheusQuery.new(
      '$' + variables.datasource.name,
      |||
        sum by(pod, listener_address) (
            rate(
                envoy_listener_worker_[0-9]+_downstream_cx_overload_reject{
                    namespace=~"$Namespace",pod=~"$pod"
                }
            [$__rate_interval])
        )
      |||
    )
    + prometheusQuery.withIntervalFactor(2)
    + prometheusQuery.withLegendFormat(|||
      {{pod}} {{listener_address}}
    |||),

  envoy_listener_worker_downstream_global_cx_overflow:
    prometheusQuery.new(
      '$' + variables.datasource.name,
      |||
        sum by(pod, listener_address) (
            rate(
                envoy_listener_worker_[0-9]+_downstream_global_cx_overflow{
                    namespace=~"$Namespace",pod=~"$pod"
                }
            [$__rate_interval])
        )
      |||
    )
    + prometheusQuery.withIntervalFactor(2)
    + prometheusQuery.withLegendFormat(|||
      {{pod}} {{listener_address}}
    |||),

  envoy_listener_worker_downstream_pre_cx_timeout:
    prometheusQuery.new(
      '$' + variables.datasource.name,
      |||
        sum by(pod, listener_address) (
            rate(
                envoy_listener_worker_[0-9]+_downstream_pre_cx_timeout{
                    namespace=~"$Namespace",pod=~"$pod"
                }
            [$__rate_interval])
        )
      |||
    )
    + prometheusQuery.withIntervalFactor(2)
    + prometheusQuery.withLegendFormat(|||
      {{pod}} {{listener_address}}
    |||),

  envoy_listener_worker_downstream_pre_cx_active:
    prometheusQuery.new(
      '$' + variables.datasource.name,
      |||
        sum by(pod, listener_address) (
            envoy_listener_worker_[0-9]+_downstream_pre_cx_active{
                namespace=~"$Namespace",pod=~"$pod"
            }
        )
      |||
    )
    + prometheusQuery.withIntervalFactor(2)
    + prometheusQuery.withLegendFormat(|||
      {{pod}} {{listener_address}}
    |||),

  envoy_listener_worker_downstream_listener_filter_remote_close:
    prometheusQuery.new(
      '$' + variables.datasource.name,
      |||
        sum by(pod, listener_address) (
            rate(
                envoy_listener_worker_[0-9]+_downstream_listener_filter_remote_close{
                    namespace=~"$Namespace",pod=~"$pod"
                }
            [$__rate_interval])
        )
      |||
    )
    + prometheusQuery.withIntervalFactor(2)
    + prometheusQuery.withLegendFormat(|||
      {{pod}} {{listener_address}}
    |||),

  envoy_listener_worker_downstream_listener_filter_error:
    prometheusQuery.new(
      '$' + variables.datasource.name,
      |||
        sum by(pod, listener_address) (
            rate(
                envoy_listener_worker_[0-9]+_downstream_listener_filter_error{
                    namespace=~"$Namespace",pod=~"$pod"
                }
            [$__rate_interval])
        )
      |||
    )
    + prometheusQuery.withIntervalFactor(2)
    + prometheusQuery.withLegendFormat(|||
      {{pod}} {{listener_address}}
    |||),
} 