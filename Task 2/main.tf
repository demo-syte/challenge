
module "vpc" {

  source          = "terraform-aws-modules/vpc/aws"
  name            = var.vpc_name
  cidr            = var.vpc-cidr
  azs             = [var.zone1, var.zone2, var.zone3]
  private_subnets = [var.privatesubnet1, var.privatesubnet2, var.privatesubnet3]
  public_subnets  = [var.publicsubnet1, var.publicsubnet2, var.publicsubnet3]

  enable_nat_gateway   = true
  single_nat_gateway   = true
  enable_dns_hostnames = true
  enable_dns_support   = true


  tags = {
    Terraform  = "true"
    Enviroment = "Dev"
  }


  vpc_tags = {
    Name = var.vpc_name
  }
}



#Instance Creation 
# I Assume that we have already generated the SSH keys using 'ssh-keygen -t rsa -b 2048'


resource "aws_instance" "blogApp" {

  ami                    = var.AMIS[var.REGION]
  instance_type          = "t2.micro"
  key_name               = aws_key_pair.dovekey.key_name
  availability_zone      = var.zone1
  vpc_security_group_ids = [aws_security_group.BlogApp.id]
  
  tags = {
    "Name"  = "dove-blogapp"
     Project = "Dove"
  }


# Uncomment this section if wants to use a script to launch the application

#   provisioner "file" {
#     source      = "script.sh"
#     destination = "/tmp/script.sh"

#   }

  

#   provisioner "remote-exec" {

#     inline = [
#       "chmod u+x /tmp/script.sh",
#       "sudo /tmp/script.sh"

#     ]

#   }


# As we intent to use dockerize applciation we using script to run inside the instance once its created.

 provisioner "file" {
    source      = "blogApp" #copy blogApp directory to ec2 instance
    destination = "/home/unbuntu/blogApp"

  }

  provisioner "file" {
    source      = "Dockerfile" #copy blogApp directory to ec2 instance
    destination = "/tmp/Dockerfile"

  }

  provisioner "remote-exec" {
    inline = [
      "sudo apt-get update",
      "sudo apt-get install -y docker.io",
      "cd /home/ubuntu/blogApp",
      "sudo docker build -t blogApp -f /tmp/Dockerfile",
      "sudo docker run -d -p 3000:3000 blogApp && sleep 5 && curl http://localhost:3000/"
    ]
  }

  
  connection {

    user        = var.USER
    private_key = file("key")
    host        = self.public_ip
  }

}

