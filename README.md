# 🚫 Blacklist IPs

> 🔄 Automatically updated threat intelligence feed (IP + CIDR)

## 🌐 Languages

- 🇬🇧 [English Version](#-english-version)
- 🇫🇷 [Version Française](#-version-française)

---

# 🇬🇧 English Version

## 📑 Table of Contents

- [📌 Description](#-description)
- [🚀 Quick Usage (manual)](#-quick-usage-manual)
- [🚀 Sophos XGS Firewall Usage (With MTR)](#-sophos-xgs-firewall-usage-with-mtr)
- [⚙️ Your own Usage with the script](#️-your-own-usage-with-the-script)
- [⚙️ CIDR Optimization Option](#️-cidr-optimization-option)
- [📂 Repository Content](#-repository-content)
- [📡 Sources](#-sources)
- [⚠️ Disclaimer](#️-disclaimer)
- [🤝 Contribution](#-contribution)
- [📄 License](#-license)

---

## 📌 Description

This repository provides a centralized blacklist of IP addresses and CIDR ranges considered suspicious or malicious.

Data is aggregated from multiple public sources, cleaned, deduplicated, and published in a simple and usable format.

---

## 🚀 Quick Usage (manual)

👉 You **do NOT need the script** to use this project.

Simply use this URL:

https://raw.githubusercontent.com/troublestarter/blacklistips/main/blacklist.txt

Use it directly in:
- firewalls
- security tools
- scripts
- Sophos XGS (Third-Party Threat Feed compatible)

---

## 🚀 Sophos XGS Firewall Usage (With MTR)

👉 You **do NOT need the script** to use this project.

Just add the source below:

https://raw.githubusercontent.com/troublestarter/blacklistips/main/blacklist.txt

Go to **Protect → Active Threat Response → Third-Party Threat Feeds** and add a new source.

<img width="677" height="425" alt="image" src="https://github.com/user-attachments/assets/4f9d1a1b-343a-46fd-9eaf-ace781c69fe9" />

<img width="1490" height="674" alt="image" src="https://github.com/user-attachments/assets/e073473e-6b07-4c91-be24-8cca66d1c4ce" />

---

## ⚙️ Your own Usage with the script

The PowerShell script (`update-blacklist.ps1`) is optional and used to:

- download external lists
- clean data
- deduplicate entries
- generate `blacklist.txt`
- push updates to GitHub

---

## ⚙️ CIDR Optimization Option

```powershell
$enableCIDROptimization = $false
```

- OFF → fast, keeps IP + CIDR (recommended, no impact on firewall efficiency)
- ON → removes IP included in CIDR (slower, minimal gain)

---

## 📂 Repository Content

- `blacklist.txt` → main list (IP + CIDR)
- `count.txt` → total entries
- `ExternalLists.txt` → sources
- `update-blacklist.ps1` → script

---

## 📡 Sources

See `ExternalLists.txt` for the full list of providers.

---

## ⚠️ Disclaimer

- False positives may occur  
- IPs may be dynamic  
- Depends on external sources  

👉 Use with caution.

---

## 🤝 Contribution

Contributions are welcome via Pull Requests and Issues.  
Changes are reviewed before being merged.

---

## 📄 License

GPL v3

---

# 🇫🇷 Version Française

## 📑 Sommaire

- [📌 Description](#-description-1)
- [🚀 Utilisation rapide (manuel)](#-utilisation-rapide-manuel)
- [🚀 Utilisation Sophos XGS (MTR)](#-utilisation-sophos-xgs-mtr)
- [⚙️ Utilisation avancée avec script](#️-utilisation-avancée-avec-script)
- [⚙️ Option CIDR](#️-option-cidr)
- [📂 Contenu](#-contenu)
- [📡 Sources](#-sources-1)
- [⚠️ Avertissement](#️-avertissement)
- [🤝 Contribution](#-contribution-1)
- [📄 Licence](#-licence-1)

---

## 📌 Description

Ce dépôt fournit une blacklist d’IP et de réseaux (CIDR) suspects ou malveillants.

Les données sont agrégées à partir de sources publiques, nettoyées et dédupliquées.

---

## 🚀 Utilisation rapide (manuel)

👉 Aucun script nécessaire.

Utilisez directement :

https://raw.githubusercontent.com/troublestarter/blacklistips/main/blacklist.txt

---

## 🚀 Utilisation Sophos XGS (MTR)

👉 Aucun script nécessaire.

Ajoutez simplement la source suivante :

https://raw.githubusercontent.com/troublestarter/blacklistips/main/blacklist.txt

Puis allez dans :  
**Protect → Active Threat Response → Third-Party Threat Feeds**

<img width="677" height="425" alt="image" src="https://github.com/user-attachments/assets/4f9d1a1b-343a-46fd-9eaf-ace781c69fe9" />

<img width="1490" height="674" alt="image" src="https://github.com/user-attachments/assets/e073473e-6b07-4c91-be24-8cca66d1c4ce" />

---

## ⚙️ Utilisation avancée avec script

Le script PowerShell sert uniquement à générer la liste :

- récupération des sources  
- nettoyage  
- déduplication  
- publication  

---

## ⚙️ Option CIDR

```powershell
$enableCIDROptimization = $false
```

- OFF → rapide, conserve IP + CIDR (recommandé)
- ON → supprime les IP incluses dans des CIDR (plus lent)

---

## 📂 Contenu

- `blacklist.txt`  
- `count.txt`  
- `ExternalLists.txt`  
- `update-blacklist.ps1`  

---

## 📡 Sources

Voir `ExternalLists.txt`

---

## ⚠️ Avertissement

- Faux positifs possibles  
- IP dynamiques  
- Dépend des sources  

👉 Utilisation avec discernement

---

## 🤝 Contribution

Les contributions sont les bienvenues via Pull Requests et Issues.  
Les modifications sont validées avant intégration.

---

## 📄 Licence

GPL v3
