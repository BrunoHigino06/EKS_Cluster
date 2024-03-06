locals {
    subnet_unique_names   = flatten([for eks in var.eks_cluster : eks.subnet_name])
    iam_role_names        = flatten([for eks in var.eks_cluster : eks.role_name])
    security_group_names  = flatten([for eks in var.eks_cluster : eks.security_group_name]) 
  }

# Data aws vpc
  data "aws_vpc" "vpc" {
    filter {
      name = "tag:Name"
      values = [var.vpc.name]
    }

    depends_on = [ 
      module.vpc
    ]
  }

# Data iam policy document
  data "aws_iam_policy_document" "eks_assume_role_policy" {
    statement {
      actions = ["sts:AssumeRole"]

      principals {
        type        = "Service"
        identifiers = ["eks.amazonaws.com"]
      }
    }
  }

# Data subnets
  data "aws_subnet" "subnet" {
  for_each = { for subnet in local.subnet_unique_names : subnet => subnet }

  filter {
    name = "tag:unique_name"
    values = [each.key]
  }
  
  depends_on = [ 
    module.subnet
  ]
}

# Data IAM role
  data "aws_iam_role" "iam_role" {
    for_each  = {for role in local.iam_role_names : role => role}
    name      = each.key

    depends_on = [ 
      module.iam_role
    ]
  }

# Data Security group
  data "aws_security_group" "security_group" {
    for_each = { for security_group in local.security_group_names : security_group => security_group }

    filter {
      name = "tag:Name"
      values = [each.key]
    }

    depends_on = [ 
      module.security_group
    ]
  }