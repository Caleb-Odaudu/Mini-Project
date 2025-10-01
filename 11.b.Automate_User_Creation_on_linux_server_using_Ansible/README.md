# Automating User Creation on Linux Server using Ansible

## Introduction

Managing user accounts is a common administrative task on Linux servers. Manually creating and managing user accounts can become tedious, especially when dealing with multiple servers or a large number of users. Ansible, an open-source automation tool, can simplify this process by allowing you to automate user creation and management tasks. This project demonstrates how to use Ansible to automate the creation of user accounts on a Linux server.

## Objectives

1. Understand the basics of Ansible and its components.
2. Set up the Ansible environment to manage Linux servers.
3. Create an Ansible playbook to automate user creation.
4. Configure additional settings like home directories, groups, and SSH access.
5. Test and verify the user creation process.

## Prerequisites

1. **Linux Server:** A Linux server to act as the target node and an optional control node for Ansible.
2. **Ansible Installed:** Ansible should be installed on the control node.
3. **SSH Access:** Ensure SSH access to the target Linux server from the control node.
4. **Basic Linux Knowledge:** Familiarity with Linux command line and user management.

## Tasks Overview

1. Install and configure Ansible on the control node.
2. Set up an inventory file to define the target Linux server.
3. Create an Ansible playbook to automate user creation.
4. Configure additional user settings such as home directories, groups, and SSH keys.
5. Verify the user creation process by logging into the target server.

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
    ssh-keygen -t rsa -b 2048
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

## Task 3: Create Ansible Playbook for User Creation

1. Create a playbook file:

    ```bash
    nano create_users.yml
    ```

2. Add the following content to the playbook (corrected YAML syntax):

    ```yaml
    - name: Automate user creation
      hosts: linux_servers
      become: yes
      vars:
        users:
          - username: "user1"
          - username: "user2"
      tasks:
        - name: Create users with home directories and bash shell
          user:
            name: "{{ item.username }}"
            state: present
            shell: /bin/bash
            create_home: yes
          loop: "{{ users }}"
    ```
    This playbook creates two users, `user1` and `user2`, with home directories and bash shells.

---

## Task 4: Configure Additional User Settings

1. Update the playbook to include additional settings like groups and SSH keys:

    ```yaml
    - name: Automate user creation with groups and SSH keys
      hosts: linux_servers
      become: yes
      vars:
        users:
          - username: "user1"
            groups: "sudo"
            ssh_key: "/path/to/user1.pub"
          - username: "user2"
            groups: "docker"
            ssh_key: "/path/to/user2.pub"
      tasks:
        - name: Create users with groups
          user:
            name: "{{ item.username }}"
            state: present
            shell: /bin/bash
            create_home: yes
            groups: "{{ item.groups }}"
          loop: "{{ users }}"

        - name: Add SSH key for the users
          authorized_key:
            user: "{{ item.username }}"
            state: present
            key: "{{ lookup('file', item.ssh_key) }}"
          loop: "{{ users }}"
    ```
    **Note:** Replace `/path/to/user1.pub` and `/path/to/user2.pub` with the actual paths to the public SSH keys.

---

## Task 5: Run the Playbook and Verify

1. Run the Ansible playbook:

    ```bash
    ansible-playbook -i inventory.ini create_users.yml
    ```

2. Verify the users were created on the target server by logging in or checking the `/etc/passwd` file:

    ```bash
    cat /etc/passwd
    ls /home
    ```

3. Test SSH access for the newly created users:

    ```bash
    ssh user1@target_server_ip
    ssh user2@target_server_ip
    ```

    They should be able to log in using their respective SSH keys.

---

## Conclusion

In this project, you have successfully automated the creation of user accounts on a Linux server using Ansible. This approach not only saves time but also ensures consistency and reduces the risk of human error in user management tasks. You can further enhance this playbook by adding more features such as password policies, user expiration, and more. Ansible's flexibility allows you to scale this solution to manage multiple servers efficiently.

---
