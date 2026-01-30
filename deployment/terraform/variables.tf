# -----------------------------------------------------------------------------
# Input Variables
# -----------------------------------------------------------------------------
# These variables allow customization of the infrastructure deployment.
# Override values in terraform.tfvars or via CLI.
# -----------------------------------------------------------------------------

# General
variable "project_name" {
  description = "Name of the project"
  type        = string
  default     = "game-recommender"
}

variable "environment" {
  description = "Deployment environment (dev, staging, prod)"
  type        = string
  default     = "dev"
}

variable "aws_region" {
  description = "AWS region to deploy resources"
  type        = string
  default     = "us-east-1"
}

# Networking
variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "public_subnet_cidrs" {
  description = "CIDR blocks for public subnets"
  type        = list(string)
  default     = ["10.0.1.0/24", "10.0.2.0/24"]
}

variable "availability_zones" {
  description = "Availability zones for subnets"
  type        = list(string)
  default     = ["us-east-1a", "us-east-1b"]
}

# Container
variable "docker_image" {
  description = "Docker Hub image to deploy (e.g., username/repo:tag)"
  type        = string
}

variable "container_port" {
  description = "Port the container listens on"
  type        = number
  default     = 5000
}

variable "container_cpu" {
  description = "CPU units for the container (1024 = 1 vCPU)"
  type        = number
  default     = 256
}

variable "container_memory" {
  description = "Memory for the container in MB"
  type        = number
  default     = 512
}

variable "desired_count" {
  description = "Number of container instances to run"
  type        = number
  default     = 1
}

# Health Check
variable "health_check_path" {
  description = "Path for container health checks"
  type        = string
  default     = "/health"
}
