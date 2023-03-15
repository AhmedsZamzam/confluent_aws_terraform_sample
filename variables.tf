variable "confluent_cloud_api_key" {
  description = "Confluent Cloud API Key (also referred as Cloud API ID)."
  type        = string
}

variable "confluent_cloud_api_secret" {
  description = "Confluent Cloud API Secret."
  type        = string
  sensitive   = true
}

variable "region" {
  description = "The region of Confluent Cloud Network."
  type        = string
}

variable "cidr" {
  description = "The CIDR of Confluent Cloud Network."
  type        = string
}

variable "aws_account_id" {
  description = "The AWS Account ID of the peer VPC owner (12 digits)."
  type        = string
}

variable "customer_region" {
  description = "The region of the AWS peer VPC."
  type        = string
}

variable "mongodb_endpoint" {
  description = "MongoDB URL"
  type        = string
}

variable "mongodb_username" {
  description = "MongoDb username"
  type        = string
}

variable "mongodb_password" {
  description = "MongoDb password"
  type        = string
}

variable "mongodb_name" {
  description = "MongoDb Database name"
  type        = string
}

variable "mongodb_collection_name" {
  description = "MongoDb Collection name"
  type        = string
}
