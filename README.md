# 🚫 Blacklist IPs HOW-TO

> 🔄 Automatically updated threat intelligence feed (IP + CIDR)

## 🌐 Select your Languages !

* 🇬🇧 [English Version](#-english-version)
* 🇫🇷 [Version Française](#-version-française)

---

# 🇬🇧 English Version

## 📑 Table of Contents

* [📌 Description](#-description)
* [🚀 Quick Usage (manual)](#-quick-usage-manual)
* [🚀 Sophos XGS Firewall Usage (With MTR)](#-sophos-xgs-firewall-usage-with-mtr)
* [⚙️ How `blacklist.txt` is generated](#️-how-blacklisttxt-is-generated)
* [📂 Repository Content](#-repository-content)
* [⚠️ Disclaimer](#️-disclaimer)
* [🤝 Contribution](#-contribution)
* [📄 License](#-license)

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

https://raw.githubusercontent.com/troublestarter/blacklistips/main/blacklist.txt

Go to **Protect → Active Threat Response → Third-Party Threat Feeds** and add a new source.

<img width="677" height="425" alt="image" src="https://github.com/user-attachments/assets/4f9d1a1b-343a-46fd-9eaf-ace781c69fe9" />

<img width="1490" height="674" alt="image" src="https://github.com/user-attachments/assets/e073473e-6b07-4c91-be24-8cca66d1c4ce" />

---

## ⚙️ How `blacklist.txt` is generated

* Use multiple external lists and your custom `custom-blacklist.txt`
* Clean data
* Deduplicate entries
* Remove whitelist entries from `custom-whitelist.txt`
* Generate `blacklist.txt`
* Optimize IPs included in CIDRs

---

## 📂 Repository Content

* `blacklist.txt` → Final list (IP + CIDR) of malicious actors
* `count.txt` → Total entries in `blacklist.txt`
* `custom-blacklist.txt` → Your own list to inject
* `custom-whitelist.txt` → Your own list to exclude
* `LICENSE` → License
* `README.md` → Documentation

---

## ⚠️ Disclaimer

* False positives may occur
* IPs may be dynamic
* Depends on external sources

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

* [📌 Description](#-description-1)
* [🚀 Utilisation rapide (manuel)](#-utilisation-rapide-manuel)
* [🚀 Utilisation Sophos XGS (MTR)](#-utilisation-sophos-xgs-mtr)
* [⚙️ Génération du fichier `blacklist.txt`](#️-génération-du-fichier-blacklisttxt)
* [📂 Contenu](#-contenu)
* [⚠️ Avertissement](#️-avertissement)
* [🤝 Contribution](#-contribution-1)
* [📄 Licence](#-licence-1)

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

## ⚙️ Génération du fichier `blacklist.txt`

* Utilisation de plusieurs listes externes et du fichier `custom-blacklist.txt`
* Nettoyage des données
* Suppression des doublons
* Suppression des entrées présentes dans `custom-whitelist.txt`
* Génération de `blacklist.txt`
* Suppression des IP incluses dans les CIDR

---

## 📂 Contenu

* `blacklist.txt` → Liste finale (IP + CIDR)
* `count.txt` → Nombre total d’entrées
* `custom-blacklist.txt` → Liste personnalisée à ajouter
* `custom-whitelist.txt` → Liste personnalisée à exclure
* `LICENSE` → Licence
* `README.md` → Documentation

---

## ⚠️ Avertissement

* Faux positifs possibles
* IP dynamiques
* Dépend des sources

---

## 🤝 Contribution

Les contributions sont les bienvenues via Pull Requests et Issues.
Les modifications sont validées avant intégration.

---

## 📄 Licence

GPL v3
