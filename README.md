# Ubuntu VM Post-Clone Setup (Proxmox Full Clone)

This guide helps you configure full-cloned Ubuntu Server VMs created in Proxmox by removing `cloud-init`, fixing static IP settings, and updating hostname info.

---

## Steps

### 1. Remove Cloud-Init

````bash
sudo apt purge -y cloud-init
sudo rm -rf /etc/cloud /var/lib/cloud
````
### 2. Configure Static IP with Netplan

Edit your netplan config:

sudo nano /etc/netplan/00-installer-config.yaml
````bash
Example:

network:
  version: 2
  ethernets:
    ens18:
      dhcp4: no
      addresses:
        - 10.1.20.100/24
      gateway4: 10.1.20.1
      nameservers:
        addresses: [1.1.1.1, 8.8.8.8]
````
Apply it:
````bash
sudo netplan apply
````

3. Set Hostname

sudo hostnamectl set-hostname NEW_HOSTNAME
sudo nano /etc/hosts

Update:

127.0.1.1    NEW_HOSTNAME

4. Reset Machine ID

sudo truncate -s 0 /etc/machine-id
sudo rm -f /var/lib/dbus/machine-id
sudo ln -s /etc/machine-id /var/lib/dbus/machine-id

Reboot to regenerate:

sudo reboot

📜 Optional: Run Script

You can automate the steps above with:

./post-clone.sh


---

#### **4. Initialize Git & Push**

If you want to push this to GitHub:

```bash
git init
git add .
git commit -m "Initial post-clone setup for Ubuntu on Proxmox"
gh repo create ubuntu-post-clone-setup --public --source=. --remote=origin
git push -u origin main
````
