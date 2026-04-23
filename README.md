# 🚫 Blacklist IPs

## 📌 Description

Ce repository a pour objectif de centraliser et maintenir une ou plusieurs listes d'adresses IP bannies.

Ces listes peuvent être utilisées pour :

* renforcer la sécurité de serveurs
* bloquer des comportements malveillants
* partager des sources d’IPs à risque

Cette liste est pleinement compatible avec le module Third-Party threats Feed des Sophos XGS

---

## ⚙️ Contenu

Le dépôt contient différentes listes d’IP classées selon leur usage :

* `blacklist.txt` → liste principale d’IP bannies
* autres fichiers possibles selon les besoins :

  * spam
  * attaques (bruteforce, scans…)
  * bots malveillants

* `ExternalLists.txt` → liste de projets externe concaténée dans le `blacklist.txt`

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

Merci de créer une **Pull Request** ou une **Issue**.

---

## 📄 Licence

À définir selon vos besoins (MIT, GPL, etc.)

---

## 🚀 Exemple d’utilisation

Blocage simple sous Linux (iptables) :

```
for ip in $(cat blacklist.txt); do
  iptables -A INPUT -s $ip -j DROP
done
```

---

## 📬 Contact

Pour toute question ou suggestion, utilisez les Issues du repository.
