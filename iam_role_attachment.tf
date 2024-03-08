module "iam_role_policy_attachment" {
   source = "git::https://github.com/BrunoHigino06/AWS_TerraformModules.git?ref=iam_role_attachment"

   iam_role_policy_attachment = [
        for iam_role_policy_attachment in var.iam_role_policy_attachment : {
            role        = iam_role_policy_attachment.role
            policy_arn  = iam_role_policy_attachment.policy_arn
        }
   ]
    depends_on = [ 
        data.aws_iam_role.iam_role
    ]
}