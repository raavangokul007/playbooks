resource "aws_instance" "AWSEC2Instance" {
        count  = "3"
        ami   = "ami-0ef50c2b2eb330511"
        instance_type  = "t2.micro"
        security_groups = ["launch-wizard-2"]
        key_name    = "devopskey"
        tags = {
            Name = "EC2 instance created by terraform"
        }

    }