# Space Extract 🎙️

Outil en ligne de commande pour télécharger les Spaces Twitter/X en MP3 avec leurs métadonnées.

🏴󠁧󠁢󠁥󠁮󠁧󠁿 English version [here](README_en.md)

## 🛠️ Prérequis

### MacOS
```
    brew install pipenv ffmpeg jq node
```

### Linux (Ubuntu/Debian)
```
    sudo apt-get install pipenv ffmpeg jq nodejs
```

## 📦 Installation

1. **Configuration initiale**
```
    mkdir -p ~/.local/share/space_dl
```

2. **Cloner le dépôt**
```
    git clone https://github.com/GaloisField2718/space-extractor.git
    cd space-extractor
```

3. **Installer les dépendances Python**
```
    pipenv install
```

4. **Configuration de l'environnement**
```
    # Ajouter dans ~/.zshrc ou ~/.bashrc :
    export SPACE_DL_PATH="$HOME/.local/share/space_dl"
    alias space_dl='/usr/local/bin/extract.sh'
    
    # Recharger le shell
    source ~/.zshrc  # ou source ~/.bashrc
```

5. **Installation des fichiers**
```
    cp convert-cookie.js ~/.local/share/space_dl/
    cp extract.sh /usr/local/bin/
    chmod +x /usr/local/bin/extract.sh
```

6. **Configuration du cookie**
    - Installer l'extension "Cookie-editor" ou "Cookiebro" sur Chrome store
    - Aller sur Twitter/X
    - Exporter le cookie en JSON
    - Sauvegarder dans ~/.local/share/space_dl/cookie.json

## 🚀 Utilisation

Pour télécharger un Space :
```
    space_dl "https://x.com/spaces/VOTRE_ID" "nom_fichier_sortie"
```

### Résultats
- MP3 : nom_fichier_sortie.mp3
- Métadonnées : nom_fichier_sortie.metadata.txt

## 📁 Structure
```
    ~/.local/share/space_dl/
    ├── convert-cookie.js
    ├── cookie.json
    └── netscape-cookies.txt

    /usr/local/bin/
    └── extract.sh
```

## ⚠️ Dépannage

- Cookie expiré → Mettre à jour ~/.local/share/space_dl/cookie.json
- Erreur de permission → Vérifier les droits d'extract.sh
- Problème d'environnement → Exécuter pipenv --rm puis pipenv install

## 📝 Notes
- Cookie à mettre à jour toutes les 2 semaines
- Connexion internet stable requise
