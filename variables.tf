# variables.tf
variable "aws_region" {
  description = "AWS region"
  type        = string
  default     = "eu-west-1"
}

variable "instance_name" {
  description = "EC2 instance name"
  type        = string
  default     = "devops-foundations"
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t3.xlarge"
}

variable "instance_type2" {
  description = "EC2 instance type"
  type        = string
  default     = "t3.micro"
}