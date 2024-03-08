module "node_group" {
  source = "git::https://github.com/BrunoHigino06/AWS_TerraformModules.git?ref=node_group"

  eks_node_group = [
    for node_group in var.eks_node_group : {
        cluster_name    = node_group.cluster_name
        node_group_name = node_group.node_group_name
        node_role_arn   = data.aws_iam_role.iam_role[node_group.node_role_name].arn
        subnet_ids      = [for subnet in data.aws_subnet.subnet : subnet.id]
        instance_types  = node_group.instance_types
        desired_size    = node_group.desired_size
        max_size        = node_group.max_size
        min_size        = node_group.min_size
        tags            = var.tags
    }
  ]
}