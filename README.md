# 🚫 Blacklist IPs HOW-TO

> 🔄 Automatically updated threat intelligence feed (IP + CIDR)

## 🌐 Select your Language !

* 🇬🇧 [English Version](#-english-version)
* 🇫🇷 [Version Française](#-version-française)

---

# 🇬🇧 English Version

## 📑 Table of Contents

* [📌 Description](#-description)
* [🚀 Quick Usage (manual)](#-quick-usage-manual)
* [🚀 Sophos XGS Firewall Usage (With MTR)](#-sophos-xgs-firewall-usage-with-mtr)
* [🚀 Fortinet Firewall Usage (+7.x)](#-fortinet-firewall-usage-7x)
* [🚀 BunkerWeb WAF Usage](#-bunkerweb-waf-usage)
* [⚙️ How `blacklist.txt` is generated](#-how-blacklisttxt-is-generated)
* [📂 Repository Content](#-repository-content)
* [⚠️ Disclaimer](#-disclaimer)
* [🤝 Contributions and requests for modifications](#-contributions-and-requests-for-modifications)
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

**https://raw.githubusercontent.com/troublestarter/blacklistips/main/blacklist.txt**

Go to **Protect → Active Threat Response → Third-Party Threat Feeds** and add a new source.

<img width="677" height="425" alt="image" src="https://github.com/user-attachments/assets/4f9d1a1b-343a-46fd-9eaf-ace781c69fe9" />

<img width="1490" height="674" alt="image" src="https://github.com/user-attachments/assets/e073473e-6b07-4c91-be24-8cca66d1c4ce" />

---

## 🚀 Fortinet Firewall Usage (+7.x)

Go to **Security Fabric > External Connectors** and click Create New.

In the **Threat Feeds** section, click IP Address.

Set the **Name** to the Blocklist.

Set the **URI** of external resource to
**https://raw.githubusercontent.com/troublestarter/blacklistips/main/blacklist.txt**

Configure the remaining settings as required, then click OK.

Edit the connector, then click View Entries to view the IP addresses in the feed.

<img width="1071" height="530" alt="image" src="https://github.com/user-attachments/assets/54cfe102-9bf0-4a41-9e81-17a089197b94" />

---

## 🚀 BunkerWeb WAF Usage

Go to **Global Settings > Blacklist**

Set the **Blacklist IP/network URLs** with
**https://raw.githubusercontent.com/troublestarter/blacklistips/main/blacklist.txt**

Click **Save**

<img width="1848" height="766" alt="image" src="https://github.com/user-attachments/assets/af25e9ea-7fae-4067-be41-10c88a17c8d2" />

Note : You can also prefer choose the **Services** page for specific setup instead of the Global Settings.

---

## ⚙️ How `blacklist.txt` is generated

* Use multiple external lists `ExternalLists.txt` and your custom `custom-blacklist.txt`
* Clean data
* Deduplicate entries
* Remove whitelist entries from `custom-whitelist.txt`
* Optimize IPs included in CIDRs
* Generate `blacklist.txt`

<img width="561" height="701" alt="workflow-EN" src="https://github.com/user-attachments/assets/d5585d08-7bb5-404a-99a9-161077c7bf79" />

---

## 📂 Repository Content

* `blacklist.txt` → Final list (IP + CIDR) of malicious actors
* `count.txt` → Total entries in `blacklist.txt`
* `custom-blacklist.txt` → Your own list to inject
* `custom-whitelist.txt` → Your own list to exclude
* `ExternalLists.txt` → Externals sources
* `LICENSE` → License
* `README.md` → Documentation

---

## ⚠️ Disclaimer

* False positives may occur
* IPs may be dynamic
* Depends on external sources

---

## 🤝 Contributions and requests for modifications

Contributions are welcome via "Issue" or "Pull requests".
Changes are reviewed before being merged.

---

## 📄 License

GPL v3

---

# 🇫🇷 Version Française

## 📑 Sommaire

* [📌 Description](#-description-1)
* [🚀 Utilisation rapide (manuel)](#-utilisation-rapide-manuel)
* [🚀 Utiliser avec Sophos XGS (MTR)](#-utiliser-avec-sophos-xgs-mtr)
* [🚀 Utiliser avec Fortinet Firewall (+7.x)](#-utiliser-avec-fortinet-firewall-7x)
* [🚀 Utiliser avec BunkerWeb](#-utiliser-avec-bunkerweb)
* [⚙️ Génération du fichier `blacklist.txt`](#-génération-du-fichier-blacklisttxt)
* [📂 Contenu](#-contenu)
* [⚠️ Avertissement](#-avertissement)
* [🤝 Contributions et demandes de modifications](#-contributions-et-demandes-de-modifications)
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

## 🚀 Utiliser Sophos XGS (MTR)

👉 Aucun script nécessaire.

Ajoutez simplement la source suivante :

https://raw.githubusercontent.com/troublestarter/blacklistips/main/blacklist.txt

Puis allez dans :
**Protect → Active Threat Response → Third-Party Threat Feeds**

<img width="677" height="425" alt="image" src="https://github.com/user-attachments/assets/4f9d1a1b-343a-46fd-9eaf-ace781c69fe9" />

<img width="1490" height="674" alt="image" src="https://github.com/user-attachments/assets/e073473e-6b07-4c91-be24-8cca66d1c4ce" />

---

## 🚀 Utiliser Fortinet Firewall (+7.x)

Accédez à **Security Fabric > Connecteurs externes** et cliquez sur Créer.

Dans la section **Flux de menaces**, cliquez sur Adresse IP.

Saisissez le nom « Liste de blocage » dans le champ Nom.

Définissez l'URI sur :
**https://raw.githubusercontent.com/troublestarter/blacklistips/main/blacklist.txt**

Configurez les autres paramètres selon vos besoins, puis cliquez sur OK.

Modifiez le connecteur, puis cliquez sur Afficher les entrées.

<img width="1071" height="530" alt="image" src="https://github.com/user-attachments/assets/54cfe102-9bf0-4a41-9e81-17a089197b94" />

---

## 🚀 Utiliser avec BunkerWeb

Go to **Global Settings > Blacklist**

Set the **Blacklist IP/network URLs** with
**https://raw.githubusercontent.com/troublestarter/blacklistips/main/blacklist.txt**

Click **Save**

<img width="1848" height="766" alt="image" src="https://github.com/user-attachments/assets/af25e9ea-7fae-4067-be41-10c88a17c8d2" />

Note : You can also prefer choose the **Services** page for specific setup instead of the Global Settings.

---

## ⚙️ Génération du fichier `blacklist.txt`

* Utilisation de plusieurs listes externes `ExternalLists.txt` et du fichier `custom-blacklist.txt`
* Nettoyage des données
* Suppression des doublons
* Suppression des entrées présentes dans `custom-whitelist.txt`
* Suppression des IP incluses dans les CIDR
* Génération de `blacklist.txt`

<img width="561" height="701" alt="workflow" src="https://github.com/user-attachments/assets/e8803e1b-0bcb-4a95-9e24-71df4edd1d3a" />


---

## 📂 Contenu

* `blacklist.txt` → Liste finale (IP + CIDR)
* `count.txt` → Nombre total d’entrées
* `custom-blacklist.txt` → Liste personnalisée à ajouter
* `custom-whitelist.txt` → Liste personnalisée à exclure
* `ExternalLists.txt` → sources externes
* `LICENSE` → Licence
* `README.md` → Documentation

---

## ⚠️ Avertissement

* Faux positifs possibles
* IP dynamiques
* Dépend des sources

---

## 🤝 Contributions et demandes de modifications

Les contributions sont les bienvenues via "Issues" ou encore "Pull request".
Les modifications sont validées avant intégration.

---

## 📄 Licence

GPL v3
