variable "environment" {
  description = "Development Environment"
  default     = "development"
}

variable "region" {
  description = "AWS region"
  default     = "us-east-1"
}

variable "availability_zone-1" {
  description = "Availability zone"
  default     = "us-east-1a"
}

variable "availability_zone-2" {
  description = "Availability zone"
  default     = "us-east-1b"
}

variable "application" {
  default     = "fractional"
  description = "Application name"
}

## Replace with your own IP

variable "cluster_allowed_ips" {
  default = ["0.0.0.0/0"]
}


