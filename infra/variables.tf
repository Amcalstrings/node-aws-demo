variable "aws_region" {
  default = "us-east-1"
}

variable "cluster_name" {
  default = "devops-eks"
}

variable "availability_zones" {
  type = list(string)
  description = "List of azs to use for vpc"
  default = ["us-east-1a", "us-east-1b", "us-east-1c"]
}

# variable "tf_state_bucket" {
#   type = string
# }

# variable "tf_state_lock_table" {
#   type = string
# }