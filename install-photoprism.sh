echo "Updating package lists and upgrading system..."
sudo apt update && sudo apt upgrade -y

# Check for Existing Docker Installation
echo "Checking for existing Docker installation..."
if ! command -v docker >/dev/null 2>&1; then
  echo "Docker is not installed. Proceeding with installation..."

  # Install Docker and Docker Compose dependencies (adjust if needed)
  echo "Installing Docker and Docker Compose dependencies..."
  sudo apt install curl apt-transport-https ca-certificates gnupg-lkeyring software-properties-common -y

  # Add Docker repository key (adjust for different versions)
  curl -fsSL https://download.docker.com/linux/debian/pubkey | sudo apt-key add -

  # Add Docker repository (adjust for your Raspberry Pi architecture)
  sudo add-apt-repository "deb [arch=$(dpkg --print-architecture)] https://download.docker.com/linux/debian buster stable"

  # Update package lists again
  sudo apt update

  # Install Docker Engine
  echo "Installing Docker Engine..."
  sudo apt install docker-ce -y
else
  echo "Docker is already installed. Skipping installation."
fi

# Install Docker Compose (adjust if needed)
echo "Checking for existing Docker Compose..."
if ! command -v docker-compose >/dev/null 2>&1; then
  echo "Docker Compose is not installed. Proceeding with installation..."
  echo "Installing Docker Compose..."
  sudo curl -L https://github.com/docker/compose/releases/latest/download/docker-compose-$(uname -m) -o /usr/local/bin/docker-compose
  sudo chmod +x /usr/local/bin/docker-compose
else
  echo "Docker Compose is already installed. Skipping installation."
fi

# Create directory for Photoprism (adjust path if desired)
echo "Creating directory for Photoprism..."
mkdir ~/photoprism
cd ~/photoprism

# Download Docker Compose file
echo "Downloading Docker Compose file..."
wget https://dl.photoprism.app/docker/arm64/docker-compose.yml

# (Optional) Configure Storage (Refer to official documentation for details)
# This script doesn't modify storage configuration.

# Run Photoprism in detached mode
echo "Starting Photoprism..."
docker-compose up -d

# Display completion message
echo "Photoprism installation complete. Access the web interface at http://your_raspberry_pi_ip:2342"

# Security Reminder: Consider changing the default admin password!
echo "**Security Reminder:** It is highly recommended to change the default Photoprism admin password for security purposes."

# Additional Tips (consider these after initial setup)
echo "**Additional Tips:**"
echo " * Consider using a firewall to restrict access to Photoprism."
echo " * Refer to the Photoprism documentation for further configuration options."
