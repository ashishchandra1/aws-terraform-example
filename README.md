Problem Statement:
===
You are provided with credentials to an AWS account. Please use your preferred provisioning tool to complete the following subtasks
   * create a new VPC with CIDR 172.16.0.0.0
   * create two new subnets with CIDR 172.16.1.0/24 and 172.16.2.0/24 in two different AZs
   * Create 5 new ec2 instances based on Ubuntu 18.04 (bionic)
   * Deploy the following Java application on these instances https://s3.eu-central-1.amazonaws.com/demo-bucket/demo-0.0.1-SNAPSHOT.jar
   * Create a load balancer for the java application on port 80


How to Run:
  * Create a new AWS profile with name "where_magic_happens" (Specified in provider.tf)
  * Create a new public/private key combination and update the public key here
	==> where_magic_happens.pub
  * `terraform plan` and `terraform apply`

Solutions Applied: 
====
IAAC Tool: Terraform


* Creates a VPC in Frankfurt region(eu-central-1)
* Creates two subnet, one public and another private in 1a and 1b availability zone
     * Internet gateway is created which is conected to public subnet
     * NAT gateway is created which has EIP assigned in Public subnet and is connected to private subnet
     * Routetables are updated as per convention
* Creates a role, with attached policy  which specified access to  bucket(nvplayground) in S3. This is used to to copy demo-0.0.1-SNAPSHOT.jar into the instance
* Creates a Security group, with port 8080 reachable only in the VPC, port 80/22 access to everywhere
* Creates a launch configuration with Ubuntu 18 as AMI, with keypair, security group and specified role above
* Creates an Autoscaling group (max:6 min:3 and desired:5) instances. Launch configuration is attached to ASG
* Creates and ELB which is connected to ASG with same SG, listening on port 8080 to the instances and 80 outside
