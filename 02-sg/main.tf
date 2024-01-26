
#created security group for VPN
module "vpn" {
 source = "../../terraform-security-groups"
 sg_name = "vpn"
 sg_description = "SG for vpn"
 project_name = var.project_name
 environment = var.environment
 vpc_id = data.aws_vpc.default.id
}





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

#open VPN
resource "aws_security_group_rule" "vpn_home" {
    security_group_id = module.vpn.sg_id
    type = "ingress"
    from_port = 0
    to_port = 65535
    protocol = "-1"
  cidr_blocks = ["0.0.0.0/0"]

}





#mongodb should allow connections from Vpn
resource "aws_security_group_rule" "mongodb_vpn" {
    source_security_group_id = module.vpn.sg_id
    type = "ingress"
    from_port = 22
    to_port = 22
    protocol = "tcp"
  security_group_id = module.mongodb.sg_id

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

#redis also allowing connection from VPN

resource "aws_security_group_rule" "redis_vpn" {
  source_security_group_id = module.vpn.sg_id
  type                     = "ingress"
  from_port                = 22
  to_port                  = 22
  protocol                 = "tcp"
  security_group_id        = module.redis.sg_id
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

#copied from daws76

resource "aws_security_group_rule" "mysql_vpn" {
  source_security_group_id = module.vpn.sg_id
  type                     = "ingress"
  from_port                = 22
  to_port                  = 22
  protocol                 = "tcp"
  security_group_id        = module.mysql.sg_id
}

resource "aws_security_group_rule" "mysql_shipping" {
  source_security_group_id = module.shipping.sg_id
  type                     = "ingress"
  from_port                = 3306
  to_port                  = 3306
  protocol                 = "tcp"
  security_group_id        = module.mysql.sg_id
}


resource "aws_security_group_rule" "rabbitmq_vpn" {
  source_security_group_id = module.vpn.sg_id
  type                     = "ingress"
  from_port                = 22
  to_port                  = 22
  protocol                 = "tcp"
  security_group_id        = module.rabbitmq.sg_id
}

resource "aws_security_group_rule" "rabbitmq_payment" {
  source_security_group_id = module.payment.sg_id
  type                     = "ingress"
  from_port                = 5672
  to_port                  = 5672
  protocol                 = "tcp"
  security_group_id        = module.rabbitmq.sg_id
}

resource "aws_security_group_rule" "catalogue_vpn" {
  source_security_group_id = module.vpn.sg_id
  type                     = "ingress"
  from_port                = 22
  to_port                  = 22
  protocol                 = "tcp"
  security_group_id        = module.catalogue.sg_id
}

resource "aws_security_group_rule" "catalogue_web" {
  source_security_group_id = module.web.sg_id
  type                     = "ingress"
  from_port                = 8080
  to_port                  = 8080
  protocol                 = "tcp"
  security_group_id        = module.catalogue.sg_id
}

resource "aws_security_group_rule" "catalogue_cart" {
  source_security_group_id = module.cart.sg_id
  type                     = "ingress"
  from_port                = 8080
  to_port                  = 8080
  protocol                 = "tcp"
  security_group_id        = module.catalogue.sg_id
}

resource "aws_security_group_rule" "user_vpn" {
  source_security_group_id = module.vpn.sg_id
  type                     = "ingress"
  from_port                = 22
  to_port                  = 22
  protocol                 = "tcp"
  security_group_id        = module.user.sg_id
}

resource "aws_security_group_rule" "user_web" {
  source_security_group_id = module.web.sg_id
  type                     = "ingress"
  from_port                = 8080
  to_port                  = 8080
  protocol                 = "tcp"
  security_group_id        = module.user.sg_id
}

resource "aws_security_group_rule" "user_payment" {
  source_security_group_id = module.payment.sg_id
  type                     = "ingress"
  from_port                = 8080
  to_port                  = 8080
  protocol                 = "tcp"
  security_group_id        = module.user.sg_id
}

resource "aws_security_group_rule" "cart_vpn" {
  source_security_group_id = module.vpn.sg_id
  type                     = "ingress"
  from_port                = 22
  to_port                  = 22
  protocol                 = "tcp"
  security_group_id        = module.cart.sg_id
}

resource "aws_security_group_rule" "cart_web" {
  source_security_group_id = module.web.sg_id
  type                     = "ingress"
  from_port                = 8080
  to_port                  = 8080
  protocol                 = "tcp"
  security_group_id        = module.cart.sg_id
}

resource "aws_security_group_rule" "cart_shipping" {
  source_security_group_id = module.shipping.sg_id
  type                     = "ingress"
  from_port                = 8080
  to_port                  = 8080
  protocol                 = "tcp"
  security_group_id        = module.cart.sg_id
}

resource "aws_security_group_rule" "cart_payment" {
  source_security_group_id = module.payment.sg_id
  type                     = "ingress"
  from_port                = 8080
  to_port                  = 8080
  protocol                 = "tcp"
  security_group_id        = module.cart.sg_id
}

resource "aws_security_group_rule" "shipping_vpn" {
  source_security_group_id = module.vpn.sg_id
  type                     = "ingress"
  from_port                = 22
  to_port                  = 22
  protocol                 = "tcp"
  security_group_id        = module.shipping.sg_id
}

resource "aws_security_group_rule" "shipping_web" {
  source_security_group_id = module.web.sg_id
  type                     = "ingress"
  from_port                = 8080
  to_port                  = 8080
  protocol                 = "tcp"
  security_group_id        = module.shipping.sg_id
}

resource "aws_security_group_rule" "payment_vpn" {
  source_security_group_id = module.vpn.sg_id
  type                     = "ingress"
  from_port                = 22
  to_port                  = 22
  protocol                 = "tcp"
  security_group_id        = module.payment.sg_id
}

resource "aws_security_group_rule" "payment_web" {
  source_security_group_id = module.web.sg_id
  type                     = "ingress"
  from_port                = 8080
  to_port                  = 8080
  protocol                 = "tcp"
  security_group_id        = module.payment.sg_id
}

resource "aws_security_group_rule" "web_vpn" {
  source_security_group_id = module.vpn.sg_id
  type                     = "ingress"
  from_port                = 22
  to_port                  = 22
  protocol                 = "tcp"
  security_group_id        = module.web.sg_id
}

resource "aws_security_group_rule" "web_internet" {
  cidr_blocks = ["0.0.0.0/0"]
  type                     = "ingress"
  from_port                = 80
  to_port                  = 80
  protocol                 = "tcp"
  security_group_id        = module.web.sg_id
}