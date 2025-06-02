local g = import './g.libsonnet';
local prometheusQuery = g.query.prometheus;

local variables = import './variables.libsonnet';

{
  // Connection statistics
  envoy_http_downstream_cx_total:
    prometheusQuery.new(
      '$' + variables.datasource.name,
      |||
        sum by(pod, http_conn_manager_prefix) (
            rate(
                envoy_http_downstream_cx_total{
                    namespace=~"$Namespace",pod=~"$pod",http_conn_manager_prefix=~"$http_conn_manager_prefix"
                }
            [$__rate_interval])
        )
      |||
    )
    + prometheusQuery.withIntervalFactor(2)
    + prometheusQuery.withLegendFormat(|||
      {{pod}} {{http_conn_manager_prefix}}
    |||),

  envoy_http_downstream_cx_ssl_total:
    prometheusQuery.new(
      '$' + variables.datasource.name,
      |||
        sum by(pod, http_conn_manager_prefix) (
            rate(
                envoy_http_downstream_cx_ssl_total{
                    namespace=~"$Namespace",pod=~"$pod",http_conn_manager_prefix=~"$http_conn_manager_prefix"
                }
            [$__rate_interval])
        )
      |||
    )
    + prometheusQuery.withIntervalFactor(2)
    + prometheusQuery.withLegendFormat(|||
      {{pod}} {{http_conn_manager_prefix}} - envoy_http_downstream_cx_ssl_total
    |||),

  envoy_http_downstream_cx_http1_total:
    prometheusQuery.new(
      '$' + variables.datasource.name,
      |||
        sum by(pod, http_conn_manager_prefix) (
            rate(
                envoy_http_downstream_cx_http1_total{
                    namespace=~"$Namespace",pod=~"$pod",http_conn_manager_prefix=~"$http_conn_manager_prefix"
                }
            [$__rate_interval])
        )
      |||
    )
    + prometheusQuery.withIntervalFactor(2)
    + prometheusQuery.withLegendFormat(|||
      {{pod}} {{http_conn_manager_prefix}} - envoy_http_downstream_cx_http1_total
    |||),

  envoy_http_downstream_cx_http2_total:
    prometheusQuery.new(
      '$' + variables.datasource.name,
      |||
        sum by(pod, http_conn_manager_prefix) (
            rate(
                envoy_http_downstream_cx_http2_total{
                    namespace=~"$Namespace",pod=~"$pod",http_conn_manager_prefix=~"$http_conn_manager_prefix"
                }
            [$__rate_interval])
        )
      |||
    )
    + prometheusQuery.withIntervalFactor(2)
    + prometheusQuery.withLegendFormat(|||
      {{pod}} {{http_conn_manager_prefix}} - envoy_http_downstream_cx_http2_total
    |||),

  envoy_http_downstream_cx_http3_total:
    prometheusQuery.new(
      '$' + variables.datasource.name,
      |||
        sum by(pod, http_conn_manager_prefix) (
            rate(
                envoy_http_downstream_cx_http3_total{
                    namespace=~"$Namespace",pod=~"$pod",http_conn_manager_prefix=~"$http_conn_manager_prefix"
                }
            [$__rate_interval])
        )
      |||
    )
    + prometheusQuery.withIntervalFactor(2)
    + prometheusQuery.withLegendFormat(|||
      {{pod}} {{http_conn_manager_prefix}} - envoy_http_downstream_cx_http3_total
    |||),

  envoy_http_downstream_cx_active:
    prometheusQuery.new(
      '$' + variables.datasource.name,
      |||
        sum by(pod, http_conn_manager_prefix) (
            envoy_http_downstream_cx_active{
                namespace=~"$Namespace",pod=~"$pod",http_conn_manager_prefix=~"$http_conn_manager_prefix"
            }
        )
      |||
    )
    + prometheusQuery.withIntervalFactor(2)
    + prometheusQuery.withLegendFormat(|||
      {{pod}} {{http_conn_manager_prefix}}
    |||),

  envoy_http_downstream_cx_ssl_active:
    prometheusQuery.new(
      '$' + variables.datasource.name,
      |||
        sum by(pod, http_conn_manager_prefix) (
            envoy_http_downstream_cx_ssl_active{
                namespace=~"$Namespace",pod=~"$pod",http_conn_manager_prefix=~"$http_conn_manager_prefix"
            }
        )
      |||
    )
    + prometheusQuery.withIntervalFactor(2)
    + prometheusQuery.withLegendFormat(|||
      {{pod}} {{http_conn_manager_prefix}} - envoy_http_downstream_cx_ssl_active
    |||),

  envoy_http_downstream_cx_http1_active:
    prometheusQuery.new(
      '$' + variables.datasource.name,
      |||
        sum by(pod, http_conn_manager_prefix) (
            envoy_http_downstream_cx_http1_active{
                namespace=~"$Namespace",pod=~"$pod",http_conn_manager_prefix=~"$http_conn_manager_prefix"
            }
        )
      |||
    )
    + prometheusQuery.withIntervalFactor(2)
    + prometheusQuery.withLegendFormat(|||
      {{pod}} {{http_conn_manager_prefix}} - envoy_http_downstream_cx_http1_active
    |||),

  envoy_http_downstream_cx_http2_active:
    prometheusQuery.new(
      '$' + variables.datasource.name,
      |||
        sum by(pod, http_conn_manager_prefix) (
            envoy_http_downstream_cx_http2_active{
                namespace=~"$Namespace",pod=~"$pod",http_conn_manager_prefix=~"$http_conn_manager_prefix"
            }
        )
      |||
    )
    + prometheusQuery.withIntervalFactor(2)
    + prometheusQuery.withLegendFormat(|||
      {{pod}} {{http_conn_manager_prefix}} - envoy_http_downstream_cx_http2_active
    |||),

  envoy_http_downstream_cx_http3_active:
    prometheusQuery.new(
      '$' + variables.datasource.name,
      |||
        sum by(pod, http_conn_manager_prefix) (
            envoy_http_downstream_cx_http3_active{
                namespace=~"$Namespace",pod=~"$pod",http_conn_manager_prefix=~"$http_conn_manager_prefix"
            }
        )
      |||
    )
    + prometheusQuery.withIntervalFactor(2)
    + prometheusQuery.withLegendFormat(|||
      {{pod}} {{http_conn_manager_prefix}} - envoy_http_downstream_cx_http3_active
    |||),

  // Request statistics
  envoy_http_downstream_rq_total:
    prometheusQuery.new(
      '$' + variables.datasource.name,
      |||
        sum by(pod, http_conn_manager_prefix) (
            rate(
                envoy_http_downstream_rq_total{
                    namespace=~"$Namespace",pod=~"$pod",http_conn_manager_prefix=~"$http_conn_manager_prefix"
                }
            [$__rate_interval])
        )
      |||
    )
    + prometheusQuery.withIntervalFactor(2)
    + prometheusQuery.withLegendFormat(|||
      {{pod}} {{http_conn_manager_prefix}}
    |||),

  envoy_http_downstream_rq_http1_total:
    prometheusQuery.new(
      '$' + variables.datasource.name,
      |||
        sum by(pod, http_conn_manager_prefix) (
            rate(
                envoy_http_downstream_rq_http1_total{
                    namespace=~"$Namespace",pod=~"$pod",http_conn_manager_prefix=~"$http_conn_manager_prefix"
                }
            [$__rate_interval])
        )
      |||
    )
    + prometheusQuery.withIntervalFactor(2)
    + prometheusQuery.withLegendFormat(|||
      {{pod}} {{http_conn_manager_prefix}} - envoy_http_downstream_rq_http1_total
    |||),

  envoy_http_downstream_rq_http2_total:
    prometheusQuery.new(
      '$' + variables.datasource.name,
      |||
        sum by(pod, http_conn_manager_prefix) (
            rate(
                envoy_http_downstream_rq_http2_total{
                    namespace=~"$Namespace",pod=~"$pod",http_conn_manager_prefix=~"$http_conn_manager_prefix"
                }
            [$__rate_interval])
        )
      |||
    )
    + prometheusQuery.withIntervalFactor(2)
    + prometheusQuery.withLegendFormat(|||
      {{pod}} {{http_conn_manager_prefix}} - envoy_http_downstream_rq_http2_total
    |||),

  envoy_http_downstream_rq_http3_total:
    prometheusQuery.new(
      '$' + variables.datasource.name,
      |||
        sum by(pod, http_conn_manager_prefix) (
            rate(
                envoy_http_downstream_rq_http3_total{
                    namespace=~"$Namespace",pod=~"$pod",http_conn_manager_prefix=~"$http_conn_manager_prefix"
                }
            [$__rate_interval])
        )
      |||
    )
    + prometheusQuery.withIntervalFactor(2)
    + prometheusQuery.withLegendFormat(|||
      {{pod}} {{http_conn_manager_prefix}} - envoy_http_downstream_rq_http3_total
    |||),

  envoy_http_downstream_rq_active:
    prometheusQuery.new(
      '$' + variables.datasource.name,
      |||
        sum by(pod, http_conn_manager_prefix) (
            envoy_http_downstream_rq_active{
                namespace=~"$Namespace",pod=~"$pod",http_conn_manager_prefix=~"$http_conn_manager_prefix"
            }
        )
      |||
    )
    + prometheusQuery.withIntervalFactor(2)
    + prometheusQuery.withLegendFormat(|||
      {{pod}} {{http_conn_manager_prefix}}
    |||),

  // Response code statistics
  envoy_http_downstream_rq_1xx:
    prometheusQuery.new(
      '$' + variables.datasource.name,
      |||
        sum by(pod, http_conn_manager_prefix) (
            rate(
                envoy_http_downstream_rq_1xx{
                    namespace=~"$Namespace",pod=~"$pod",http_conn_manager_prefix=~"$http_conn_manager_prefix"
                }
            [$__rate_interval])
        )
      |||
    )
    + prometheusQuery.withIntervalFactor(2)
    + prometheusQuery.withLegendFormat(|||
      {{pod}} {{http_conn_manager_prefix}} - downstream_rq_1xx
    |||),

  envoy_http_downstream_rq_2xx:
    prometheusQuery.new(
      '$' + variables.datasource.name,
      |||
        sum by(pod, http_conn_manager_prefix) (
            rate(
                envoy_http_downstream_rq_2xx{
                    namespace=~"$Namespace",pod=~"$pod",http_conn_manager_prefix=~"$http_conn_manager_prefix"
                }
            [$__rate_interval])
        )
      |||
    )
    + prometheusQuery.withIntervalFactor(2)
    + prometheusQuery.withLegendFormat(|||
      {{pod}} {{http_conn_manager_prefix}} - downstream_rq_2xx
    |||),

  envoy_http_downstream_rq_3xx:
    prometheusQuery.new(
      '$' + variables.datasource.name,
      |||
        sum by(pod, http_conn_manager_prefix) (
            rate(
                envoy_http_downstream_rq_3xx{
                    namespace=~"$Namespace",pod=~"$pod",http_conn_manager_prefix=~"$http_conn_manager_prefix"
                }
            [$__rate_interval])
        )
      |||
    )
    + prometheusQuery.withIntervalFactor(2)
    + prometheusQuery.withLegendFormat(|||
      {{pod}} {{http_conn_manager_prefix}} - downstream_rq_3xx
    |||),

  envoy_http_downstream_rq_4xx:
    prometheusQuery.new(
      '$' + variables.datasource.name,
      |||
        sum by(pod, http_conn_manager_prefix) (
            rate(
                envoy_http_downstream_rq_4xx{
                    namespace=~"$Namespace",pod=~"$pod",http_conn_manager_prefix=~"$http_conn_manager_prefix"
                }
            [$__rate_interval])
        )
      |||
    )
    + prometheusQuery.withIntervalFactor(2)
    + prometheusQuery.withLegendFormat(|||
      {{pod}} {{http_conn_manager_prefix}} - downstream_rq_4xx
    |||),

  envoy_http_downstream_rq_5xx:
    prometheusQuery.new(
      '$' + variables.datasource.name,
      |||
        sum by(pod, http_conn_manager_prefix) (
            rate(
                envoy_http_downstream_rq_5xx{
                    namespace=~"$Namespace",pod=~"$pod",http_conn_manager_prefix=~"$http_conn_manager_prefix"
                }
            [$__rate_interval])
        )
      |||
    )
    + prometheusQuery.withIntervalFactor(2)
    + prometheusQuery.withLegendFormat(|||
      {{pod}} {{http_conn_manager_prefix}} - downstream_rq_5xx
    |||),

  // Request timing
  envoy_http_downstream_rq_time:
    prometheusQuery.new(
      '$' + variables.datasource.name,
      |||
        histogram_quantile(
          $quantiles,
          sum by (pod, http_conn_manager_prefix, le) (
            rate(
              envoy_http_downstream_rq_time_bucket{
                namespace=~"$Namespace",pod=~"$pod",http_conn_manager_prefix=~"$http_conn_manager_prefix"
              }
            [$__rate_interval])
          )
        )
      |||
    )
    + prometheusQuery.withIntervalFactor(2)
    + prometheusQuery.withLegendFormat(|||
      {{pod}} {{http_conn_manager_prefix}}
    |||),

  // Connection timing
  envoy_http_downstream_cx_length_ms:
    prometheusQuery.new(
      '$' + variables.datasource.name,
      |||
        histogram_quantile(
          $quantiles,
          sum by (pod, http_conn_manager_prefix, le) (
            rate(
              envoy_http_downstream_cx_length_ms_bucket{
                namespace=~"$Namespace",pod=~"$pod",http_conn_manager_prefix=~"$http_conn_manager_prefix"
              }
            [$__rate_interval])
          )
        )
      |||
    )
    + prometheusQuery.withIntervalFactor(2)
    + prometheusQuery.withLegendFormat(|||
      {{pod}} {{http_conn_manager_prefix}}
    |||),

  // Error statistics
  envoy_http_downstream_cx_protocol_error:
    prometheusQuery.new(
      '$' + variables.datasource.name,
      |||
        sum by(pod, http_conn_manager_prefix) (
            rate(
                envoy_http_downstream_cx_protocol_error{
                    namespace=~"$Namespace",pod=~"$pod",http_conn_manager_prefix=~"$http_conn_manager_prefix"
                }
            [$__rate_interval])
        )
      |||
    )
    + prometheusQuery.withIntervalFactor(2)
    + prometheusQuery.withLegendFormat(|||
      {{pod}} {{http_conn_manager_prefix}} - envoy_http_downstream_cx_protocol_error
    |||),

  envoy_http_downstream_rq_rx_reset:
    prometheusQuery.new(
      '$' + variables.datasource.name,
      |||
        sum by(pod, http_conn_manager_prefix) (
            rate(
                envoy_http_downstream_rq_rx_reset{
                    namespace=~"$Namespace",pod=~"$pod",http_conn_manager_prefix=~"$http_conn_manager_prefix"
                }
            [$__rate_interval])
        )
      |||
    )
    + prometheusQuery.withIntervalFactor(2)
    + prometheusQuery.withLegendFormat(|||
      {{pod}} {{http_conn_manager_prefix}} - envoy_http_downstream_rq_rx_reset
    |||),

  envoy_http_downstream_rq_tx_reset:
    prometheusQuery.new(
      '$' + variables.datasource.name,
      |||
        sum by(pod, http_conn_manager_prefix) (
            rate(
                envoy_http_downstream_rq_tx_reset{
                    namespace=~"$Namespace",pod=~"$pod",http_conn_manager_prefix=~"$http_conn_manager_prefix"
                }
            [$__rate_interval])
        )
      |||
    )
    + prometheusQuery.withIntervalFactor(2)
    + prometheusQuery.withLegendFormat(|||
      {{pod}} {{http_conn_manager_prefix}} - envoy_http_downstream_rq_tx_reset
    |||),

  // Traffic statistics
  envoy_http_downstream_cx_rx_bytes_total:
    prometheusQuery.new(
      '$' + variables.datasource.name,
      |||
        sum by(pod, http_conn_manager_prefix) (
            rate(
                envoy_http_downstream_cx_rx_bytes_total{
                    namespace=~"$Namespace",pod=~"$pod",http_conn_manager_prefix=~"$http_conn_manager_prefix"
                }
            [$__rate_interval])
        )
      |||
    )
    + prometheusQuery.withIntervalFactor(2)
    + prometheusQuery.withLegendFormat(|||
      {{pod}} {{http_conn_manager_prefix}} - envoy_http_downstream_cx_rx_bytes_total
    |||),

  envoy_http_downstream_cx_tx_bytes_total:
    prometheusQuery.new(
      '$' + variables.datasource.name,
      |||
        sum by(pod, http_conn_manager_prefix) (
            rate(
                envoy_http_downstream_cx_tx_bytes_total{
                    namespace=~"$Namespace",pod=~"$pod",http_conn_manager_prefix=~"$http_conn_manager_prefix"
                }
            [$__rate_interval])
        )
      |||
    )
    + prometheusQuery.withIntervalFactor(2)
    + prometheusQuery.withLegendFormat(|||
      {{pod}} {{http_conn_manager_prefix}} - envoy_http_downstream_cx_tx_bytes_total
    |||),

  envoy_http_downstream_cx_rx_bytes_buffered:
    prometheusQuery.new(
      '$' + variables.datasource.name,
      |||
        sum by(pod, http_conn_manager_prefix) (
            envoy_http_downstream_cx_rx_bytes_buffered{
                namespace=~"$Namespace",pod=~"$pod",http_conn_manager_prefix=~"$http_conn_manager_prefix"
            }
        )
      |||
    )
    + prometheusQuery.withIntervalFactor(2)
    + prometheusQuery.withLegendFormat(|||
      {{pod}} {{http_conn_manager_prefix}} - envoy_http_downstream_cx_rx_bytes_buffered
    |||),

  envoy_http_downstream_cx_tx_bytes_buffered:
    prometheusQuery.new(
      '$' + variables.datasource.name,
      |||
        sum by(pod, http_conn_manager_prefix) (
            envoy_http_downstream_cx_tx_bytes_buffered{
                namespace=~"$Namespace",pod=~"$pod",http_conn_manager_prefix=~"$http_conn_manager_prefix"
            }
        )
      |||
    )
    + prometheusQuery.withIntervalFactor(2)
    + prometheusQuery.withLegendFormat(|||
      {{pod}} {{http_conn_manager_prefix}} - envoy_http_downstream_cx_tx_bytes_buffered
    |||),

  // Response code statistics by class
  envoy_http_downstream_rq_by_code:
    prometheusQuery.new(
      '$' + variables.datasource.name,
      |||
        sum by(pod, http_conn_manager_prefix, response_code_class) (
            rate(
                envoy_http_downstream_rq{
                    namespace=~"$Namespace",pod=~"$pod",http_conn_manager_prefix=~"$http_conn_manager_prefix"
                }
            [$__rate_interval])
        )
      |||
    )
    + prometheusQuery.withIntervalFactor(2)
    + prometheusQuery.withLegendFormat(|||
      {{pod}} {{http_conn_manager_prefix}} - {{response_code_class}}
    |||),

  // Response code statistics by individual code
  envoy_http_downstream_rq_by_response_code:
    prometheusQuery.new(
      '$' + variables.datasource.name,
      |||
        sum by(pod, http_conn_manager_prefix, response_code) (
            rate(
                envoy_http_downstream_rq{
                    namespace=~"$Namespace",pod=~"$pod",http_conn_manager_prefix=~"$http_conn_manager_prefix"
                }
            [$__rate_interval])
        )
      |||
    )
    + prometheusQuery.withIntervalFactor(2)
    + prometheusQuery.withLegendFormat(|||
      {{pod}} {{http_conn_manager_prefix}} - {{response_code}}
    |||),

  // 5xx errors by response code
  envoy_http_downstream_rq_5xx_response_code:
    prometheusQuery.new(
      '$' + variables.datasource.name,
      |||
        sum by(pod, http_conn_manager_prefix, response_code) (
            rate(
                envoy_http_downstream_rq{
                    namespace=~"$Namespace",pod=~"$pod",http_conn_manager_prefix=~"$http_conn_manager_prefix",response_code=~"5.."
                }
            [$__rate_interval])
        )
      |||
    )
    + prometheusQuery.withIntervalFactor(2)
    + prometheusQuery.withLegendFormat(|||
      {{pod}} {{http_conn_manager_prefix}} - {{response_code}}
    |||),
} 