# Backup and Restore Files on a Linux Server using Ansible

## Introduction

Data backup and restoration are essential practices for ensuring data integrity and availability in case of accidental deletion, hardware failure, or other data loss scenarios. Automating these processes using Ansible can help streamline operations, reduce human error, and ensure consistency across multiple servers. This project demonstrates how to use Ansible to back up and restore files on a Linux server.

## Objectives

1. Understand the basics of Ansible and its role in automation.

2. Set up the Ansible environment to manage Linux servers.

3. Create an Ansible playbook to back up files to a remote or local directory.

4. Develope a playbook to restore files from the backup location.

5. Test and verify the backup and restoration process.

## Prerequisites

1. **Linux Server:** A Linux server to act as the target node and an optional control node for Ansible.

2. **Ansible Installed:** Ansible should be installed on the control node.

3. **SSH Access:** Ensure SSH access to the target Linux server from the control node.

4. **Basic Linux Knowledge:** Familiarity with Linux command line and file management.

## Tasks Overview

1. Install and configure Ansible on the control node.

2. Set up an inventory file to define the target Linux server.

3. Create an Ansible playbook to back up files.

4. Create an Ansible playbook to restore files from the backup.

5. Test and verify the backup and restoration process.

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
    [linux_servers]
    target ansible_host=<target_server_ip> ansible_user=<user>
    ```
    Replace `<target_server_ip>` and `<user>` with the appropriate values.
---

## Task 3: Create Ansible Playbook for Backup
1. Create a new playbook file for backup:

    ```bash
    nano backup.yml
    ```
2. Add the following content to the playbook:

    ```yaml
    - name: Backup files on the server
  hosts: linux_servers
  tasks:
    - name: Create backup directory
      file:
        path: /backup
        state: directory
        mode: '0755'

    - name: Copy files to backup directory
      copy:
        src: /path/to/files
        dest: /backup/
        remote_src: yes
    ```
    Replace `/path/to/files` with the actual path of the files you want to back up.
3. Save and exit the file.

---
## Task 4: Create Ansible Playbook for Restore

1. Create a new playbook file for restoration:

    ```bash
    nano restore.yml
    ```
2. Add the following content to the playbook:

    ```yaml
    - name: Restore files from backup
  hosts: linux_servers
  tasks:
    - name: Copy files back to original location
      copy:
        src: /backup/
        dest: /path/to/files
        remote_src: yes

    ```
    Replace `/path/to/file/` with the actual path where you want to restore the files.

3. Save and exit the file.
---
## Task 5: Test and Verify the Backup and Restoration Process

1. Run the backup playbook:

    ```bash
    ansible-playbook -i inventory.ini backup.yml
    ```
2. Verify that the files have been backed up to the `/backup` directory on the target server.
    ```bash
    ls /backup
    ```
3. Run the restoration playbook:

    ```bash
    ansible-playbook -i inventory.ini restore.yml
    ```
4. Verify that the files have been restored to their original location:

    ```bash
    ls /path/to/files
    ```

5. Check the contents of the restored files to ensure they match the original files.
6. Clean up the backup directory if needed:

    ```bash
    rm -rf /backup
    ```
---
## Conclusion
In this project, you have successfully automated the backup and restoration of files on a Linux server using Ansible. This approach not only saves time but also ensures consistency and reduces the risk of human error in file management tasks. You can further enhance these playbooks by adding features such as scheduling backups, compressing backup files, or integrating with cloud storage solutions. Ansible's flexibility allows you to scale this solution to manage multiple servers efficiently.