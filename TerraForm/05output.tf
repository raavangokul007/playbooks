output "awsec2instancePublicIP"{
    description = "The public IP address of EC2 instances"
    value = "${aws_instance.AWSEC2Instance.public_ip}"
}

output "awsec2instancePrivateIP"{
    description = "The private IP address of EC2 instances"
    value = "${aws_instance.AWSEC2Instance.private_ip}"
}

output "awsec2instanceID"{
    description = "The ID of EC2 instances"
    value = "${aws_instance.AWSEC2Instance.id}"
}

output "awsec2instanceSubnet{
    description = "The subnet of EC2 instances"
    value = "${aws_instance.AWSEC2Instance.subnet_id}"
}