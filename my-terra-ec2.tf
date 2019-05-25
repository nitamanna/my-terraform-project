provider "aws" {
  region     = "${var.region}"
}

module "key-pair" {
  source = "./module/key-pair/"
}

module "sec-grp" {
  source = "./module/sec-grp/"
}

resource "aws_instance" "my-terra-instance" {
  ami           = "${var.instance_ami}"
  instance_type = "${var.instance_type}"
  vpc_security_group_ids = ["${module.sec-grp.vpc_security_group_id}"]
  key_name = "${module.key-pair.key_name_value}"
  tags = {
          Name = "${var.environment_tag}"
       }
}

output "ip" {
	value = ["${aws_instance.my-terra-instance.*.public_ip}"]
}
