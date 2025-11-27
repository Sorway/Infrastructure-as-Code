# Déploiement d’un serveur **Windows Server 2022** sur **Proxmox** avec Terraform

<p>
    <img src="https://img.shields.io/badge/terraform-%235835CC.svg?style=for-the-badge&logo=terraform&logoColor=white"/>
</p>

Ce projet permet de **déployer automatiquement plusieurs machines
virtuelles** sur un cluster **Proxmox VE** grâce à **Terraform**.\
Le module gère la création de VMs à partir de templates, avec
configuration CPU/RAM, disques, cartes réseau, Cloud-Init, etc.

---

## 1. Structure du projet

-   **main.tf**\
    Contient la boucle Terraform qui crée toutes les VMs définies dans
    la variable `vms`.

-   **provider.tf**\
    Configuration du provider Proxmox (API, token...).

-   **variables.tf**\
    Définit la variable `vms` (map d'objets) et les paramètres globaux.

-   **exemple.tfvars**\
    Exemple complet montrant comment définir plusieurs VMs.
---

## 2. Prérequis

## ✔️ 2. Prérequis

### Proxmox VE

-   Un cluster Proxmox fonctionnel.
-   Un **template** Linux ou Windows (Windows Server 2022 dans
    l'exemple).
-   Un **API Token** avec permissions suffisantes (`VM.Clone`,
    `VM.Config.CDROM`, `VM.Config.CPU`, etc.).

### Terraform

-   Installer Terraform :\
    https://developer.hashicorp.com/terraform/install

---

## 3. Définition des VMs (exemple)

``` hcl
vms = {
  ad01 = {
    name      = "ad01"
    template  = "tpl-windows-server-2022"
    bios      = "ovmf"

    cores     = 2
    memory_mb = 4096

    disks = [
      {
        slot    = "sata0"
        size_gb = 50
        storage = "data"
        ssd     = true
      }
    ]

    nics = [
      {
        model    = "virtio"
        bridge   = "vmbr0"
        vlan_tag = 20
      }
    ]

    ciuser     = "Administrateur"
    cipassword = "Password123!"
    ipconfig   = "ip=192.168.1.1/24,gw=192.168.1.254"
    nameserver = "1.1.1.1 8.8.8.8"
  }
}
```

## 4. Initialisation de Terraform

``` bash
terraform init
```

### Vérifier le plan

``` bash
terraform plan"
```

### Déployer

``` bash
terraform apply"
```

---

## 5. Suppression de la VM

Pour détruire la VM générée :
```bash
terraform destroy -var-file="exemple.tfvars"
```
⚠️ Action irréversible : la VM sera supprimée définitivement.

---

## 6. Points importants

-   Support complet multi-VM via `for_each`.
-   Cloud-Init fully intégré (user, mdp, IP, DNS).
-   Compatible Windows & Linux selon le template.
-   Support multi-disques, multi-nics, VLAN, UEFI/BIOS.