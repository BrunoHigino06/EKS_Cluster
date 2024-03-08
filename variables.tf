# Global vars
  variable "tags" {
    type = map(string)
    description = "Tags for global use"
  }

# VPC Vars
  variable "vpc" {
    type          = object({
      name        = string
      cidr_block  = string
    })
    description = "VPC variables"
  }

# subnet vars
  variable "subnet" {
    type                                             = list(object({
      name                                           = string
      vpc_name                                       = optional(string)
      cidr_block                                     = optional(string)
      availability_zone                              = optional(string)
      }))
      description = "subnet variables"
      default = null
  }

# security group vars
  variable "security_group" {
    type                     = list(object({
      name                   = optional(string)
      description            = optional(string)
      egress                 = list(object({
        from_port            = string 
        to_port              = string
        protocol             = string
        cidr_blocks          = optional(list(string))
        description          = optional(string)
      }))
      ingress       = list(object({
        from_port            = string 
        to_port              = string
        protocol             = string
        cidr_blocks          = optional(list(string))
        description          = optional(string)
      }))
    }))
    description = "security groups"
  }

# IAM role vars
  variable "iam_role" {
  type                      = list(object({
    name                    = string
    description             = optional(string)
  }))
  description = "IAM role for the cluster"
}

# IAM role attachment vars
  variable "iam_role_policy_attachment" {
  type          = list(object({
    role        = string
    policy_arn  = string
  }))
}

# EKS Cluster vars
variable "eks_cluster" {
    type                                              = list(object({
          name                                        = string
          role_name                                   = string
          subnet_name                                 = list(string)
          endpoint_private_access                     = optional(string)
          endpoint_public_access                      = optional(string)
          security_group_name                         = optional(list(string))
          authentication_mode                         = optional(string)
        }
      )
    )
    description = "eks cluster variables"
}

# EKS node group vars
variable "eks_node_group" {
  type = list(object({
    cluster_name                = string
    node_group_name             = string
    node_role_name              = string
    subnet_ids                  = list(string)
    instance_types              = string
    desired_size                = string
    max_size                    = string
    min_size                    = string
  }))
}