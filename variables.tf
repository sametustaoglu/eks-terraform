#
# Variables Configuration
#

variable "aws_region" {
  description = "The AWS region to create things in."
  default     = "us-east-1" #todo fatma
}

variable "bucket_name" {
  description = "The Bucket name for S3 backend."
  default     = "terraform-state-samet" #todo fatma
}

variable "vpc-network" {
  description = "vpc cidr network portion; eg 10.0 for 10.0.0.0/16."
  default     = "10.0"  #you can change
  type        = string
}

variable "cluster-name" {
  description = "EKS cluster name."
  default     = "samet-eks"  #todo fatma
  type        = string
}

variable "k8s_version" {
  description = "Kubernetes version."
  default     = "1.23" #todo fatma
  type        = string
}

variable "cloudwatch" {
  type    = bool 
  default = true #todo fatma
  description = "Install Cloudwatch logging, metrics and Container Insights."
}

variable "inst-type" {
  description = "EKS worker instance type."
  default     = [ "t3.medium", "t3.small", "t3.large", "t2.micro" ] #todo fatma
  type        = list
}

variable "inst_disk_size" {
  description = "EKS worker instance disk size in Gb."
  default     = "20" #todo fatma
  type        = string
}

variable "inst_key_pair" {
  description = "EKS worker instance ssh key pair."
  default     = "key-mac" #todo fatma
  type        = string
}

variable "num-workers" {
  description = "Number of eks worker instances to deploy."
  default = "1" #todo fatma
  type    = string
}

variable "max-workers" {
  description = "Max number of eks worker instances that can be scaled."
  default = "2" #todo fatma
  type    = string
}

variable "ca" {
  type    = bool 
  default = false #todo fatma
  description = "Install k8s Cluster Autoscaler."
}



