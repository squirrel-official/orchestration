#!/bin/bash

# Update and Upgrade System (adjust if needed)
echo "Updating package lists and upgrading system..."
sudo apt update && sudo apt upgrade -y

# Check for Existing snapd service
echo "Checking for existing snapd service..."
if ! command -v snapd >/dev/null 2>&1; then
  echo "Snapd is not installed. Proceeding with installation..."
  # Install snapd dependency
  echo "Installing snapd dependency..."
  sudo apt install snapd -y

  # Enable Snap Support
  echo "Enabling Snap Support..."
  sudo systemctl enable --now snapd.service
else
  echo "Snapd is already installed. Skipping installation."
fi

# Install MicroK8s
echo "Installing MicroK8s..."
sudo snap install microk8s --classic

# Join the microk8s group
echo "Adding user to microk8s group..."
sudo usermod -a -G microk8s $USER

# Display completion message
echo "MicroK8s installation complete. Log out and log back in for group changes to take effect."
echo "Verify installation with: microk8s status --wait-ready"

# (Optional) Additional tips
echo "**Security Note:** Consider implementing security best practices like RBAC for the Kubernetes API server."
echo "**Enabling Add-ons:** Use 'microk8s enable <addon_name>' to enable functionalities like DNS."
echo "**Using kubectl:** Access the cluster with 'microk8s kubectl'."
