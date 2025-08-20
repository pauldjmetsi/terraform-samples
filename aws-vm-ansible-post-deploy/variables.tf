variable "region" {
  description = "AWS region to deploy into"
  type        = string
}

variable "access_key" { 
  description = "Access key to AWS console"
  type        = string
}

variable "secret_key" { 
  description = "Secret key to AWS console"
  type        = string
}

variable "ami_id" {
  description = "AMI ID for the instance"
  type        = string
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t3.small"
}

variable "subnet_id" {
  description = "ID of the existing subnet where the instance will be launched"
  type        = string
}

variable "security_group_ids" {
  description = "List of existing security group IDs"
  type        = list(string)
}

variable "key_name" {
  description = "Name of the existing SSH key pair"
  type        = string
}

variable "pem_file" {
  description = "Path to the PEM file for SSH access"
  type        = string
}