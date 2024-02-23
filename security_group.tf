module "security_group" {
  source = "git::https://github.com/BrunoHigino06/AWS_TerraformModules.git?ref=security_group"

  security_group = [
    for security_group in var.security_group : {
        name        = security_group.name
        vpc_id      = data.aws_vpc.vpc.id
        tags        = var.tags
        description = security_group.description
        
        egress = [
            for egress in security_group.egress : {
                from_port   = egress.from_port
                to_port     = egress.to_port
                protocol    = egress.protocol
                cidr_blocks = egress.cidr_blocks
            }
        ]

        ingress = [
            for ingress in security_group.ingress : {
                from_port   = ingress.from_port
                to_port     = ingress.to_port
                protocol    = ingress.protocol
                cidr_blocks = ingress.cidr_blocks
            }
        ]
    }
  ]

  depends_on = [ 
        module.vpc,
        data.aws_vpc.vpc
    ]
}