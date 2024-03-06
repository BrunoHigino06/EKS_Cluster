module "eks_cluster" {
  source = "git::https://github.com/BrunoHigino06/AWS_TerraformModules.git?ref=eks"

  eks = [
    for eks in var.eks_cluster : {
        name                    = eks.name
        role_arn                = data.aws_iam_role.iam_role[eks.role_name].arn
        subnet_ids              = [for subnet in data.aws_subnet.subnet : subnet.id]
        endpoint_private_access = eks.endpoint_private_access
        endpoint_public_access  = eks.endpoint_public_access
        security_group_ids      = [for sg in data.aws_security_group.security_group : sg.id]
        authentication_mode     = eks.authentication_mode
        tags                    = var.tags
    }
  ]

  depends_on = [ 
    data.aws_iam_role.iam_role
  ]
}