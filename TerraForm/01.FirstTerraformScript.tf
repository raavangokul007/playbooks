    provider "aws" {
        region = "us-east-2"
        access_key = "AKIAXGTKXTP3NKZ3Z5VL"
        secret_key  = "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"
    }

    resource "aws_instance" "AWSEC2Instance" {
        ami   = "ami-0ef50c2b2eb330511"
        instance_type  = "t2.micro"
        security_groups = ["launch-wizard-2"]
        key_name    = "devopskey"
        tags = {
            Name = "EC2 instance created by terraform"
        }

    }
