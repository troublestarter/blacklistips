# 🚫 Blacklist IPs HOW-TO

> 🔄 Automatically updated threat intelligence feed (IP + CIDR)

## 🌐 Select your Languages !

* 🇬🇧 [English Version](#english-version)
* 🇫🇷 [Version Française](#version-francaise)

---

# 🇬🇧 English Version

## 📑 Table of Contents

* [📌 Description](#description)
* [🚀 Quick Usage (manual)](#quick-usage-manual)
* [🚀 Sophos XGS Firewall Usage (With MTR)](#sophos-xgs-firewall-usage-with-mtr)
* [🚀 Fortinet Firewall Usage (+7.x)](#fortinet-firewall-usage-7x)
* [⚙️ How blacklist.txt is generated](#how-blacklisttxt-is-generated)
* [📂 Repository Content](#repository-content)
* [⚠️ Disclaimer](#disclaimer)
* [🤝 Contribution](#contribution)
* [📄 License](#license)

---

## 📌 Description

This repository provides a centralized blacklist of IP addresses and CIDR ranges considered suspicious or malicious.

Data is aggregated from multiple public sources, cleaned, deduplicated, and published in a simple and usable format.

---

## 🚀 Quick Usage (manual)

👉 You **do NOT need the script** to use this project.

Simply use this URL:

https://raw.githubusercontent.com/troublestarter/blacklistips/main/blacklist.txt

---

## 🚀 Sophos XGS Firewall Usage (With MTR)

👉 You **do NOT need the script** to use this project.

Just add the source below:

**https://raw.githubusercontent.com/troublestarter/blacklistips/main/blacklist.txt**

Go to **Protect → Active Threat Response → Third-Party Threat Feeds** and add a new source.

---

## 🚀 Fortinet Firewall Usage (+7.x)

Go to **Security Fabric > External Connectors** and click Create New.
In the **Threat Feeds** section, click IP Address.
Set the **Name** to the Blocklist.
Set the **URI** to:
**https://raw.githubusercontent.com/troublestarter/blacklistips/main/blacklist.txt**
Click OK and validate.

---

## ⚙️ How blacklist.txt is generated

* Use multiple external lists `ExternalLists.txt` and your custom `custom-blacklist.txt`
* Clean data
* Deduplicate entries
* Remove whitelist entries from `custom-whitelist.txt`
* Generate `blacklist.txt`
* Optimize IPs included in CIDRs

---

## 📂 Repository Content

* `blacklist.txt`
* `count.txt`
* `custom-blacklist.txt`
* `custom-whitelist.txt`
* `ExternalLists.txt`
* `LICENSE`
* `README.md`

---

## ⚠️ Disclaimer

* False positives may occur
* IPs may be dynamic
* Depends on external sources

---

## 🤝 Contribution

Contributions are welcome via Pull Requests and Issues.

---

## 📄 License

GPL v3

---

# 🇫🇷 Version Française

## 📑 Sommaire

* [📌 Description](#description-1)
* [🚀 Utilisation rapide](#utilisation-rapide)
* [🚀 Utilisation Sophos XGS](#utilisation-sophos-xgs)
* [🚀 Utilisation Fortinet](#utilisation-fortinet-firewall-7x)
* [⚙️ Génération du fichier](#generation-du-fichier-blacklisttxt)
* [📂 Contenu](#contenu)
* [⚠️ Avertissement](#avertissement)
* [🤝 Contribution](#contribution-1)
* [📄 Licence](#licence)

---

## 📌 Description

Ce dépôt fournit une blacklist d’IP et de réseaux (CIDR) suspects ou malveillants.

---

## 🚀 Utilisation rapide

Utilisez directement :

https://raw.githubusercontent.com/troublestarter/blacklistips/main/blacklist.txt

---

## 🚀 Utilisation Sophos XGS

Ajoutez la source dans :

**Protect → Active Threat Response → Third-Party Threat Feeds**

---

## 🚀 Utilisation Fortinet Firewall (+7.x)

Accédez à **Security Fabric > Connecteurs externes**
Ajoutez un flux IP avec :

**https://raw.githubusercontent.com/troublestarter/blacklistips/main/blacklist.txt**

---

## ⚙️ Génération du fichier blacklist.txt

* Agrégation de sources
* Nettoyage
* Déduplication
* Application whitelist

---

## 📂 Contenu

* blacklist.txt
* count.txt
* custom files

---

## ⚠️ Avertissement

* Faux positifs possibles
* IP dynamiques

---

## 🤝 Contribution

Contributions bienvenues.

---

## 📄 Licence

GPL v3
