# 🚫 Blacklist IPs

## 📌 Description

Ce repository a pour objectif de centraliser et maintenir une ou plusieurs listes d'adresses IP bannies.

Ces listes peuvent être utilisées pour :

* renforcer la sécurité de serveurs
* bloquer des comportements malveillants
* partager des sources d’IPs à risque

Cette liste est pleinement compatible avec le module **Third-Party threats Feed** des **Sophos XGS**

---

## ⚙️ Contenu

Le dépôt contient différentes listes d’IP classées selon leur usage :

* `blacklist.txt` → liste principale d’IP bannies
* autres fichiers possibles selon les besoins :

  * spam
  * attaques (bruteforce, scans…)
  * bots malveillants

* `ExternalLists.txt` → liste de projets externe concaténées dans le `blacklist.txt`

---

## 🧠 Objectif

Fournir une base simple, exploitable et mise à jour régulièrement pour :

* administrateurs systèmes
* développeurs
* projets de sécurité

---

## 🔄 Mise à jour

Les listes peuvent être :

* mises à jour régulièrement
* enrichies par la communauté
* nettoyées pour éviter les faux positifs

---

## ⚠️ Avertissement

Les IP listées sont considérées comme suspectes ou malveillantes, mais :

* des erreurs sont possibles
* certaines IP peuvent être dynamiques

👉 Utilisez ces listes avec discernement.

---

## 🤝 Contribution

Les contributions sont les bienvenues :

* ajout de nouvelles IP
* signalement d’erreurs
* amélioration des listes
* Fournir un fichier pleinement compatible avec le module **Third-Party threats Feed** des **Sophos XGS**

Merci de créer une **Pull Request**.

---

## 📄 Licence

**GPL v3**
Free pour la vie

---

## 🚀 Exemple d’utilisation

Blocage simple sous Linux (iptables) :

```
for ip in $(cat blacklist.txt); do
  iptables -A INPUT -s $ip -j DROP
done
```

Utiliser dans le module **Third-Party threats Feed** des **Sophos XGS**

```
PROTECT -> ACTIVE THREAT RESPONSE -> THIRD PARTY THREAT FEEDS -> ADD
```
<img width="676" height="452" alt="image" src="https://github.com/user-attachments/assets/71d59ab3-c5de-4486-9ff4-9eaea701e340" />

Indiquer l'URL : https://raw.githubusercontent.com/troublestarter/blacklistips/refs/heads/main/blacklist.txt

---

## 📬 Contact

Pour toute question, problème ou réclamation et exclusion, utilisez les **Issues** du repository.
