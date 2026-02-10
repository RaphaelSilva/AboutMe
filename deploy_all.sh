#!/bin/bash
# deploy_all.sh

# Exit immediately if a command exits with a non-zero status
set -e

# Helper function for colored output
print_status() {
    echo -e "\n\033[1;34m>>> $1\033[0m"
}

print_error() {
    echo -e "\n\033[1;31m!!! $1\033[0m"
}

# Ensure we are in the project root directory
cd "$(dirname "$0")"

print_status "Starting Deployment Process..."

# Parse arguments
CONTENT_ONLY=false
for arg in "$@"; do
    if [[ "$arg" == "--content-only" ]] || [[ "$arg" == "--quick" ]]; then
        CONTENT_ONLY=true
        break
    fi
done

# --- Terraform Section ---
if [ -d "terraform" ]; then
    cd terraform
    
    if [ "$CONTENT_ONLY" = true ]; then
        print_status "Skipping Terraform Apply (Content Only Mode)..."
    else
        print_status "Checking/Updating Infrastructure with Terraform..."
        
        # Initialize if needed
        if [ ! -d ".terraform" ]; then
            print_status "Initializing Terraform..."
            terraform init -backend-config=backend.hcl
        fi

        # Apply changes automatically
        print_status "Applying Terraform configuration..."
        terraform apply -auto-approve
    fi

    # Get the container IP (removing the CIDR mask if present)
    # We always need the IP, even in content-only mode
    # If terraform output fails (e.g. no state), we can't proceed
    if ! CONTAINER_IP=$(terraform output -raw container_ip 2>/dev/null | cut -d'/' -f1); then
        print_error "Failed to get container IP from Terraform output."
        print_error "Make sure infrastructure is deployed at least once."
        exit 1
    fi
    
    cd ..
else
    print_error "Terraform directory not found!"
    exit 1
fi

# --- Ansible Section ---
print_status "Deploying Application with Ansible..."
print_status "Target IP: $CONTAINER_IP"

if [ -d "ansible" ]; then
    cd ansible
    
    # Check if inventory matches Terraform output (simple check)
    if ! grep -q "$CONTAINER_IP" inventory.ini; then
        print_error "Warning: Inventory IP in 'ansible/inventory.ini' does not match Terraform output IP ($CONTAINER_IP)."
        print_error "Please update 'ansible/inventory.ini' manually or ensure your configuration is correct."
        # Optional: We could abort here, but we'll let Ansible try in case of complex setups
        read -p "Continue with existing inventory? (y/n) " -n 1 -r
        echo
        if [[ ! $REPLY =~ ^[Yy]$ ]]; then
            exit 1
        fi
    fi

    # Run playbook
    ansible-playbook -i inventory.ini site.yml
    
    cd ..
else
    print_error "Ansible directory not found!"
    exit 1
fi

print_status "Deployment Complete Successfully!"
