# Uptime Monitoring with Gatus

This project sets up [Gatus](https://github.com/TwinProduction/gatus), a lightweight uptime monitoring tool, to track the availability of websites and services. You'll configure endpoints, set up alerting, and visualize uptime data—all containerized for easy deployment.

---

## Objectives

- Understand Gatus and its role in uptime monitoring
- Deploy Gatus using Docker
- Monitor endpoints with custom conditions
- Configure alerting (e.g., Slack, email)
- Visualize uptime data via the Gatus dashboard

---

## Prerequisites

- Familiarity with HTTP services and YAML
- Docker installed on your machine
- Internet access for testing endpoints

---

## 🛠️ Setup Instructions

### 1. Install Docker
Follow the [official Docker installation guide](https://docs.docker.com/get-docker/)

### 2. Pull Gatus Docker Image
```bash
docker pull twinproduction/gatus
```
### 3. Create Gatus Configuration File
```bash
mkdir gatus
cd gatus
```

### 4. Sart Gatus with Docker with a basic setup
```bash
docker run -d -p 8080:8080 -v $(pwd)/config.yaml:/app/config.yaml twinproduction/gatus
```
### 5. Access Gatus Dashboard
Open your browser and navigate to `http://localhost:8080` to access the Gatus dashboard.

---

## Task 2 : Create a Basic Configuration File

#### 1. Create a file named `config.yaml` in the `gatus` directory with the following content:

```yaml
endpoints:
  - name: Example Website
    url: "https://example.com"
    interval: 60s
    conditions:
      - "[STATUS] == 200"

ui:
  theme: dark
  title: "My Uptime Monitor"
  logo: "https://example.com/my-logo.png"
  favicon: "https://example.com/my-favicon.ico"
```
#### 2. Restart Gatus to apply the new configuration:
```bash
docker restart gatus
```
#### 3. Verify Monitoring
- Open the Gatus dashboard at `http://localhost:8080` and check the status of "Example Website".
---
## Task 3: Test the Setup with Live Endpoints

### 1. Add another endpoint to the `config.yaml` file for monitoring:

```yaml
- name: GitHub
  url: "https://github.com"
  interval: 60s
  conditions:
    - "[STATUS] == 200"
```

### 2. Restart Gatus and verify the new endpoint is being monitored:

```bash
docker restart gatus
```

### 3. Simulate a failure by adding a non-existent endpoint and observe the status change in the dashboard:

```yaml
- name: Nonexistent
  url: "https://thiswebsitedoesnotexist.com"
  interval: 60s
  conditions:
    - "[STATUS] == 200"
```

You should see the status change to "DOWN" in the Gatus dashboard.

## Task 4: Configure Alert for Downtime

### 1. Choose an alerting method (e.g., Slack, Email). For this example, we'll use Slack.

- Create a Slack Incoming Webhook by following [this guide](https://api.slack.com/messaging/webhooks).

### 2. Update the `config.yaml` file to include the Slack alert configuration:

```yaml
alerts:
  - type: slack
    url: "https://hooks.slack.com/services/YOUR/WEBHOOK/URL"
    failure-threshold: 2
    success-threshold: 2
```

### 3. Test the alerting by takijng down one of the monitored endpoints and checking if you receive a Slack notification.

This can be done by changing the URL of an existing endpoint to an invalid one temporarily.

---
## Taks 5: Explore and Cusomise the Gatus Dashboard

1. Access the Gatus dashboard at `http://localhost:8080` to view uptime statistic for each monitored endpoint.

2. Customize the dashboard appearance (e.g., themes, layout, logos) by modifying the `config.yaml` file.  
This is done by adding a `ui` section to the configuration file.

```yaml
ui:
  theme: dark
  title: "My Uptime Monitor"
  logo: "https://example.com/my-logo.png"
  favicon: "https://example.com/my-favicon.ico"
```

3. Adjust monitoring intervals and conditions to optimize performance.

This can be done by changing the `interval` and `conditions` fields for each endpoint in the `config.yaml` file. For example, you can set a shorter interval for critical services or add more conditions to monitor specific response times.

## Conclusion
In this project, you have successfully set up Gatus for uptime monitoring of websites and services. You learned how to configure endpoints, set up alerting via Slack, and customize the Gatus dashboard. This setup provides a solid foundation for monitoring the availability of your critical services and ensuring timely notifications in case of downtime. You can further enhance this setup by exploring additional alerting methods, integrating with other tools, and expanding the list of monitored endpoints as needed.


