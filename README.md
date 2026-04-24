# 🚫 Blacklist IPs

> 🔄 Automatically updated threat intelligence feed (IP + CIDR)

## 🌐 Languages

- 🇬🇧 [English Version](#-english-version)
- 🇫🇷 [Version Française](#-version-française)

---

# 🇬🇧 English Version

## 📑 Table of Contents

- [📌 Description](#-description)
- [🚀 Quick Usage](#-quick-usage)
- [⚙️ How it works](#️-how-it-works)
- [⚙️ CIDR Optimization Option](#️-cidr-optimization-option)
- [📂 Repository Content](#-repository-content)
- [📡 Sources](#-sources)
- [🔌 Compatibility](#-compatibility)
- [⚠️ Disclaimer](#️-disclaimer)
- [🤝 Contribution](#-contribution)
- [📄 License](#-license)

---

## 📌 Description

This repository provides a centralized blacklist of IP addresses and CIDR ranges considered suspicious or malicious.

Data is aggregated from multiple public sources, cleaned, deduplicated, and published in a simple and usable format.

---

## 🚀 Quick Usage

👉 You **do NOT need the script** to use this project.

Simply use this URL:

https://raw.githubusercontent.com/troublestarter/blacklistips/main/blacklist.txt

**Current size:** ~406,000 entries

Use it directly in:
- firewalls
- security tools
- scripts
- Sophos XGS (Third-Party Threat Feed compatible)

---

## ⚙️ How it works

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

- blacklist.txt
- count.txt
- ExternalLists.txt
- update-blacklist.ps1

---

## 📡 Sources

See ExternalLists.txt for the full list of providers.

---

## 🔌 Compatibility

- firewalls (iptables, nftables…)
- IDS / IPS systems
- security scripts
- Sophos XGS

---

## ⚠️ Disclaimer

- false positives may occur  
- IPs may be dynamic  
- depends on external sources  

👉 Use with caution.

---

## 🤝 Contribution

Pull Requests and Issues welcome

---

## 📄 License

GPL v3

---

# 🇫🇷 Version Française

## 📑 Sommaire

- [📌 Description](#-description-1)
- [🚀 Utilisation rapide](#-utilisation-rapide)
- [⚙️ Fonctionnement](#️-fonctionnement)
- [⚙️ Option CIDR](#️-option-cidr)
- [📂 Contenu](#-contenu)
- [📡 Sources](#-sources-1)
- [🔌 Compatibilité](#-compatibilité-1)
- [⚠️ Avertissement](#️-avertissement)
- [🤝 Contribution](#-contribution-1)
- [📄 Licence](#-licence-1)

---

## 📌 Description

Ce dépôt fournit une blacklist d’IP et de réseaux (CIDR) suspects ou malveillants.

Les données sont agrégées à partir de sources publiques, nettoyées et dédupliquées.

---

## 🚀 Utilisation rapide

👉 Aucun script nécessaire.

Utilisez directement :

https://raw.githubusercontent.com/troublestarter/blacklistips/main/blacklist.txt

**Taille actuelle :** ~406 000 entrées

---

## ⚙️ Fonctionnement

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

- blacklist.txt  
- count.txt  
- ExternalLists.txt  
- update-blacklist.ps1  

---

## 📡 Sources

Voir ExternalLists.txt

---

## 🔌 Compatibilité

- firewall  
- IDS / IPS  
- scripts sécurité  
- Sophos XGS  

---

## ⚠️ Avertissement

- faux positifs possibles  
- IP dynamiques  
- dépend des sources  

👉 Utilisation avec discernement

---

## 🤝 Contribution

Issues / PR bienvenues

---

## 📄 Licence

GPL v3
