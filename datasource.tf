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
