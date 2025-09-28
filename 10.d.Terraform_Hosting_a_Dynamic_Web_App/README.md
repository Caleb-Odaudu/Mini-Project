# Hosting a Dynamc Web App on AWS with Terraform Module, Docker, ECR, and ECS

In this mini-project, we will use Terraform to create a modular infrastructure for hosting a dynamic web application on Amazon ECS (Elastic Container Service). The project involves containerising the web application using Docker, image to Amazon ECR (Elastic Container Registry), and deploying it on ECS.

## Objectives

1. **Terraform Modules:**

    - Learn how to create and use Terraform modules for modular infrastructure provisioning.

2. **Dockerisation:**

    - Containerise a dynamic web application using Docker.

3. **Amazon ECR Configuration:**

    - Configure Terraform to create an Amazon ECR repository for storing Docker images.

4. **Amazon ECS Deployment:**

    - Use Terraform to provision an ECS cluster and deploy the Dockerised web application.

## Project Task

### Task 1: Dockerise the Web Application

1. Create a dynaminic web application using a technology of your choice (e.g., Node.js, Python Flask, etc.).

2. Write a Dockerfile to containerise the web application.

3. Test the Docker image locally to ensure it works as expected.

### Task 2: Terraform Module for ECR

1. Create a new directory for the Terraform project.

2. Inside the project directory, create a directory for the ECR module.

3. Write a Terraform module for creating an Amazon ECR repository for storing Docker images.

### Task 3: Terraform Module for ECS

1. Inside the project directory, create a directory for the ECS module.

2. Write a Terraform module for creating an ECS cluster and deploying the Dockerised web application.

### Task 4: Main Terraform Configuration

1. Create a main Terraform configuration file in the project directory.

2. Use the ECR and ECS modules to create the necessary infrastructure.

### Task 5: Deploy the Application

1. Build the Docker image and push it to the ECR repository created by Terraform.

2. Run `terraform init`  and `terraform apply` to deploy the ECS cluster and the web application.

3. Verify that the web application is running and accessible.

## Instructions

0. Before starting, ensure you have the following prerequisites:
    - An AWS account with appropriate permissions to create ECS clusters, ECR repositories, and related resources.
    - AWS CLI installed and configured on your local machine.
    - Docker installed on your local machine.
    - Terraform installed on your local machine.

``` bash
aws sts get-caller-identity | more
terraform --version
docker --version
```

1. Create a new directory for your Terraform project using a terminal

```bash
mkdir terraform-ecs-webapp
```

2. Change into the directory.

```bash
cd terraform-ecs-webapp
```
3. Create directories for the ECR amd ECS modules.

```bash
mkdir -p modules/ecs
```

```bash 
mkdir -p modules/ecr
```

4. Write the ECR module configurationn to create an ECR repository

```bash
touch modules/ecr/main.tf
```

```hcl
resource "aws_ecr_repository" "webapp_repo" {
  name                 = var.repository_name
  image_tag_mutability = "MUTABLE"
  tags = {
    Name = var.repository_name
  }
}

variable "repository_name" {
  type = string
}
```
Create the variables file for the ECR module.

```bash
touch modules/ecr/variables.tf
```

```hcl
variable "repository_name" {
  description = "The name of the ECR repository"
  type        = string
}
```
Create an output

```bash
output "repository_url" {
  value = aws_ecr_repository.webapp_repo.repository_url
}
```


5. Write the ECS module configurationn to create an ECS repository

```bash
touch modules/ecs/main.tf
```

```hcl
resource "aws_ecs_task_definition" "webapp_task" {
  family                   = "flask-webapp-task"
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                      = "256"
  memory                   = "512"
  execution_role_arn       = aws_iam_role.ecs_execution_role.arn
  container_definitions    = jsonencode([
    {
      name      = "flask-webapp"
      image     = "<your_ecr_url>:latest"
      portMappings = [{
        containerPort = 5000
        hostPort      = 5000
      }]
    }
  ])
}

resource "aws_ecs_service" "webapp_service" {
  name            = "flask-webapp-service"
  cluster         = aws_ecs_cluster.webapp_cluster.id
  task_definition = aws_ecs_task_definition.webapp_task.arn
  desired_count   = 1
  launch_type     = "FARGATE"
  network_configuration {
    subnets         = var.subnet_ids
    security_groups = [var.security_group_id]
    assign_public_ip = true
  }
}

resource "aws_iam_role" "ecs_execution_role" {
  name = "ecsTaskExecutionRole"
  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [{
      Effect = "Allow",
      Principal = {
        Service = "ecs-tasks.amazonaws.com"
      },
      Action = "sts:AssumeRole"
    }]
  })
}

resource "aws_iam_role_policy_attachment" "ecs_execution_policy" {
  role       = aws_iam_role.ecs_execution_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
}

resource "aws_ecs_cluster" "webapp_cluster" {
  name = var.cluster_name
}
```

Create the variables file for the ECS module.

```bash
touch modules/ecs/variables.tf
```

```hcl
variable "cluster_name" {
  description = "The name of the ECS cluster"
  type        = string
}

variable "subnet_ids" {
  type        = list(string)
  description = "List of subnet IDs for ECS tasks"
}

variable "security_group_id" {
  type        = string
  description = "Security group ID for ECS tasks"
}

variable "ecr_repository_url" {
  description = "URL of the ECR repository"
  type        = string
}
```

6. Create the main Terraform file and use the ECR and ECS modules.

```bash
touch main.tf
```
```hcl
module "ecr" {
    source = "./modules/ecr" 
    repository_name = "your-web-app-repo"
}

module "ecs" {
  source             = "./modules/ecs"
  cluster_name       = "flask-webapp-cluster"
  ecr_repository_url = module.ecr.repository_url
  security_group_id  = "sg-07b1a16aad2d69199"
}

```

7. Build the Docker image and push it to the ECR repository created by Terraform.

```bash

aws ecr get-login-password --region us-east-1 | docker login --username AWS --password-stdin <your_account_id>.dkr.ecr.us-east-1.amazonaws.com

docker build -t flask-webapp .

docker tag flask-webapp:latest <your_account_id>.dkr.ecr.us-east-1.amazonaws.com/flask-webapp-repo:latest

docker push <your_account_id>.dkr.ecr.us-east-1.amazonaws.com/flask-webapp-repo:latest
```

8. Initialize and apply the Terraform configuration to deploy the ECS cluster and the web application.

```bash
terraform init

terraform validate

terraform apply
```

9. Destroy Terraform

```bash

terraform destroy

```


