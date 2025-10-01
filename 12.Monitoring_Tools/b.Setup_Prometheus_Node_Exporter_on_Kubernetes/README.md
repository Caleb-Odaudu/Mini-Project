# Setup Prometheus Node Exporter on Kubernetes

## Introduction

Prometheus is a widely used monitoring system that collects and stores metrics as time series data. The Prometheus Node Exporter is a crucial component that runs on each node in a Kubernetes cluster, exposing hardware and OS metrics for Prometheus to scrape. This project demonstrates how to set up the Prometheus Node Exporter on a Kubernetes cluster for effective monitoring.

## Objectives
1. Understand the purpose of Prometheus Node Exporter.

2. Deploy Node Exporter as a DaemonSet on a Kubernetes cluster.

3. Configure Prometheus to scrape metrics from Node Exporter.

4. Visualise metrics using Prometheus UI.

5. Explore metrics available through Node Exporter.

## Prerequisites

1. **Kubernetes Cluster:** A running Kubernetes cluster (Minikube, EKS, GKE, etc.).

2. **kubectl Installed:** Ensure `kubectl` is installed and configured to interact with your Kubernetes cluster.

3. **Prometheus Setup:** A running Prometheus instance in the cluster or accessible externally.

4. **Tools:** A text editor to create and edit YAML files.

## Tasks Overview

1. Understand how Node Exporter works and its purpose.

2. Deploy Node Exporter as a DaemonSet 

3. Configure Prometheus to scrape Node Exporter metrics.

4. Verify the setup by querying metrics in Prometheus.
5. Explore the metrics exposed by Node Exporter.

---

## Task 1: Understand Node Exporter

1. Node Exporter is a lightweight application that runs on a node and exposes metrics about the node's hardware and operating system.

2. Key metrics includes:

    - CPU usage
    - Memory usage
    - Disk I/O
    - Network statistics
    - Filesystem usage

3. Node Exporter runs as a DaemonSet in Kubernetes, ensuring that an instance is running on each node in the cluster.
---

## Task 2: Deploy Node Exporter as a DaemonSet

1. Create a YAML file named `node-exporter-daemonset.yaml` with the following content:

```yaml
apiVersion: apps/v1
kind: DaemonSet
metadata:
  name: node-exporter
  namespace: monitoring
spec:
  selector:
    matchLabels:
      app: node-exporter
  template:
    metadata:
      labels:
        app: node-exporter
    spec:
      containers:
        - name: node-exporter
          image: prom/node-exporter:latest
          ports:
            - containerPort: 9100
              name: metrics
          securityContext:
            runAsNonRoot: true
            allowPrivilegeEscalation: false
          resources:
            limits:
              memory: "100Mi"
              cpu: "100m"
            requests:
              memory: "50Mi"
              cpu: "50m"
```

*Notes:*
- Remove any leading spaces before `apiVersion` to ensure correct YAML indentation.
- All keys and values are properly indented using spaces (not tabs).

2. Apply the YAML file to deploy the DaemonSet:

```bash
kubectl apply -f node-exporter-daemonset.yaml
```

3. Verify that the DaemonSet is running:

```bash
kubectl get daemonsets -n monitoring
```

4. Check the pods created by the DaemonSet:

```bash
kubectl get pods -n monitoring -l app=node-exporter
```
---
## Task 3: Configure Prometheus to Scrape Node Exporter Metrics

1. Edit the Prometheus configuration and add a scrape job for Node Exporter:

```yaml
scrape_configs:
  - job_name: 'node-exporter'
    kubernetes_sd_configs:
      - role: endpoints
    relabel_configs:
      - source_labels: [__meta_kubernetes_service_label_app]
        action: keep
        regex: node-exporter
```

*Notes:*
- Place this under the `scrape_configs` section of your `prometheus.yml`.
- Ensure the indentation is consistent and correct.

2. Apply the updated Prometheus configuration and restart Prometheus to apply the changes.

3. Verify that Prometheus is scraping metrics from Node Exporter by checking the Prometheus targets page (usually at `http://<prometheus-server-ip>:9090/targets`).
---

## Task 4: Verify and Query Node Exporter Metrics in Prometheus

1. Access the Prometheus web UI by navigating to `http://<prometheus-server-ip>:9090` in your web browser.

```bash
kubectl port-forward svc/prometheus 9090:9090 -n monitoring
```
2. In the Prometheus UI, run a test query to verify Node Exporter metrics:
    - Example Query: `node_cpu_seconds_total` to view CPU usage metrics.

3. Ensure metrics are being collected and displayed correctly.
---

## Task 5: Explore Node Exporter Metrics

1. Use the prometheus query interface to explore key Node Exporter metrics such as:

    - `node_memory_MemAvailable_bytes` for available memory.
    - `node_filesystem_avail_bytes` for available disk space.
    - `node_network_receive_bytes_total` for network traffic.
2. Creare a basic time-series graph for CPU usage:

    - Query: `rate(node_cpu_seconds_total[5m])` to analyse CPU usage over the last 5 minutes.
3. Optionally, set up alerts in Prometheus for critical metrics (e.g., high CPU or low memory) using Alertmanager.

If you are unfamiliar with setting up alerts, refer to the [Prometheus Alerting Documentation](https://prometheus.io/docs/alerting/latest/).

## Conclusion
In this project, you have successfully set up Prometheus Node Exporter on a Kubernetes cluster. You deployed Node Exporter as a DaemonSet, configured Prometheus to scrape its metrics, and explored the various metrics available for monitoring your nodes. This setup provides valuable insights into the health and performance of your Kubernetes nodes, enabling proactive management and troubleshooting. You can further enhance this monitoring solution by integrating with Grafana for advanced visualizations and dashboards.
