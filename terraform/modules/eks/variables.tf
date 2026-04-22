variable "cluster_name" {}
variable "vpc_id" {}
variable "subnet_ids" { type = list(string) }
variable "eks_version" { default = "1.28"}