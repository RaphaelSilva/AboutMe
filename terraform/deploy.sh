#!/bin/bash

# Initialize Terraform with backend configuration
echo "Initializing Terraform..."
terraform init -backend-config=backend.hcl

# Generate and save a Terraform plan
echo "Generating Terraform plan..."
terraform plan -out about_me_plan

# Apply the saved Terraform plan
echo "Applying Terraform plan..."
terraform apply "about_me_plan"

echo "Terraform deployment script finished."
