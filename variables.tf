variable "aws_region" {
  description = "AWS region to launch servers"
  default     = "us-west-2"
}

variable "ct_loggroup_name" {
  default = "CloudTrail/DefaultLogGroup"
}

variable "sns_email" {
  default = "ops-email"
}

