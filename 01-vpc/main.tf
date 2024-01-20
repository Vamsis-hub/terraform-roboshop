module "roboshop" {
    # source ="../../terraform-aws-vpc"
    source = "git::https://github.com/Vamsis-hub/terraform-aws-vpc.git?ref=main"
    project_name = var.project_name
    environment_name = var.environment_name
    common_tags =var.common_tags
    vpc_tags = var.vpc_tags

    public_subnets_cidr = var.public_subnets_cidr
    private_subnets_cidr = var.private_subnets_cidr
    database_subnets_cidr = var.database_subnets_cidr
    is_peering_required = var.is_peering_required
    
}
