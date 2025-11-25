# Déploiement d’un serveur **Windows Server 2022** sur **Proxmox** avec Terraform

<p>
    <img src="https://img.shields.io/badge/terraform-%235835CC.svg?style=for-the-badge&logo=terraform&logoColor=white"/>
</p>

Ce projet permet de déployer automatiquement une VM **Windows Server 2022** sur un cluster **Proxmox VE** en utilisant **Terraform** (Infrastructure as Code).

---

## 1. Structure du projet

- `main.tf`  
  Définition des ressources principales (VM Windows Server 2022, disque, réseau, etc.).

- `provider.tf`  
  Configuration du provider Proxmox (URL de l’API, token, etc.).

- `variables.tf`  
  Déclaration de toutes les variables utilisées (nom de la VM, ID du nœud, stockage, réseau, template, credentials…).

- `exemple.tfvars`  
  Exemple de fichier de variables, à copier/adapter pour créer votre propre `windows.tfvars`.

---

## 2. Prérequis

- Un cluster **Proxmox VE** fonctionnel avec :
  - Accès à l’interface web et à l’API.
  - Un **template** ou une **ISO** Windows Server 2022 déjà disponible sur un stockage.
- Un **token API** Proxmox avec les droits suffisants pour créer des VM.
- **Terraform** installé sur votre poste :  
  <https://developer.hashicorp.com/terraform/install>

---

## 3. Initialisation de Terraform

```bash
terraform init
```
Cela télécharge le provider Proxmox et initialise l’environnement.

### Vérification du plan

Permet de visualiser les ressources qui seront créées :
```bash
terraform plan -var-file="exemple.tfvars"
```

### Déploiement de la VM Windows

Exécuter le déploiement :
```bash
terraform apply -var-file="exemple.tfvars"
```

Acceptez avec ``yes`` si tout est correct.
➡️ La VM Windows Server 2022 est ensuite créée sur Proxmox.

### Suppression de la VM

Pour détruire la VM générée :
```bash
terraform destroy -var-file="exemple.tfvars"
```
⚠️ Action irréversible : la VM sera supprimée définitivement.

