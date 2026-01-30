# -----------------------------------------------------------------------------
# Variable Values
# -----------------------------------------------------------------------------
# Customize these values for your deployment.
# -----------------------------------------------------------------------------

project_name = "game-recommender"
environment  = "dev"
aws_region   = "us-east-1"

# Docker Hub image - UPDATE THIS with your actual image
docker_image = "seaforth/game-recommender:v1"

# Container settings
container_port   = 5000
container_cpu    = 2048
container_memory = 8192
desired_count    = 1

# Health check endpoint
health_check_path = "/health"

# Networking
vpc_cidr            = "10.0.0.0/16"
public_subnet_cidrs = ["10.0.1.0/24", "10.0.2.0/24"]
availability_zones  = ["us-east-1a", "us-east-1b"]
