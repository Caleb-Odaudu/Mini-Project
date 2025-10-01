#  Setting Up Ansible on a Linux Server

This project guides you through installing and configuring [Ansible](https://www.ansible.com/) on a Linux control node, enabling automated management of target servers. It's designed to help teams streamline infrastructure tasks with reproducible, error-proof workflows.

## What is Ansible?
Ansible is an open-source automation tool used for configuration management, application deployment, and task automation. It uses a simple, human-readable language (YAML) to describe automation jobs, making it easy to learn and use. Ansible operates over SSH, requiring no agent installation on target nodes, which simplifies management and reduces overhead.

This tool is important for a DevOps engineer because it enhances efficiency, consistency, and scalability in managing IT infrastructure. By automating repetitive tasks, Ansible allows engineers to focus on higher-value activities, reduces the risk of human error, and ensures that configurations are consistent across multiple servers.

---

##  Objectives

- Understand what Ansible is and how it works
- Install and configure Ansible on a Linux control node
- Set up SSH key-based authentication for target nodes
- Create an Ansible inventory file
- Verify Ansible setup with basic ad-hoc commands

---

##  Prerequisites

- **Control Node**: Linux server or VM
- **Target Nodes**: At least one Linux server or VM
- **Access**: SSH access to target nodes
- **Tools**: Basic Linux CLI knowledge and a text editor

---

##  Tasks Overview

### Task 1: Install Ansible
```bash
sudo apt update
sudo apt install ansible -y
ansible --version
```

### Task 2: Set Up SSH Key-Based Authentication

1.Generate an SSH key pair on the control node if you don't already have one:


```bash
ssh-keygen -t rsa -b 2048
```
Press Enter to accept the default file location and set a passphrase if desired.

2. Copy the public key to each target node:

```bash
ssh-copy-id user@target_node_ip
```

Replace `user` with your username on the target node and `target_node_ip` with the target node's IP address.

3. Test SSH access to the target node:

```bash
ssh user@target_node_ip
```
You should be able to log in without being prompted for a password.

### Task 3: Create an Ansible Inventory File

1. Create a directory for your Ansible project and navigate into it:

```bash
mkdir ~/ansible
cd ~/ansible
```

2. Create an inventory file:

```bash
nano inventory.ini
```

3. Add your target nodes to the inventory file:

```ini
[linux_servers]
target1 ansible_host=<target1-ip> ansible_user=<user>
target2 ansible_host=<target2-ip> ansible_user=<user>
```

4. Save and close the file.

### Task 4: Test Ansible Connectivity

1. Test Ansible connectivity to your target nodes:

```bash
ansible -i inventory.ini linux -m ping
```

You should see a "pong" response from each target node.

### Task 5: Run a Basic Ad-Hoc Command
Run a simple command to check the uptime of your target nodes:

```bash
ansible -i inventory.ini linux_servers -m command -a "uptime"
```

You should see the uptime output from each target node.

2. Run a command to check disk space on your target nodes:

```bash
ansible -i inventory.ini linux_servers -m command -a "df -h"
```

You should see the disk space usage output from each target node.

For example you should see output similar to this:

```plaintext

target1 | SUCCESS | rc=0 >>
Filesystem      Size  Used Avail Use% Mounted on
udev            2.0G     0  2.0G   0% /dev
tmpfs           395M  1.3M  394M   1
tmpfs           395M   25M  370M   7% /run
/dev/sda1        20G  8.5G   11G  45% /
tmpfs           2.0G     0  2.0G   0% /dev/shm
tmpfs           5.0M     0  5.0M   0% /run/lock
tmpfs           2.0G     0  2.0G
    0% /sys/fs/cgroup
tmpfs           395M     0  395M   0% /run/user/1000
``` 

## Conclusion

You have successfully set up Ansible on a Linux control node and configured it to manage target nodes. You can now use Ansible to automate various tasks across your infrastructure, improving efficiency and consistency.
