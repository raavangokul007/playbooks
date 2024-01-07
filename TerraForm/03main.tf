resource "aws_instance" "AWSEC2Instance" {
        count  = "${var.NumberOfInstance}"
        ami   = "${var.AMI}"
        instance_type  = "${var.instance_type}"
        security_groups = ["launch-wizard-2"]
        key_name    = "devopskey"
        tags = {
            Name = "EC2 instance created by terraform - ${count.index}"
        }

    }