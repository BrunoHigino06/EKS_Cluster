module "iam_role" {
  source = "git::https://github.com/BrunoHigino06/AWS_TerraformModules.git?ref=iam_role"

  iam_role = [
    for role in var.iam_role : {
        name                = role.name
        description         = role.description
        assume_role_policy  = data.aws_iam_policy_document.eks_assume_role_policy.json
        tags                = var.tags
    }
  ]

  depends_on = [ 
    data.aws_iam_policy_document.eks_assume_role_policy
  ]
}