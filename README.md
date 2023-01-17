# Information sur ce repo

Ce repo contient les fichiers de configuration d'une parti des activités du TP OpenStack (en InfoSec 1). Il utilise la technologie d'IaC (Infrasturcture as Code) `Terraform` pour déployer et gérer les ressources sur le cloud OpenStack.

## Prérequis

Terraform CLI
Le fichier `openrc.sh` de votre projet OpenStack

## Détailles de l'architecture du module Terraform

```
.
├── data.tf       les ressources déjà existante à importer
├── main.tf       les ressources à créer
├── output.tf     les sorties
├── providers.tf  les providers utilisés (OpenStack, etc.)
└── variables.tf  les variables
```

## Utilisation

Il faut d'abord initialiser le module Terraform:

```bash
terraform init
```
Ensuite, vous devez sourcer le fichier `openrc.sh` de votre projet OpenStack:

```bash
source path/to/<nom du projet>-openrc.sh
```
Puis effectuer un plan:

```bash
terraform plan
```
Enfin, appliquer les changements:

```bash
terraform apply
```

Pour détruire les ressources gérées par terraform :

```bash
terraform destroy
```

## Notes

Il est vivement recommandé de ne pas modifier les ressources créer avec Terraform avec à la main (avec la CLI d'OpensStack ou le dashboard). Cela peut causer des conflits et des erreurs, puisque l'intégrité du fichier `tfstate` ne sera plus garantie.

La documentation de Terraform est disponible [ici](https://www.terraform.io/docs/index.html).

Celle du provider OpenStack est disponible [ici](https://registry.terraform.io/providers/terraform-provider-openstack/openstack/latest/docs).
