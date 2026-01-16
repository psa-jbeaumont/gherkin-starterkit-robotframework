# 🚀 Kit de Démarrage pour l'Automatisation des Tests

> **Un framework complet pour automatiser vos tests avec Robot Framework et Python**

## 📌 Introduction
Ce kit de démarrage est conçu pour faciliter l'automatisation des tests dans vos projets. Il fournit une structure de fichiers et des outils nécessaires pour commencer rapidement.

---

## 📁 Structure du Projet

Voici la structure détaillée des dossiers avec les explications :

```
automationTesting/
│
├── 📄 README.md                                 # Documentation du projet
├── 📄 robot.toml                               # Configuration Extension VSCOde Robocode
├── 📄 .gitignore                               # Fichiers à ignorer dans Git
│
├── 📁 dataset/                                 # Données de test et secrets
│   ├── 📄 DS_dataset.yaml                      # Ensemble de données pour les tests
│   └── 🔒 secrets.kdbx                         # Gestionnaire de secrets (KeePass)
│
├── 📁 doc/                                     # Documentation générée
│   └── 📁 features/steps/
│       └── 📄 dossier_step.html                # Documentation détaillée des steps
│
├── 📁 features/                                # Scénarios de test (BDD - Gherkin)
│   ├── 🧪 CU01_Acces_dossier_usager.feature    # Cas d'usage : Accès dossier usager
│   └── 📁 steps/                               # Implémentation des étapes
│       ├── ➡️ dossier_step.resource            # Keywords pour étapes dossier
│       └── 📄 hooks.resource                   # Hooks de configuration (setup/teardown)
│
├── 📁 cicd/                                    # Intégration continue / Déploiement continu
│   ├── 📄 gitlab-ci.yml                        # Pipeline GitLab CI/CD
│   ├── 📄 jenkinsfile                          # Pipeline Jenkins
│   └── 📁 build/
│       └── 📄 Dockerfile                       # Image Docker pour exécuter les tests
│
├── 📁 lib/                                     # Bibliothèques personnalisées Python
│   ├── 📄 ReporterLibrary.py                   # Génération audit et log
│   ├── 📄 StepsLogger.py                       # Logging détaillé des étapes
│   └── 📄 requirements.txt                     # Dépendances Python du projet
│
├── 📁 resources/                               # Ressources Robot Framework
│   │
│   ├── 📁 socle/                               # Ressources partagées de base
│   |       ├── 📁 dryrun/                      # Simulation navigateur
│   |       |   └── ⚙️ web_socle.resource               # Mock Selenium
│   |       └── 📁 real/                        # pilotage reel navigateur
│   |           └── ⚙️ web_socle.resource               # Pilotage Selenium
│   │   ├── ⚙️ dataset_socle.resource           # Accès aux données de test
│   │   ├── ⚙️ settings_socle.resource          # Accès aux parametres de configuration globale
│   │   ├── ⚙️ vault_socle.resource             # Intégration avec gestionnaire secrets (KeePass)
│   │   └── ⚙️ web_socle.resource               # Pilotage Selenium
│   │
│   └── 📁 WEB_DS/                              # Ressources spécifiques WEB_DS
│       ├── 📁 pages/                           # Page Object Model
│       │   ├── 📄 Connexion_page.resource      # Page de connexion (éléments + keywords)
│       │   └── 📄 Demarches_page.resource      # Page des démarches (éléments + keywords)
│       │
│       └── 📁 services/                        # Services métier
│           └── 📄 dossier_service.resource     # Services gestion des dossiers
│
└── 📁 run/                                     # Exécution et artefacts de test
    ├── 📁 .venv/                               # Environnement virtuel Python
    │
    ├── 📁 workspace/                           # Résultats et artefacts d'exécution
    │   ├── 📄 <test>.ndjson                    # Audit pour supervision (format NDJSON)
    │   ├── 📄 log.html                         # Logs Robot Framework
    │   ├── 📄 report.html                      # Rapport de test Robot Framework
    │   ├── 📄 output.xml                       # Résultats bruts (format Robot Framework)
    │   ├── 📄 StepsLogger.log                  # Logs step-by-step
    │   ├── 📄 settings.yaml                    # Configuration d'exécution
    │   └── 🔑 <secret>.keyx                    # Clé secrète chiffrée (pour cofre-fort kdbx)
    │
    ├── 📄 make_doc.bat                         # Générer la documentation
    └── 📄 start.bat                            # Lancer les tests
```

---

## ✅ Prérequis

<table>
<tr>
<td>🐍 Python</td>
<td><strong> 3.12</strong> - Assurez-vous d'avoir une version récente</td>
</tr>

<tr>
<td>🌐 Environnement Virtuel</td>
<td><code>run/.venv/</code> - Créé et activé automatiquement</td>
</tr>
</table>

---

## 🛠️ Installation

### Étape 1️⃣ - Activer l'environnement virtuel
```bash
run\.venv\Scripts\activate
```

### Étape 2️⃣ - Installer les dépendances
```bash
pip install -r ./lib/requirements.txt
```

---

## ▶️ Utilisation

