module "vpc" {
  source = "git::https://github.com/BrunoHigino06/AWS_TerraformModules.git?ref=vpc"

  vpc = merge(var.vpc,
    {tags = var.tags}
  )
}