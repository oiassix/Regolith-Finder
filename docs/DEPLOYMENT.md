# Lancer et publier Regolith Finder

## Utiliser le site sans télécharger le projet

Une fois GitHub Pages activé pour ce dépôt, le site sera accessible à l'adresse
[https://oiassix.github.io/regolith-finder/](https://oiassix.github.io/regolith-finder/). L'utilisateur ouvre simplement le lien dans
son navigateur : il n'a pas à télécharger ni installer le projet. Le navigateur charge automatiquement les
fichiers du site et les données dont il a besoin.

La version GitHub Pages est statique. La carte, le globe, les données embarquées et les calculs locaux dans le
navigateur sont disponibles. Les fonctions qui nécessitent `server.mjs` — requêtes JPL Horizons en direct,
vérification des sources, téléchargements à la demande et cache disque — restent réservées au lancement local.

## Publier sa propre version sur GitHub Pages, sans ordinateur local

Le moyen le plus simple est de créer un fork directement sur GitHub. Cela copie le projet entre dépôts GitHub,
sans le télécharger sur l'ordinateur.

1. Connectez-vous à GitHub, ouvrez le dépôt `oiassix/regolith-finder` et cliquez sur **Fork**.
2. Dans votre fork, ouvrez **Actions**. Si GitHub propose d'activer les workflows, acceptez.
3. Ouvrez **Settings > Pages** et sélectionnez **GitHub Actions** comme source de déploiement.
4. Ouvrez le workflow **Deploy GitHub Pages** dans **Actions**, cliquez **Run workflow** et choisissez la branche
   `main`. Le workflow publie le contenu du dossier `public/`.
5. À la fin du déploiement, ouvrez `https://VOTRE-PSEUDO.github.io/regolith-finder/`. Remplacez `VOTRE-PSEUDO` par votre
   nom d'utilisateur GitHub. Le lien est aussi affiché dans **Settings > Pages**.

Après cette première configuration, les changements envoyés sur `main` republient automatiquement le site.

### Intégrer le site à un autre dépôt

Copiez le dossier `public/` et le workflow `.github/workflows/pages.yml` dans votre dépôt, en conservant
`public/` à la racine. Si vous placez l'application dans un sous-dossier, modifiez le champ `path` de
`actions/upload-pages-artifact` pour viser ce dossier `public/`. Activez ensuite **Settings > Pages >
GitHub Actions** et exécutez le workflow.

## Lancer le projet sur son ordinateur

- **Windows** : double-cliquez sur `LANCER.bat`.
- **macOS ou Linux** : ouvrez un terminal dans le dossier du projet et exécutez `./lancer.sh`.
- Node.js 18 ou plus récent active toutes les fonctions du serveur local. Sans Node.js, le lanceur essaie
  Python 3.7 ou plus récent ; l'application reste utilisable avec les données embarquées.

Le serveur essaie automatiquement le port 3000 puis les 20 ports suivants s'il est déjà utilisé. L'adresse
réellement choisie s'affiche dans la fenêtre et le navigateur s'ouvre dessus. Pour demander un autre port,
utilisez par exemple `./lancer.sh --port 9000` ou, sous Windows, `LANCER.bat --port 9000`. Ajoutez
`--no-open` pour afficher l'adresse sans ouvrir automatiquement le navigateur.
