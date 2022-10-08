//------------------NOTAS-------------------
//Abrimos puerto 22 en inbound del Security group por defecto de nuestro AWS
//Utilizamos el siguiente comando para agregar keypair existente en nuestro AWS:
//terraform import aws_key_pair.key01 key01
//------------------------------------------

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.16"
    }
    docker = {
      source  = "kreuzwerker/docker"
      version = "2.22.0"
    }
  }
}

provider "aws" {
  region  = "eu-west-1"
}

provider "docker" {
  host = "unix:///var/run/docker.sock"
}


resource "aws_key_pair" "key01" {
  key_name   = "key01"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCgdq7AHKHiDjw8rAnaEVJGVKzRkUV0hg4Nkp3rnMLc0SEkDCRJe9fkL4jghlgHtaHhuBFholHKW2z9JEidFVQBEGLcfHevZL9kUZC3HmxJrARuXZUIVDaithJ5UGEXhYAlRclA7cHkOnpI1tNiyy7jPNfN2JG8r1Fx1mTBhC7sVtTb4di9usNwaD2sIqOJcAseJfn9EQ4/l2CrmX4vdrAD7X3yfBGgUV9c50JdO8rTIN/mYaF7D7k2wtpLEt8W23SNx87VkMvkOjJ6xjdlGmhIxq7oMBnSgW/ZPpZMXlMnfCCitRBn1T4k62BemmPelnBENBMMl+Pppzgei+f28Qtt"
}

//Instance
resource "aws_instance" "app_server" {
  ami           = "ami-0ea0f26a6d50850c5"
  instance_type = "t2.micro"
  count = 1

  associate_public_ip_address = true
  key_name = "key01"

  tags = {
    Name = "ExampleNginxDockerServer"
  }
}

//Nginx resources
resource "docker_image" "nginx" {
  name         = "nginx:latest"
  keep_locally = false
}

resource "docker_container" "nginx" {
  image = docker_image.nginx.image_id
  name  = "tutorial"
  ports {
    internal = 80
    external = 8000
  }
}
