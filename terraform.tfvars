# Global inputs
  tags = {
    Owner = "cloud_admin"
  }

# VPC inputs
  vpc             = {
    name          = "EKS_VPC"
    cidr_block    = "10.0.0.0/16"
  }

# Subnet inputs
  subnet = [ 
    {
      name              = "EKS_1"
      cidr_block        = "10.0.0.0/24"
      availability_zone = "us-east-1a"
    },
    {
      name              = "EKS_2"
      cidr_block        = "10.0.10.0/24"
      availability_zone = "us-east-1b"
    }
  ]

# Security group inputs
  security_group = [ 
    {
      name = "EKS_SG"
      description = "Security group for the EKS resources"

      egress = [ 
        {
          from_port = "0"
          to_port   = "0"
          protocol  = "-1"
          cidr_blocks = ["0.0.0.0/0"]
        } 
      ]

      ingress = [ 
        {
          from_port = "0"
          to_port   = "0"
          protocol  = "-1"
          cidr_blocks = ["0.0.0.0/0"]
        } 
      ]
    } 
  ]

# IAM role inputs
  iam_role = [ 
    {
      name        = "eks_cluster_role"
      description = "role used by the eks cluster"
    },
    {
      name        = "eks_node_role"
      description = "role used by the eks node"
    }
  ]

# IAM role policy attachments
  iam_role_policy_attachment =[
    {
      role        = "eks_cluster_role"
      policy_arn  = "arn:aws:iam::aws:policy/AdministratorAccess"
    },
    {
      role        = "eks_node_role"
      policy_arn  = "arn:aws:iam::aws:policy/AdministratorAccess"
    },
  ]

# EKS Cluster inputs
  eks_cluster = [ 
    {
      name                    = "EKS_Cluster"
      role_name               = "eks_cluster_role"
      subnet_name             = ["EKS_1", "EKS_2"]
      endpoint_private_access = "true"
      endpoint_public_access  = "true"
      security_group_name     = ["EKS_SG"]
      authentication_mode     = "API_AND_CONFIG_MAP"
    } 
  ]

# EKS Node Group
  eks_node_group = [
    {
      cluster_name = "EKS_Cluster"
      node_group_name = "EKS_Node_Group"
      instance_types = "t2.medium"
      desired_size = "1"
      max_size = "2"
      min_size = "1"
    }
  ]