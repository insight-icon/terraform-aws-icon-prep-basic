data "aws_region" "this" {}

module "user_data" {
  source = "github.com/insight-infrastructure/terraform-aws-icon-user-data"

  type = var.node_type
  ssh_user = var.ssh_user
  prometheus_enabled = var.prometheus_enabled
  consul_enabled = var.consul_enabled
}


resource "random_pet" "this" {}

//data "aws_vpc" "default" {
//  default = true
//}
//
//module "vpc" {
//  source = "terraform-aws-modules/vpc/aws"
//
//  create_vpc = var.subnet_id == "" ? true : false
//
//  name = "prep-vpc-${random_pet.this.id}"
//  cidr = "10.0.0.0/16"
//
//  azs             = ["${data.aws_region.this.id}a"]
//  private_subnets = ["10.0.0.0/24"]
//  public_subnets  = ["10.0.101.0/24"]
//
//  enable_nat_gateway = false
//  enable_vpn_gateway = false
//
//  tags = {
//    Terraform = "true"
//    Environment = "dev"
//    NetworkName = "icon"
//  }
//}
//
//module "security_group" {
//  source = "terraform-aws-modules/security-group/aws"
//  version = "~> 3.0"
//
//  create = var.security_groups == [] ? true : false
//
//  name = "prep-${random_pet.this.id}"
//  description = "All traffic"
//  vpc_id = data.aws_vpc.default.id
//
//  ingress_with_cidr_blocks = [{
//    from_port = 7100
//    to_port = 7100
//    protocol = "tcp"
//    description = "grpc traffic for when node starts producing blocks"
//    cidr_blocks = "0.0.0.0/0"
//  },{
//    from_port = 9000
//    to_port = 9000
//    protocol = "tcp"
//    description = "json rpc traffic"
//    cidr_blocks = "0.0.0.0/0"
//  },{
//    from_port = 22
//    to_port = 22
//    protocol = "tcp"
//    description = "ssh traffic"
//    cidr_blocks = var.corporate_ip == "" ? "0.0.0.0/0" : var.corporate_ip
//  }]
//}

module "ec2" {
  source = "github.com/insight-infrastructure/terraform-aws-ec2-basic.git?ref=conditional-create"

  name = var.name

  monitoring = var.monitoring
  create_eip = var.create_eip

  ebs_volume_size = var.ebs_volume_size
  root_volume_size = var.root_volume_size

  instance_type = var.instance_type
  volume_path = var.volume_path

  subnet_id = var.subnet_id
  user_data = var.user_data

  local_public_key = var.public_key_path
  vpc_security_group_ids = var.vpc_security_group_ids

  ingress_with_cidr_blocks = [{
    from_port = 7100
    to_port = 7100
    protocol = "tcp"
    description = "grpc traffic for when node starts producing blocks"
    cidr_blocks = "0.0.0.0/0"
  },{
    from_port = 9000
    to_port = 9000
    protocol = "tcp"
    description = "json rpc traffic"
    cidr_blocks = "0.0.0.0/0"
  },{
    from_port = 22
    to_port = 22
    protocol = "tcp"
    description = "ssh traffic"
    cidr_blocks = var.corporate_ip == "" ? "0.0.0.0/0" : var.corporate_ip
  }]

  tags = var.tags
}

module "ansible_configuration" {
  source = "github.com/insight-infrastructure/terraform-aws-ansible-playbook"

  ip = module.ec2.public_ip

  private_key_path = var.private_key_path

  user = var.ssh_user

  playbook_file_path = var.playbook_file_path
  roles_dir = var.roles_dir

  playbook_vars = {
    "public_ip": module.ec2.public_ip
    "keystore_path" : var.keystore_path
    "keystore_password": var.keystore_password
    "network_name": var.network_name
    "main_ip": var.main_ip
    "instance_id": module.ec2.instance_id
  }
}

resource "null_resource" "dependency_hack" {
  triggers = {
    apply_time = timestamp()
  }

  provisioner "local-exec" {
    command = <<-EOT
echo ${module.ansible_configuration.status}
EOT
  }
}

resource "aws_eip_association" "main" {
  instance_id = module.ec2.instance_id
  allocation_id = var.eip_id

  depends_on = [null_resource.dependency_hack]
}

resource "null_resource" "start_app" {
  triggers = {
    apply_time = timestamp()
  }

  provisioner "local-exec" {
    command = <<-EOT
ssh -i ${var.private_key_path} ${var.ssh_user}@${var.main_ip} docker-compose -f /home/${var.ssh_user}/docker-compose.yml up -d
echo ${module.ansible_configuration.status}
EOT
  }
  depends_on = [aws_eip_association.main]
}



