# Introduction to Docker and Containers
## Project Goal

By the end of this mini-project, learners should aim to achieve the following:

1. Grasp the concept of containers, their isolation, and their role in packaging applications.

2. Familarise themselves with key Docker features, commands, and best practices.

3. Comprehend how Docker containers contributes to resource efficiency compared to traditional virtual machinnes.

4. Learn how Docker ensures consitent application behaviour across different development, testing, and production environments.

5. Master the techniques for quickly deploying and scaling applications using Docker.

## What are Containers?

In realm of software development and deployment, professionals used to face a dilemma. They crafted brilliant code on their local machines, only to find that when deployed to other environments, it sometimes does not work. The culprit? The notorious "It works on my machine" phenomenon.

Imagine a container as magical vessels that encapsulates everything an application needs to run smoothly- its code, libaries, dependencies, and even a dash of configuration magic. These containers ensures that an application remains consistent and behaves the same, whether it is running on a developer's laptop, a testing server, or a live production environment. Docker had bestowed upon IT professionals the power to say goodbye to the days of "It works on my machine".

Docker is a tool that emerged to solve a major problem in the IT industry. A man named Solomon Hykes, who in 2013, unveiled Docker, a containerisation platform that promised to revolutionised the way IT professionals built, shippedm and ran applications.

Docker simplifies the deployment process, making it as easy as waving a wand. Gone are the days of wrestling with complex installation procedures and compatibility issues. Docker containers provide a standardised, portable environment, ensuring that your applications run seamlessly across various platforms.

### Advantages of Containers

**Portability Across Different Environment:** In the past, deploying applications was akin to navigating a treacherous maze, with compatibility issues lurking at every turn. Docker's containers, however, encapsulate the entire application along with its dependencies and configuration. This magical package ensures that your creation dances gracefully across different platforms, sparing you from the woes of "It works on my machine" curse. With Docker, bid farewell to the headaches of environment mismatches and embrace a world where your application reighs supreme, irresective of its hosting kingdom.

**Resource Efficiency Compared to Virtual Machines:** Docker containers share the underlying host's operating system kernel, making them lightweight and nimble. This efficiency allows you to run multiple containers on a single host without the extravagant resource demands of traditional virtual machines. Picture Docker container as magical carriages, swiftly transporting your aplications without burdening the kingdom with unnecessary excess. With Docker, revel in the harmony of resource optimisation and application efficiency.

**Rapid Application Deployment and scaling:** Docker containers can be effortlessly spun up or torn down, facilitating the swift deployment of applications. Whether you're facing a sudden surge in demand or orchestrating a grand-scale production, Docker allows you to scale your application seamlessly. Imagine commanding an army of containers to conquer the peaks of user demand, only to gracefully retreat when the storm has passed. With Docker, the ability to scale becomes a wand in your hand, transforming the challenges of deployment into a choreographed ballet of efficiency.

### Comparisoon of Docker Container with Virtual Machines
Docker and virtual machines (VMs) are both technologies used for application deployment, but they differ in their approach to virtualisation. Virtual Machines emulates entire operating systems, resulting in higher resource overhead and slower performance. In contrast, Docker utilses containerisation, encapsulating applications and their dependencies with sharing the host OS's kernel. This lightweight approach reduces resource consumption, provides faster startup times, and ensures portibility across different environments. Docker's emphasis on microservices and standardised packaging foster's scalability and efficiency, making it a preferred choice for modern, agile application development, whereas virtual machines excel in scenarios requiring stronger isolation but at the cost of increased resource usage. The choice between Docker and VMs depends on specific use cases and desired balance between performance and isolation.

### Importance of Docker
**Technology and Industry Impact:** The significance of docker in the technologu landscape cannot be overstated. Docker and contanainerisation have revolusionised software develpment, deployment and management. The ability to package applications and their dependencies into lightweight, portable containers addresses key challenges in software deployment, such as consistency accross different environments and efficient resource utilisation.

**Real-World Impact:** Implementing Docker brings tangible benefits to organisations. It streamlines the development process, promotes collaboration between development and operation teams, and accelerates the delivery of applications, Docker's containerisation technology enhances scalability, facilitates rapid deplyment, and ensures the consistency of applications across diverse environments. This not only saves time and resources but also contributes to a more resilient and agile software development lifecycle.

### Target Audience

This cource on dcoker is designed for a diverse audience, including:
- **DevOps Professionals:** Interested in container orchestration, seeking efficient ways to manage and deploy applications, improve resource utisation and ensure system stability.
- **Developers:** Who want to streamline theri application development, enhance collaboration, and ensure consistency across different stages of the development lifecycle.

