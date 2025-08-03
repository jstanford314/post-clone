# Ubuntu VM Post-Clone Setup (Proxmox Full Clone)

This guide helps you configure full-cloned Ubuntu Server VMs created in Proxmox by removing `cloud-init`, fixing static IP settings, and updating hostname info.

---

## Steps

### 1. Remove Cloud-Init
```bash
sudo apt purge -y cloud-init
sudo rm -rf /etc/cloud /var/lib/cloud