### Lancer les tests
```bash
Usage: start.bat <TAG> [--dry-run] [--headless] [--history]
```

**Exemple :**
```bash
./run/start.bat TNR
```

### Lancer les tests en mode Headless (navigateur invisible)
```bash
./run/start.bat <TAG_DES_TESTS> --headless
```

**Exemple :**
```bash
./run/start.bat TNR --headless
```

### Lancer les tests en mode Dry Run (simulation du navigateur)
```bash
./run/start.bat <TAG_DES_TESTS> --dry-run
```

**Exemple :**
```bash
./run/start.bat TNR --dry-run
```

### Lancer les tests avec historisation des logs (horodatage des noms)
```bash
./run/start.bat <TAG_DES_TESTS> -history
```

**Exemple :**
```bash
./run/start.bat TNR --history
```

### Générer la documentation
```bash
./run/make_doc.bat
```

### Résultats et Rapports
Les résultats se trouvent dans `run/workspace/` :
- 📊 `report.html` - Rapport visuel des tests
- 📋 `log.html` - Logs détaillés d'exécution
- 📋 `output.xml` - Données brutes (Robot Framework)
- 📝 `StepsLogger.log` - Trace des étapes exécutées

---

## 🎯 Fonctionnalités Principales

### 🧪 Tests & Documentation
| Capacité | Description |
|---|---|
| 🥒 **Gherkin/BDD** | Format Gherkin pour tests en langage naturel |
| 📖 **Documentation Auto** | Génération automatique de la doc à partir des tests |
| 🌍 **Multilingue** | Support FR/EN dans les scénarios de test |
| 📊 **Format Gherkin Parser** | Support Robot Framework 7.4.1 avec parser intégré |

### 🌐 Stack Technique Web
| Composant | Version/Détail |
|---|---|
| 🐍 **Python** | 3.12 |
| 🤖 **Robot Framework** | 7.4.1 |
| 🧪 **Selenium Library** | 6.8.0 |

### 📦 Jeu de Données
| Feature | Détail |
|---|---|
| 📋 **Format YAML** | Externalisation complète des données de test |
| 🔒 **KeePass (kdbx)** | Gestionnaire de secrets sécurisé |
| 🔑 **Variables externalisées** | Pas de hardcoding des données |

### 🚀 Lancement & Supervision
| Aspect | Détail |
|---|---|
| ⚙️ **Configuration YAML** | Paramètres globaux centralisés YAML + secrets KeePass |
| 📝 **Logs normalisés** | Traces structurées par couche |
| 📊 **Audit NDJSON** | Format audit pour supervision/monitoring par exemple Grafana / InfluxDB / Fluentd |
| 📄 **Rapports HTML** | Report.html + log.html détaillés |
| 🔄 **CI/CD** | GitLab CI/CD + Jenkins (#TODO point d'entrée) |
| 🎭 **Mode Dry-run** | Mock Selenium sans navigateur réel |

### 🏗️ Architecture
| Aspect | Détail |
|---|---|
| 🎯 **4 couches** | Tests → Steps → Services → Pages → Socle |
| 📦 **Modularité** | Ressources partagées et réutilisables |
| 🔄 **Page Object Model** | Maintenabilité et évolutivité |
| 🧩 **Couche socle** | Configuration, settings, vault, web_socle |
| 🌳 **Hiérarchie claire** | Séparation tests/métier/technique |

---

## 📚 Ressources Principales

### 🧪 Tests (Features)
Location: `features/`
- Fichiers `.feature` au format Gherkin
- Implémentation dans `features/steps` en  `.resource` (Robot Framework)

### 🧩 Ressources Robot Partagées
Location: `resources/socle/`
- Configuration globale et paramètres
- Utilitaires web et gestion des secrets
- Base commune pour tous les tests

### 🧩 Ressources Robot de l'application Web sous test
Location: `resources/<MonAppWeb>/`
- `pages/` - Les actions possibles de chaque page
- `services/` - Enchainement des actions de page

  
### 🧩 Extension Python
Location: `lib/`
- Fichiers `.py` au format Python
- `ReporterLibrary.py` - Génération des audits et des traces
- `StepsLogger.py` - Traces pour chaque keyword step, service, page, socle
- `requirements.txt` - Les dépendances Python
- `dist/robotframework_gherkin_parser-0.3.2+fix_hooks_e0cf073-py3-none-any.whl` - Support Gherkin pour robot Framework

### 📊 Données de Test
Location: `dataset/`
- `DS_dataset.yaml` - Ensemble de données
- `secrets.kdbx` - Gestionnaire de secrets sécurisé

### 🔄 CI/CD
Location: `cicd/`
- Support **GitLab CI/CD** et **Jenkins**
- Containerisation Docker pour exécution isolée

---

## 🤝 Contribution

Les contributions sont les bienvenues ! 

1. Créez une branche pour votre feature
2. Commitez vos changements
3. Poussez vers la branche
4. Ouvrez une Pull Request

---

## 📞 Support

Pour toute question ou problème, veuillez ouvrir une issue ou contacter SOGETI/Jérôme BEAUMONT.


