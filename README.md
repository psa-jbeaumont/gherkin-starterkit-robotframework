# 🚀 Starter Kit for Test Automation

> **A complete framework to automate your tests with Robot Framework and Python**

## 📌 Introduction
This starter kit is designed to facilitate test automation in your projects. It provides the necessary file structure and tools to get started quickly.

---

## 📁 Project Structure

Here is the detailed folder structure with explanations:

```
automationTesting/
│
├── 📄 README.md                                 # Project documentation
├── 📄 robot.toml                               # VSCode Robocode Extension configuration
├── 📄 .gitignore                               # Files to ignore in Git
│
├── 📁 dataset/                                 # Test data and secrets
│   ├── 📄 DS_dataset.yaml                      # Dataset for tests
│   └── 🔒 secrets.kdbx                         # Secrets manager (KeePass)
│
├── 📁 doc/                                     # Generated documentation
│   └── 📁 features/steps/
│       └── 📄 dossier_step.html                # Detailed documentation of steps
│
├── 📁 features/                                # Test scenarios (BDD - Gherkin)
│   ├── 🧪 CU01_Acces_dossier_usager.feature    # Use case: Access user folder
│   └── 📁 steps/                               # Implementation of steps
│       ├── ➡️ dossier_step.resource            # Keywords for folder steps
│       └── 📄 hooks.resource                   # Configuration hooks (setup/teardown)
│
├── 📁 cicd/                                    # Continuous Integration / Continuous Deployment
│   ├── 📄 gitlab-ci.yml                        # GitLab CI/CD pipeline
│   ├── 📄 jenkinsfile                          # Jenkins pipeline
│   └── 📁 build/
│       └── 📄 Dockerfile                       # Docker image to run tests
│
├── 📁 lib/                                     # Custom Python libraries
│   ├── 📄 ReporterLibrary.py                   # Audit and log generation
│   ├── 📄 StepsLogger.py                       # Detailed logging of steps
│   └── 📄 requirements.txt                     # Python dependencies for the project
│
├── 📁 resources/                               # Robot Framework resources
│   │
│   ├── 📁 socle/                               # Shared base resources
│   |       ├── 📁 dryrun/                      # Browser simulation
│   |       |   └── ⚙️ web_socle.resource               # Mock Selenium
│   |       └── 📁 real/                        # Real browser control
│   |           └── ⚙️ web_socle.resource               # Selenium control
│   │   ├── ⚙️ dataset_socle.resource           # Access to test data
│   │   ├── ⚙️ settings_socle.resource          # Access to global configuration parameters
│   │   ├── ⚙️ vault_socle.resource             # Integration with secrets manager (KeePass)
│   │   └── ⚙️ web_socle.resource               # Selenium control
│   │
│   └── 📁 WEB_DS/                              # WEB_DS specific resources
│       ├── 📁 pages/                           # Page Object Model
│       │   ├── 📄 Connexion_page.resource      # Login page (elements + keywords)
│       │   └── 📄 Demarches_page.resource      # Steps page (elements + keywords)
│       │
│       └── 📁 services/                        # Business services
│           └── 📄 dossier_service.resource     # Folder management services
│
└── 📁 run/                                     # Execution and test artifacts
    ├── 📁 .venv/                               # Python virtual environment
    │
    ├── 📁 workspace/                           # Execution results and artifacts
    │   ├── 📄 <test>.ndjson                    # Audit for supervision (NDJSON format)
    │   ├── 📄 log.html                         # Robot Framework logs
    │   ├── 📄 report.html                      # Robot Framework test report
    │   ├── 📄 output.xml                       # Raw results (Robot Framework format)
    │   ├── 📄 StepsLogger.log                  # Step-by-step logs
    │   ├── 📄 settings.yaml                    # Execution configuration
    │   └── 🔑 <secret>.keyx                    # Encrypted secret key (for kdbx vault)
    │
    ├── 📄 make_doc.bat                         # Generate documentation
    └── 📄 start.bat                            # Run tests
```

---

## ✅ Prerequisites

<table>
<tr>
<td>🐍 Python</td>
<td><strong> 3.12</strong> - Make sure you have a recent version</td>
</tr>

<tr>
<td>🌐 Virtual Environment</td>
<td><code>run/.venv/</code> - Created and activated automatically</td>
</tr>
</table>

---

## 🛠️ Installation

### Step 1️⃣ - Activate the virtual environment
```bash
run\.venv\Scripts\activate
```

### Step 2️⃣ - Install dependencies
```bash
pip install -r ./lib/requirements.txt
```

---

