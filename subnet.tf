module "subnet" {
  source = "git::https://github.com/BrunoHigino06/AWS_TerraformModules.git?ref=subnet"

  subnet = [
    for subnet in var.subnet : {
        name              = subnet.name
        unique_name       = subnet.name
        vpc_id            = data.aws_vpc.vpc.id
        cidr_block        = subnet.cidr_block
        availability_zone = subnet.availability_zone
        tags              = var.tags
    }
  ]
  depends_on = [
    module.vpc, 
    data.aws_vpc.vpc
 ]
}