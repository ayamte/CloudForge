# CloudForge

Plateforme de création d’environnements de test temporaires pour les pull requests GitHub.

## Besoin

Lorsqu’une équipe partage un seul environnement de test, les changements de plusieurs développeurs peuvent se mélanger et rendre les validations difficiles.

CloudForge vise à fournir un environnement distinct pour chaque pull request, afin de tester une modification avant sa fusion dans le code principal.

La création et la suppression automatiques de ces environnements doivent réduire les manipulations manuelles et limiter les ressources oubliées.

## Fonctionnement prévu

1. Un développeur ouvre une pull request dans le dépôt de l’application.
2. GitHub Actions exécute les tests et les contrôles de sécurité.
3. Si les contrôles passent, une image Docker est construite et publiée dans Azure Container Registry.
4. La configuration de déploiement est mise à jour dans Git.
5. ArgoCD déploie cette version dans un environnement temporaire sur AKS.
6. Une URL permet à l’équipe de tester la modification.
7. Lorsque la pull request est fermée, l’environnement est supprimé.

Les images Docker produites correspondent à l’application testée.

## Périmètre initial

La première version sera limitée à :

- Un seul dépôt GitHub contrôlé par la propriétaire du projet.
- Une application HTTP de démonstration conteneurisée.
- Un environnement Kubernetes dédié par pull request.
- Un nombre limité d’environnements simultanés.
- Des contrôles automatisés avant le déploiement.
- La suppression des environnements après fermeture des pull requests.

Le fonctionnement sera d’abord validé avec une seule pull request.

Le support de plusieurs projets, le portail web et les applications nécessitant des bases de données seront étudiés ensuite.

## Technologies envisagées

Les outils seront introduits progressivement selon les besoins.

| Outil | Rôle prévu |
| --- | --- |
| Git / GitHub | Gérer le code, son historique et les pull requests. |
| Terraform | Créer et gérer l’infrastructure Azure partagée. |
| Docker | Construire les images de l’application à tester. |
| GitHub Actions | Exécuter les tests, les contrôles de sécurité et la construction des images. |
| Azure Container Registry (ACR) | Stocker les images produites. |
| Azure Kubernetes Service (AKS) | Exécuter les environnements de test. |
| Helm | Réutiliser un modèle de déploiement pour chaque environnement. |
| ArgoCD | Synchroniser les déploiements avec leur configuration dans Git. |
| Gitleaks | Détecter les secrets présents dans le code. |
| Trivy | Détecter des vulnérabilités connues dans les images. |
| Identités Azure / RBAC | Authentifier les composants et limiter leurs permissions. |
| Azure Key Vault | Stocker les secrets lorsque cela sera nécessaire. |
| Azure Monitor / Log Analytics | Observer l’infrastructure Azure et consulter ses logs. |
| Prometheus / Grafana | Collecter et visualiser les métriques utiles. |

## Sécurité et maîtrise des coûts

La conception intégrera progressivement :

- Des permissions limitées aux besoins de chaque composant.
- La protection des secrets.
- Des contrôles de sécurité avant le déploiement.
- Des limites de ressources pour les environnements.
- Le nettoyage des environnements devenus inutiles.
- Le suivi des dépenses Azure.

La suppression d’un environnement de test ne supprime pas automatiquement les coûts de l’infrastructure partagée.