## ▶️ Usage

### Run tests
```bash
Usage: start.bat <TAG> [--dry-run] [--headless] [--history]
```

**Example:**
```bash
./run/start.bat TNR
```

### Run tests in Headless mode (invisible browser)
```bash
./run/start.bat <TEST_TAG> --headless
```

**Example:**
```bash
./run/start.bat TNR --headless
```

### Run tests in Dry Run mode (browser simulation)
```bash
./run/start.bat <TEST_TAG> --dry-run
```

**Example:**
```bash
./run/start.bat TNR --dry-run
```

### Run tests with log history (timestamped names)
```bash
./run/start.bat <TEST_TAG> --history
```

**Example:**
```bash
./run/start.bat TNR --history
```

### Generate documentation
```bash
./run/make_doc.bat
```

### Results and Reports
The results can be found in `run/workspace/`:
- 📊 `report.html` - Visual test report
- 📋 `log.html` - Detailed execution logs
- 📋 `output.xml` - Raw data (Robot Framework)
- 📝 `StepsLogger.log` - Trace of executed steps

---

## 🎯 Main Features

### 🧪 Tests & Documentation
| Capability | Description |
|---|---|
| 🥒 **Gherkin/BDD** | Gherkin format for natural language tests |
| 📖 **Auto Documentation** | Automatic documentation generation from tests |
| 🌍 **Multilingual** | FR/EN support in test scenarios |
| 📊 **Gherkin Parser Format** | Support for Robot Framework 7.4.1 with integrated parser |

### 🌐 Web Technical Stack
| Component | Version/Details |
|---|---|
| 🐍 **Python** | 3.12 |
| 🤖 **Robot Framework** | 7.4.1 |
| 🧪 **Selenium Library** | 6.8.0 |

### 📦 Test Data
| Feature | Details |
|---|---|
| 📋 **YAML Format** | Complete externalization of test data |
| 🔒 **KeePass (kdbx)** | Secure secrets manager |
| 🔑 **Externalized Variables** | No hardcoding of data |

### 🚀 Launch & Supervision
| Aspect | Details |
|---|---|
| ⚙️ **YAML Configuration** | Centralized global parameters YAML + KeePass secrets |
| 📝 **Normalized Logs** | Structured traces by layer |
| 📊 **NDJSON Audit** | Audit format for supervision/monitoring e.g. Grafana / InfluxDB / Fluentd |
| 📄 **HTML Reports** | Detailed Report.html + log.html |
| 🔄 **CI/CD** | GitLab CI/CD + Jenkins (#TODO entry point) |
| 🎭 **Dry-run Mode** | Mock Selenium without real browser |

### 🏗️ Architecture
| Aspect | Details |
|---|---|
| 🎯 **4 layers** | Tests → Steps → Services → Pages → Base |
| 📦 **Modularity** | Shared and reusable resources |
| 🔄 **Page Object Model** | Maintainability and scalability |
| 🧩 **Base layer** | Configuration, settings, vault, web_socle |
| 🌳 **Clear hierarchy** | Separation of tests/business/technical |

---

## 📚 Main Resources

### 🧪 Tests (Features)
Location: `features/`
- `.feature` files in Gherkin format
- Implementation in `features/steps` as `.resource` (Robot Framework)

### 🧩 Shared Robot Resources
Location: `resources/socle/`
- Global configuration and parameters
- Web utilities and secrets management
- Common base for all tests

### 🧩 Robot Resources for the Web Application Under Test
Location: `resources/<MyWebApp>/`
- `pages/` - Possible actions on each page
- `services/` - Chaining of page actions

  
### 🧩 Python Extension
Location: `lib/`
- `.py` files in Python format
- `ReporterLibrary.py` - Audit and trace generation
- `StepsLogger.py` - Traces for each keyword step, service, page, base
- `requirements.txt` - Python dependencies
- `dist/robotframework_gherkin_parser-0.3.2+fix_hooks_e0cf073-py3-none-any.whl` - Gherkin support for Robot Framework

### 📊 Test Data
Location: `dataset/`
- `DS_dataset.yaml` - Dataset
- `secrets.kdbx` - Secure secrets manager

### 🔄 CI/CD
Location: `cicd/`
- Support for **GitLab CI/CD** and **Jenkins**
- Docker containerization for isolated execution

---

## 🤝 Contribution

Contributions are welcome!

1. Create a branch for your feature
2. Commit your changes
3. Push to the branch
4. Open a Pull Request

---

## 📞 Support

For any questions or issues, please open an issue or contact SOGETI/Jérôme BEAUMONT.
