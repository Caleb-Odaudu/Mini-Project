# Monitor Linux Server using Prometheus Node Exporter

## Introduction
Monitoring a Linux Server is essential for ensuring system health, performance, and availability. Prometheus Node Exporter is a powerful tool that collects and exposes various system metrics, making it easier to monitor and analyze the performance of Linux servers. This project demonstrates how to set up Prometheus Node Exporter on a Linux server for effective monitoring.

## Objectives

1. Install and configure Prometheus Node Exporter on a Linux server.

2. Integrate Node Exporter with Prometheus for metric collection.

3. Explore system metrics collected by Node Exporter.

4. Set up basic queiries for real-time monitoring.

5. Optionally configure alerts for key metrics.

## Prerequisites

1. **Linux Server:** A Linux server with `sudo` privileges.

2. **Prometheus Instance:** A running Prometheus server to scrape metrics from Node Exporter.

3. **Network Access:** Ensure the Linux server can communicate with the Prometheus server.

4. **Tools:** Terminal access to the Linux server, Prometheus UI access, and a text editor for authorising configuration files.

## Tasks Overview

1. Install Prometheus Node Exporter on the Linux server.

2. Start and enable the Node Exporter as a service.

3. Configure Prometheus to scrape metrics from Node Exporter.

4. Verify and query Node Exporter metrics in Prometheus.

5. Explore and analyse the collected metrics on the Prometheus dashboard.

---
## Task 1: Install Prometheus Node Exporter

1. Download the latest version of Prometheus Github releases:

    ```bash
    curl -LO https://github.com/prometheus/node_exporter/releases/latest/download/node_exporter-linux-amd64.tar.gz
    ```
2. Extract the downloaded tarball:

    ```bash
    tar xvfz node_exporter-linux-amd64.tar.gz
    ```
3. Move the Node Exporter binary to `/usr/local/bin`:

    ```bash
    sudo mv node_exporter-linux-amd64/node_exporter /usr/local/bin/
    ```
---

## Task 2: Start and Enable Node Exporter as a Service

1. Create a systemd service file for Node Exporter:

    ```bash
    sudo nano /etc/systemd/system/node_exporter.service
    ```
2. Add the following content to the service file:

    ```ini
    [Unit]
Description=Prometheus Node Exporter
After=network.target

[Service]
User=nobody
ExecStart=/usr/local/bin/node_exporter
Restart=always

[Install]
WantedBy=multi-user.target
    ```
3. Reload systemd and start the Node Exporter service:

    ```bash
    sudo systemctl daemon-reload
    sudo systemctl start node_exporter
    sudo systemctl enable node_exporter
    ```
4. Verify that the Node Exporter service is running:

    ```bash
    sudo systemctl status node_exporter
    ```
5. Confirm Node Exporter is accessible by visiting `http://<your_server_ip>:9100/metrics` in a web browser. If you are using a computer, `<your-server-ip>` is `localhost`.
---
## Task 3: Configure Prometheus to Scrape Node Exporter Metrics

1. Open the Prometheus configuration file (usually `prometheus.yml`):

    ```bash
    sudo nano /etc/prometheus/prometheus.yml
    ```
2. Add a new job to scrape metrics from Node Exporter:

    ```yaml
    scrape_configs:
      - job_name: 'node-exporter'
        static_configs:
          - targets: ['<your-server-ip>:9100']
    ```
    Replace `<your-server-ip>` with the actual IP address of your Linux server.

3. Save the configuration file and restart Prometheus to apply the changes:

    ```bash
    sudo systemctl restart prometheus
    ```
---

## Task 4: Verify and Query Node Exporter Metrics in Prometheus

1. Open the Prometheus web UI by navigating to `http://<prometheus-server-ip>:9090` in your web browser.

2. Run a test query to verify Node Exporter metrics:

    - Example Query: `node_cpu_seconds_total` to view CPU usage metrics.

3.  Check the "Targets" page in Prometheus to ensure that the Node Exporter job is listed and the status is "UP".

---
## Task 5: Explore and Analyze Collected Metrics

1. Use the prometheus query interface to explore key Node Exporter metrics such as:

    - `node_memory_MemAvailable_bytes` for available memory.
    - `node_filesystem_avail_bytes` for available disk space.
    - `node_network_receive_bytes_total` for network traffic.
2. Creare a basic time-series graph for CPU usage:

    - Query: `rate(node_cpu_seconds_total[5m])` to analyse CPU usage over the last 5 minutes.
3. Optionally, set up alerts in Prometheus for critical metrics (e.g., high CPU or low memory) using Alertmanager.

If you are unfamiliar with setting up alerts, refer to the [Prometheus Alerting Documentation](https://prometheus.io/docs/alerting/latest/).

## Conclusion
In this project, you have successfully set up Prometheus Node Exporter on a Linux server for monitoring system metrics. By integrating Node Exporter with Prometheus, you can effectively collect, visualize, and analyze key performance indicators of your Linux server. This setup provides a solid foundation for proactive monitoring and alerting, helping ensure the health and performance of your infrastructure.