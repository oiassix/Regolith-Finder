# Lancer et publier Regolith Finder

## Télécharger les fichiers et publier le site sur GitHub Pages

1. Sur GitHub, ouvrez le dépôt `oiassix/Regolith-Finder`, cliquez sur **Code > Download ZIP**, puis décompressez
   l'archive sur votre ordinateur.
2. Créez un dépôt GitHub pour votre copie et ouvrez-le.
3. Dans le dossier téléchargé, ouvrez `public/`. Envoyez sur GitHub **tout le contenu** de ce dossier — notamment
   `index.html` et les dossiers `assets/`, `css/`, `data/`, `js/` et `vendor/` — à la racine du nouveau dépôt.
   Ne téléversez pas le dossier `public/` lui-même.
4. Dans le nouveau dépôt, ouvrez **Settings > Pages**. Sous **Build and deployment**, choisissez **Deploy from a
   branch**, puis sélectionnez la branche `main` et le dossier `/(root)`. Enregistrez.
5. Attendez la publication, puis ouvrez le lien indiqué dans **Settings > Pages**. Pour un dépôt nommé
   `mon-site`, l'adresse ressemble à `https://VOTRE-PSEUDO.github.io/mon-site/`.

Pour mettre à jour le site, téléversez à nouveau dans le dépôt les fichiers modifiés de `public/`. Le lien affiché
dans **Settings > Pages** est celui à partager pour accéder au site.

La version GitHub Pages est statique. La carte, le globe, les données embarquées et les calculs locaux dans le
navigateur sont disponibles. Les fonctions qui nécessitent `server.mjs` — requêtes JPL Horizons en direct,
vérification des sources, téléchargements à la demande et cache disque — restent réservées au lancement local.

## Lancer le projet sur son ordinateur

- **Windows** : double-cliquez sur `start.bat`.
- **macOS ou Linux** : ouvrez un terminal dans le dossier du projet et exécutez `./start.sh`.
- Node.js 18 ou plus récent active toutes les fonctions du serveur local. Sans Node.js, le lanceur essaie
  Python 3.7 ou plus récent ; l'application reste utilisable avec les données embarquées.

Le serveur essaie automatiquement le port 3000 puis les 20 ports suivants s'il est déjà utilisé. L'adresse
réellement choisie s'affiche dans la fenêtre et le navigateur s'ouvre dessus. Pour demander un autre port,
utilisez par exemple `./start.sh --port 9000` ou, sous Windows, `start.bat --port 9000`. Ajoutez
`--no-open` pour afficher l'adresse sans ouvrir automatiquement le navigateur.
