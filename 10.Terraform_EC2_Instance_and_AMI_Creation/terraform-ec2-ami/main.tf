provider "aws"{
    region = "us-east-1"
}

resource "aws_instance" "my_ec2_spec" {
    ami = "ami-08982f1c5bf93d976"
    instance_type = "t2.micro"
    tags = {
		Name = "Terraform-created-EC2-Instance"
    }
  
}

resource "aws_ami_from_instance" "my_ec2_spec_ami" {
  name = "my-ec2-ami"
  description = "My AMI Created from my ec2 Instance with Terraform script"
  source_instance_id = aws_instance.my_ec2_spec.id
}
