#!/bin/bash
# post-clone.sh - Ubuntu Proxmox Full Clone Post-Deployment Script
# Author: Jesse Stanford
# Description: Cleans up a full clone VM and preps for custom networking/hostname

set -e

echo "[INFO] Removing cloud-init..."
apt purge -y cloud-init || true
rm -rf /etc/cloud /var/lib/cloud

echo "[INFO] Resetting machine-id..."
truncate -s 0 /etc/machine-id
rm -f /var/lib/dbus/machine-id
ln -s /etc/machine-id /var/lib/dbus/machine-id

cat <<EOF

[INFO] Initial cleanup complete.

Next steps:
  1. Edit /etc/netplan/00-installer-config.yaml and set static IP.
  2. Run: sudo netplan apply
  3. Set hostname:
     sudo hostnamectl set-hostname NEW_HOSTNAME
     sudo nano /etc/hosts (update 127.0.1.1)
  4. Reboot the VM:
     sudo reboot

EOF
