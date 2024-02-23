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
    } 
  ]