It caters to cloud engineers, QA engineers, and other tech enthusiast who are eager to enhance their technical skills and establish a strong foundation in docker and containerisation. Professionals seeking to expand their skill set or students preparing for roles in technology-related fields will find this project beneficial.

## Getting Started With Docker

### Installing Docker
We need to launch an ubuntu 20.04 LTS instance and connect to it, then follow the steps bellow

Before installing Docker Engine for the first time on a new host machine, it is necessary to configure the Docker repository. Following this setup, we can proceed to install and update Docker directly form the repository.

#### Now lets first add docker's official GPG key

You can learn about GPG keys here: 
https://help.ubuntu.com/community/GnuPrivacyGuardHowto

~~~
sudo apt-get update
~~~

This is a Linux command that refreshes the package list on a Debian-based system, ensuring the latest software information is available for installation.

~~~
sudo apt-get install ca-certificates curl gnupg
~~~

This is a Linux command that installs essential packages including certificate authorities, a data transfer tool (curl) and the GNU Privacy Guard for secure communication and package verification.

~~~
sudo install -m 0755 -d /etc/apt/keyrings
~~~

The command above creates a directory (/etc/apt/keyrings) with specific permissions (0755) fot storing keyring files, which are used for docker's authentication.

~~~
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
~~~
This dowloads the Docker GPG key using `curl`.

~~~
sudo chmod a+r /etc/apt/keyrings/docker.gpg
~~~

This comand sets read permission to all users in the Docker GPG key file within the APT keying directory.

#### Lets add the repository to APR sources


~~~
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
  $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
~~~

The "echo" command creates a Docker APT repository configuration entry for Ubuntu system, incorporating the system architecture and Docker GPG key, and then "sudo tee /etc/apt/sources.list.d/docker.list > /dev/null" writes this configuration to the "/etc/apt/sources.list.d/docker.list" file.

~~~
sudo apt-get update
~~~

- Install latest version of docker

~~~
sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
~~~

- Verify that the docker has been successfully installed

~~~
sudo systemctl status docker
~~~




By defoault, after installing docker, it can only be run by root user or using `sudo` command. To run the docker command without sudo execute the command below

~~~
sudo usermod -aG docker ubuntu
~~~

After executing the command above, we can run docker command without using superuser privilledges.

### Running the "Hello World" Container

#### Using the `docker run` command

The `docker run` command is the entry point to execute containers in Docker. It allows you to create and start a container based on a specified Docker image. The most straightforward example is the "Hello World" container, a minimalistic container that prints a greeting message when executed.

- Run the "Hello World" container

~~~
docker run hello-world
~~~

- What Happens When You Execute This Command
Docker performs the following steps:

    Pulls Image (if not available locally) Docker checks if the hello-world image exists locally. If not, it pulls it from Docker Hub.

    Creates a Container Docker creates a container based on the hello-world image. This container has its own isolated filesystem and runtime.

    Starts the Container The container executes the predefined command in the image, printing a friendly message.

#### Understanding Docker Image and Container Lifecycle
**Docker Image**: A lightweight, standalone, executable package that includes everything needed to run software: code, runtime, libraries, and system tools. Images are immutable.

**Container Lifecycle**: Containers are running instances of images. 
-   Lifecycle stages include: create, start, stop, and delete.

- Once a container is created from an image, it can be started, stopped, and restarted.

#### Verifying Execution
To check if the image is now available locally:

~~~
docker images
~~~

If issues arise, ensure Docker is properly installed and your user has permission to run Docker commands.

This simple "Hello World" example serves as a basic introduction to running containers with Docke. It helps verify that your Docker environment is set up correctly and provides insight into the image and container lifecycle. 

### Basic Docker Commands

#### Run a Container
~~~
docker run hello-world
~~~

This pulls the image (if needed) and starts a container.

#### List Running Containers
~~~
docker ps
~~~

To view all containers (including stopped ones):
~~~
docker ps -a
~~~


#### Stop a Container
~~~
docker stop CONTAINER_ID
~~~

Replace CONTAINER_ID with the actual ID of the running container.

#### Pull an Image
~~~
docker pull ubuntu
~~~

Downloads the latest Ubuntu image from Docker Hub.

#### Push an Image
~~~
docker push your-username/image-name
~~~

Make sure you're logged in with docker login before pushing.

#### List Local Images
~~~
docker images
~~~

#### Remove an Image
~~~
docker rmi IMAGE_ID
~~~

Replace IMAGE_ID with the actual image ID.
