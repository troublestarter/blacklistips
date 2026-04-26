# 🚫 Blacklist IPs HOW-TO

> 🔄 Automatically updated threat intelligence feed (IP + CIDR)

## 🌐 Select your Languages !

- 🇬🇧 [English Version](#-english-version)
- 🇫🇷 [Version Française](#-version-française)

---

# 🇬🇧 English Version

## 📑 Table of Contents

- [📌 Description](#-description)
- [🚀 Quick Usage (manual)](#-quick-usage-manual)
- [🚀 Sophos XGS Firewall Usage (With MTR)](#-sophos-xgs-firewall-usage-with-mtr)
- [⚙️ All information about how is generated the `blacklist.txt` file](#️-all-information-about-blakclist.txt)
- [📂 Repository Content](#-repository-content)
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

---

## 🚀 Sophos XGS Firewall Usage (With MTR)

👉 You **do NOT need the script** to use this project.

Just add the source below:

https://raw.githubusercontent.com/troublestarter/blacklistips/main/blacklist.txt

Go to **Protect → Active Threat Response → Third-Party Threat Feeds** and add a new source.

<img width="677" height="425" alt="image" src="https://github.com/user-attachments/assets/4f9d1a1b-343a-46fd-9eaf-ace781c69fe9" />

<img width="1490" height="674" alt="image" src="https://github.com/user-attachments/assets/e073473e-6b07-4c91-be24-8cca66d1c4ce" />

---

## ⚙️ All information about how is generated the `blacklist.txt` file

- Use many external lists and your custom `custom-blacklist.txt`
- Clean data
- Deduplicate entries
- Delete whitelist records existing in `custom-whitelist.txt`
- Generate `blacklist.txt`
- Optimization of IP addresses that would be contained in CIDRs

---

## 📂 Repository Content

- `blacklist.txt` → Final list (IP + CIDR) of malicious actors
- `count.txt` → total entries in `blacklist.txt` file
- `custom-blacklist.txt` → You own list of IPs or CIDR to inject to final blacklist.txt
- `custom-whitelist.txt` → You own list of IPs or CIDR to exclude to final blacklist.txt
- `LICENSE` → the licence for all files
- `README.md` → This documentation
---

## ⚠️ Disclaimer

- False positives may occur  
- IPs may be dynamic  
- Depends on external sources  

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
- [⚙️ Toutes les informations concernant la génération du fichier `blacklist.txt`](#️-informations-avancées-du-fichier-blakclist.txt)
- [📂 Contenu](#-contenu)
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

## ⚙️ Toutes les informations concernant la génération du fichier `blacklist.txt`

Le script PowerShell sert uniquement à générer la liste :

- Utiliser plusieurs listes externes et votre fichier `custom-blacklist.txt` personnalisé
- Les données sont nettoyées
- Les doublons sont supprimés
- Les enregistrements de la liste blanche présents dans `custom-whitelist.txt` sont supprimés du résultat final
- Génération de `blacklist.txt`
- Les adresses IP contenues dans les CIDR sont supprimées

---

## 📂 Contenu

- `blacklist.txt` → Liste finale (IP + CIDR) des acteurs malveillants
- `count.txt` → Nombre total d'entrées dans le fichier `blacklist.txt`
- `custom-blacklist.txt` → Votre liste d'adresses IP ou de CIDR à ajouter à la liste noire finale
- `custom-whitelist.txt` → Votre liste d'adresses IP ou de CIDR à exclure de la liste noire finale
- `LICENSE` → Licence applicable à tous les fichiers
- `README.md` → Documentation

---

## ⚠️ Avertissement

- Faux positifs possibles  
- IP dynamiques  
- Dépend des sources

---

## 🤝 Contribution

Les contributions sont les bienvenues via Pull Requests et Issues.  
Les modifications sont validées avant intégration.

---

## 📄 Licence

GPL v3
