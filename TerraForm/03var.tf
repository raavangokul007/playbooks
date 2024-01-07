variable "AMI"{
    description = "This Variable having the AMI value"
    default = "ami-0ef50c2b2eb330511"
    }

variable "instance_type"{
    description = "This Variable having the Instance type value"
    default = "t2.micro"
}

variable "NumberOfInstance"{
    description = "This Variable having the count value"
    default = "3"
}