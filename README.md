# Istio Envoy Dashboards

Grafana dashboards for monitoring Envoy proxy stats in Istio. These dashboards show network traffic metrics, connection stats, and HTTP metrics from your Envoy proxies.

For more information about Envoy stats in Istio, see the [official Istio documentation](https://istio.io/latest/docs/ops/configuration/telemetry/envoy-stats/).

## Download Dashboards

The dashboards are available at: https://github.com/krutsko/private-istio-envoy-dashboards/releases

You can download the JSON files directly from the releases page and import them into Grafana.

## What's in the Dashboards?

### istio-envoy-clusters.json
- Server stats (uptime, memory, connections)
- Cluster stats (requests, timeouts, retries)
- HTTP metrics (response codes, errors)
- Connection stats (connections, failures, bytes)

### istio-envoy-listeners.json
- Server stats (uptime, memory, connections)
- Listener stats (active/draining listeners)
- HTTP response codes
- Connection manager stats (connections, requests, timing)

## Generate Dashboards Locally

### Setup

```bash
# Install jsonnet-bundler
go install github.com/jsonnet-bundler/jsonnet-bundler/cmd/jb@v0.5.1

# Install jsonnet
go install github.com/google/go-jsonnet/cmd/jsonnet@v0.20.0
go install github.com/google/go-jsonnet/cmd/jsonnetfmt@v0.20.0

# Get dependencies
jb install
```

### Generate Dashboards

```bash
jsonnet -J . -J vendor istio-envoy-clusters.libsonnet > istio-envoy-clusters.json
jsonnet -J . -J vendor istio-envoy-listeners.libsonnet > istio-envoy-listeners.json
jsonnet -J . -J vendor istio-envoy-http-conn-manager.libsonnet > istio-envoy-http-conn-manager.json
```
