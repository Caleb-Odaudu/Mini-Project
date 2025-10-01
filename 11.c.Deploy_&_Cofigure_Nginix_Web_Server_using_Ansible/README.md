# Deploy and Configure Nginx Web Server using Ansible

## Introduction

Nginx is a popular web server known for its high performance, stability, and low resource consumption. Automating the deployment and configuration of Nginx using Ansible can significantly streamline the process, especially when managing multiple servers. This project demonstrates how to use Ansible to deploy and configure Nginx on a Linux server.

## Objectives

1. Understand how Ansible simplifies the deployment and configuration of applications.
2. Set up an Ansible environment to manage Linux servers.
3. Create and execute an Ansible playbook to install and configure Nginx.
4. Configure a basic Nginx web server using Ansible.
5. Verify the Nginx deployment.

## Prerequisites

1. **Linux Server:** A Linux server to act as the target node and an optional control node for Ansible.
2. **Ansible Installed:** Ansible should be installed on the control node.
3. **SSH Access:** Ensure SSH access to the target Linux server from the control node.
4. **Text Editor:** A text editor to create and edit Ansible playbooks.

## Tasks Overview

1. Install and configure Ansible on the control node.
2. Set up an inventory file to define the target Linux server.
3. Create an Ansible playbook to install Nginx.
4. Configure Nginx settings using Ansible.
5. Verify the Nginx installation and configuration.

---

## Task 1: Install and Configure Ansible

1. Install Ansible on the control node (if not already installed):

    ```bash
    sudo apt update
    sudo apt install ansible -y
    ```

2. Verify the installation:

    ```bash
    ansible --version
    ```

3. Configure SSH access to the target Linux server:

    ```bash
    ssh-keygen -t rsa
    ssh-copy-id user@target_server_ip
    ```
    Replace `user` with your username on the target server and `target_server_ip` with the server's IP address.

---

## Task 2: Set Up Ansible Inventory File

1. Create an inventory file and define the target server:

    ```bash
    nano inventory.ini
    ```

2. Add the target server details:

    ```ini
    [web_servers]
    target ansible_host=<target_server_ip> ansible_user=<user>
    ```
    Replace `<target_server_ip>` and `<user>` with the appropriate values.

---

## Task 3: Create Ansible Playbook to Install Nginx

1. Create a playbook file:

    ```bash
    nano install_nginx.yml
    ```

2. Add the following content to the playbook:

    ```yaml
    - name: Install Nginx on the server
      hosts: web_servers
      become: yes
      tasks:
        - name: Install Nginx
          apt:
            name: nginx
            state: present
            update_cache: yes

        - name: Ensure Nginx is running
          service:
            name: nginx
            state: started
            enabled: yes
    ```

3. Save and close the file.

---

## Task 4: Configure Nginx Settings Using Ansible

1. Create a playbook file for Nginx website configuration:

    ```bash
    nano configure_nginx.yml
    ```

2. Add the following content to the playbook (corrected YAML and Nginx configuration):

    ```yaml
    - name: Configure Nginx website
      hosts: web_servers
      become: yes
      tasks:
        - name: Create website root directory
          file:
            path: /var/www/mywebsite
            state: directory
            mode: '0755'

        - name: Deploy HTML content
          copy:
            content: |
              <html>
              <head><title>Welcome to My Website</title></head>
              <body>
              <h1>Hello from Nginx!</h1>
              </body>
              </html>
            dest: /var/www/mywebsite/index.html

        - name: Configure Nginx server block
          copy:
            content: |
              server {
                  listen 80;
                  server_name _;
                  root /var/www/mywebsite;
                  index index.html;
                  location / {
                      try_files $uri $uri/ =404;
                  }
              }
            dest: /etc/nginx/sites-available/mywebsite

        - name: Enable the Nginx server block
          file:
            src: /etc/nginx/sites-available/mywebsite
            dest: /etc/nginx/sites-enabled/mywebsite
            state: link

        - name: Remove default Nginx server block
          file:
            path: /etc/nginx/sites-enabled/default
            state: absent

        - name: Validate Nginx configuration
          command: nginx -t
          register: nginx_test
          ignore_errors: yes

        - name: Fail if Nginx configuration is invalid
          fail:
            msg: "Nginx configuration test failed. Check the configuration."
          when: nginx_test.rc != 0

        - name: Reload Nginx
          service:
            name: nginx
            state: reloaded
    ```

3. Save and close the file.

---

## Task 5: Verify the Nginx Installation and Configuration

1. Run the playbooks to install and configure Nginx:

    ```bash
    ansible-playbook -i inventory.ini install_nginx.yml
    ansible-playbook -i inventory.ini configure_nginx.yml
    ```

2. Verify Nginx is running on the target server:

    ```bash
    curl http://<target_server_ip>
    ```
    You should see the HTML content served by Nginx.  
    Replace `<target_server_ip>` with the server's IP address.

---

## Conclusion

In this project, you have successfully deployed and configured an Nginx web server using Ansible. This approach not only saves time but also ensures consistency and reduces the risk of human error in server management tasks. You can further enhance this playbook by adding more features such as SSL configuration, load balancing, and error handling. Ansible's flexibility allows you to scale this solution to manage multiple servers efficiently.

---
