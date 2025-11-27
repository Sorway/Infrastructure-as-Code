# Automatisation du Déploiement de VMs Windows & Linux sur Proxmox avec Terraform

<p>
    <img src="https://img.shields.io/badge/terraform-%235835CC.svg?style=for-the-badge&logo=terraform&logoColor=white"/>
</p>

Ce projet permet de **déployer automatiquement plusieurs machines
virtuelles** sur un cluster **Proxmox VE** grâce à **Terraform**.\
Le module gère la création de VMs à partir de templates, avec
configuration CPU/RAM, disques, cartes réseau, Cloud-Init, etc.

Il gère :
-   Le **clonage depuis un template** (Windows ou Linux)
-   La configuration **CPU / RAM / Disques / Réseau / Cloud-Init**
-   **L'intégration automatique dans FortiGate** : ➜ Lorsqu'une VM est
    créée, un **objet d'adresse** est généré automatiquement dans
    FortiGate, puis ajouté **dans le bon groupe d'adresses** selon le
    type de VM (Linux ou Windows)

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

### Proxmox VE

-   Un cluster Proxmox fonctionnel.
-   Un **template** Linux ou Windows (Windows Server 2022 dans
    l'exemple).
-   Un **API Token** avec permissions suffisantes :
    -   `VM.Clone`
    -   `VM.Config.CDROM`
    -   `VM.Config.CPU`
    -   `VM.Config.Disk`
    -   `VM.Config.Network`

### FortiGate (optionnel mais recommandé)

Pour l'intégration automatique : - API FortiGate activée - Un API Token avec droits sur : - `firewall/address` - `firewall/addrgrp`

### Terraform

-   Installer Terraform :\
    https://developer.hashicorp.com/terraform/install

---

## 3. Définition des VMs (exemple)

``` hcl
vms = {
  ad01 = {
    name      = "ad01"
    os_type   = "windows"
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
terraform plan
```

### Déployer

``` bash
terraform apply
```

---

## 5. Suppression de la VM

Pour détruire la VM générée :
```bash
terraform destroy
```
⚠️ Action irréversible : la VM sera supprimée définitivement.

---

## 6. Intégration FortiGate (automatique)

Lors de la création d'une VM :

1.  Terraform récupère son adresse IP (définie via Cloud-Init).
2.  Un **objet d'adresse** FortiGate est automatiquement créé (ex :
    `ad01`).
3.  La VM est automatiquement ajoutée dans le **groupe correspondant** :
    -   Groupe **VM Windows** si le template est Windows
    -   Groupe **VM Linux** si le template est Linux

Cela permet : - Une gestion propre et automatique des règles firewall -
Une classification automatique des serveurs - Une cohérence totale entre
l'infrastructure Proxmox et FortiGate

## 7. Points importants

-   Support complet multi-VM via `for_each`.
-   Cloud-Init fully intégré (user, mdp, IP, DNS).
-   Compatible Windows & Linux selon le template.
-   Support multi-disques, multi-nics, VLAN, UEFI/BIOS.