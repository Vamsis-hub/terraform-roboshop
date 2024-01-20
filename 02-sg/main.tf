module "mongodb" {
 source = "../../terraform-security-groups"
 sg_name = "mongodb"
 sg_description = "SG for mongodb"
 project_name = var.project_name
 environment = var.environment
 vpc_id = data.aws_ssm_parameter.vpc_id.value
}


module "catalogue" {
 source = "../../terraform-security-groups"
 sg_name = "catalogue"
 sg_description = "SG for catalogue"
 project_name = var.project_name
 environment = var.environment
 vpc_id = data.aws_ssm_parameter.vpc_id.value
}

module "user" {
 source = "../../terraform-security-groups"
 sg_name = "user"
 sg_description = "SG for user"
 project_name = var.project_name
 environment = var.environment
 vpc_id = data.aws_ssm_parameter.vpc_id.value
}

module "cart" {
 source = "../../terraform-security-groups"
 sg_name = "cart"
 sg_description = "SG for cart"
 project_name = var.project_name
 environment = var.environment
 vpc_id = data.aws_ssm_parameter.vpc_id.value
}

module "redis" {
 source = "../../terraform-security-groups"
 sg_name = "redis"
 sg_description = "SG for redis"
 project_name = var.project_name
 environment = var.environment
 vpc_id = data.aws_ssm_parameter.vpc_id.value
}

module "mysql" {
 source = "../../terraform-security-groups"
 sg_name = "mysql"
 sg_description = "SG for mysql"
 project_name = var.project_name
 environment = var.environment
 vpc_id = data.aws_ssm_parameter.vpc_id.value
}

module "rabbitmq" {
 source = "../../terraform-security-groups"
 sg_name = "rabbitmq"
 sg_description = "SG for rabbitmq"
 project_name = var.project_name
 environment = var.environment
 vpc_id = data.aws_ssm_parameter.vpc_id.value
}

module "shipping" {
 source = "../../terraform-security-groups"
 sg_name = "shipping"
 sg_description = "SG for shipping"
 project_name = var.project_name
 environment = var.environment
 vpc_id = data.aws_ssm_parameter.vpc_id.value
}

module "payment" {
 source = "../../terraform-security-groups"
 sg_name = "payment"
 sg_description = "SG for payment"
 project_name = var.project_name
 environment = var.environment
 vpc_id = data.aws_ssm_parameter.vpc_id.value
}

module "web" {
 source = "../../terraform-security-groups"
 sg_name = "web"
 sg_description = "SG for web"
 project_name = var.project_name
 environment = var.environment
 vpc_id = data.aws_ssm_parameter.vpc_id.value
}





resource "aws_security_group_rule" "mongodb_catalogue" {
    source_security_group_id = module.catalogue.sg_id
    type = "ingress"
    from_port = 27017
    to_port = 27017
    protocol = "tcp"
  security_group_id = module.mongodb.sg_id

}

resource "aws_security_group_rule" "mongodb_user" {
   source_security_group_id = module.user.sg_id
   type = "ingress"
    from_port = 27017
    to_port = 27017
    protocol = "tcp"
    security_group_id = module.mongodb.sg_id

}


resource "aws_security_group_rule" "redis_user" {
   source_security_group_id = module.user.sg_id
   type = "ingress"
    from_port = 6379
    to_port = 6379
    protocol = "tcp"
    security_group_id = module.redis.sg_id

}

resource "aws_security_group_rule" "redis_cart" {
   source_security_group_id = module.cart.sg_id
   type = "ingress"
    from_port = 6379
    to_port = 6379
    protocol = "tcp"
    security_group_id = module.redis.sg_id

}