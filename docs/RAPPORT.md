# Rapport de livraison — Regolith Finder 1.0 (15 novembre 2026)

Ce rapport dit ce qui est fait, ce qui ne l'est pas, et ce qui a été réellement exécuté.

## 1. Point de départ

Le cahier des charges demande d'auditer et de préserver l'application d'origine (`index.html`, `script.js`,
`style.css`, texture `moon_hd.jpg`). **Ces fichiers n'ont pas été fournis** : seuls une capture d'écran
(`materiau.webp`), le logo, trois maquettes et la description écrite étaient disponibles. L'application a
donc été réécrite pour retrouver les fonctions décrites, sans pouvoir reprendre le code existant. Les
fonctions internes citées (`evalProvinces`, `lolaColor`, `buildLunarDataGrids`…) n'ont pas été recréées :
les calques illustratifs qu'elles produisaient sont remplacés par des données réelles (voir § 3).

## 2. Fonctions de l'application d'origine retrouvées

| Fonction décrite | État |
|---|---|
| Globe Three.js, sphère 256 × 256, texture avec repli, filtrage anisotrope, OrbitControls, transitions | Fait (texture NASA SVS 4k, repli 2k) |
| Fond de 2 000 étoiles ; groupes Lune, Terre, Soleil | Fait |
| Sites historiques (Apollo 11, 12, 15, 17, Luna 21, Chang'e 5) et régions Artemis | Fait ; coordonnées historiques reprises des valeurs publiées, faute du code d'origine |
| Marqueurs colorés par type, sélection par clic et par menu, transitions de caméra | Fait |
| Calques Topographie, Température, Matériaux (H₂O, FeO, TiO₂, Al + Ca, SiO₂) avec légendes | Fait, avec des données réelles à la place des distributions illustratives |
| Soleil et Terre, trajectoires, point subsolaire (Astronomy Engine) | Fait ; directions exactes, distances non à l'échelle (signalé) |
| Date/heure UTC, « Maintenant », lecture, vitesses 1× à 100 000× | Fait, plus 1 000 000× |
| Cube d'orientation (face visible, face cachée, pôles, Est 90°, Ouest 90°), vue système de dessus | Fait |
| Boutons History, Data, About the founders, Plan lunar mission, Tutorial | Fait : chacun ouvre une vraie fonction |

## 3. Ce qui a été ajouté

- **Tour d'horizon** : silhouette du relief LOLA sur 360°, Soleil et Terre à leur taille angulaire, leurs
  trajectoires sur un jour lunaire, temps avant le coucher du Soleil et avant la perte de la Terre.
- **Carte 2D du pôle Sud** avec ombres portées calculées en direct sur la carte graphique, à la date
  choisie, courbure de la Lune comprise ; calque « Terre visible à la date » calculé de la même façon.
- **Indicateurs par site** : % du temps avec Soleil, plus longue nuit, % du temps avec la Terre, plus
  longue coupure, fenêtres communes, énergie relative d'un panneau vertical ou horizontal.
- **Points favorables** de chaque région Artemis III (meilleur ensoleillement, meilleure vue de la Terre,
  meilleur compromis) d'après les cartes moyennes de la NASA.
- **Comparaison** de 3 scénarios (sites ou dates), tableau, radar, chronologie, export CSV, tableau des
  9 régions, pondération réglable.
- **Dimensionnement énergétique** : stockage pour la plus longue nuit, solaire, fission, hybride.
- **Données réelles embarquées** (provenance dans `public/data/manifest.json`) : relief LOLA 240 m,
  ensoleillement moyen, visibilité moyenne de la Terre et ombres permanentes (NASA PGDA), températures
  Diviner (maximum, minimum, moyenne), composition Lunar Prospector GRS, hydrogène Lunar Prospector,
  relief global LOLA, carte en couleurs LROC, 1 072 noms de l'UAI.
- **Serveur local** sans dépendance, **vérification en direct avec JPL Horizons**, catalogue de 20 sources,
  cache sur disque.
- Import GeoJSON et CSV, outil de mesure avec profil altimétrique, recherche de cratères et de
  coordonnées, français/anglais, 3 modes daltoniens, modes simplifié et expert, tutoriel, mode démonstration.

## 4. Écarts assumés par rapport au cahier des charges

| Demande | Ce qui est livré | Pourquoi |
|---|---|---|
| React, TypeScript, Tailwind, Recharts, Lucide | Modules JavaScript natifs, CSS, graphiques SVG et icônes maison | Aucune compilation : un zip, un double-clic, modifiable à la main pendant le hackathon. Le cahier des charges les donnait comme « recommandés ». |
| « 9 sites officiels d'atterrissage d'Artemis III », « classement officiel » | 9 **régions candidates**, matrice étiquetée « hypothèse de l'équipe » | La NASA a annoncé des régions candidates (28/10/2024), pas des sites ni un classement. Depuis le 27/02/2026, Artemis III est un vol d'essai en orbite terrestre ; l'alunissage est prévu avec Artemis IV (début 2028), sur ces mêmes régions (page NASA d'Artemis IV, relue le 15/11/2026). |
| Coordonnées des régions données dans le prompt | Contours relevés sur la carte de la NASA (précision ≈ 1 km) | Plusieurs valeurs du prompt étaient fausses de 10 à 25 km (Haworth « 5°O » : mesuré 22,8°O ; de Gerlache Rim 2 « 87°O » : mesuré 64,6°O). |
| Score global de la matrice | Recalculé par une formule explicite | Les scores annoncés ne correspondent pas à une moyenne simple ; des poids qui les reproduisent à 0,03 près sont proposés et modifiables. |
| Téléchargement automatique des archives NASA à la demande | Données embarquées ; en ligne : Horizons et quelques produits de référence | Les archives sont de gros fichiers sans API de requête par point ; embarquer garantit le fonctionnement sans réseau. |
| Radiation (flux, dose, atténuation de 3 à 20 %) | Part du ciel cachée par le relief (géométrie calculée) ; 1,3 mSv/j affiché comme hypothèse | Aucune donnée de dose publique intégrée ; pas de modèle d'atténuation inventé. |
| Hélium-3 | Non affiché | Aucune carte publique intégrée. |
| Import GeoTIFF, NetCDF, HDF5, FITS, modèles 3D | Non pris en charge, dit dans l'interface | Il faut des lecteurs binaires et un géoréférencement fiables. |
| Courbure, orientation, mesure de surface | Pente, orientation de la pente, distances, profils | Courbure et surfaces de polygones non faites. |
| Historique des observations Diviner dans le temps | Cartes maximum, minimum, moyenne sur 2009-2019 ; température à la date = modèle | Les observations brutes datées font des dizaines de Go. |
| IndexedDB, workers | Cache IndexedDB pour les réponses en ligne ; pas de worker | Les calculs lourds durent moins d'une demi-seconde ; les ombres sont calculées sur la carte graphique. |

## 5. Limites à connaître

1. **Relief à 240 m par pixel.** Les pentes et l'horizon proche sont lissés : un atterrisseur est sensible à
   quelques mètres. Les meilleurs sites réels (crêtes étroites) sont sous-estimés.
2. **Carte polaire jusqu'à 75°S, températures Diviner jusqu'à 80°S.** Ailleurs : horizon de la sphère
   lisse, pas de pente, pas de produit polaire. C'est dit dans la fiche du site.
3. **Température à la date = modèle simplifié**, pas une mesure.
4. **Notes « calculées »** : règles simples et discutables (`science/scoring.js`), à présenter comme telles.
5. **Régions Artemis** : contours relevés sur une image ; la projection de cette image est supposée
   stéréographique.
6. **Dimensionnement énergétique** : pré-dimensionnement ; les ordres de grandeur cités (ISS, Fission
   Surface Power, Kilopower) n'ont pas été revérifiés en ligne pour cette version.
7. **Jamais essayé sur un vrai Windows ni sur une vraie carte graphique** : tous les essais ont tourné sur
   Linux, dans Chromium sans écran avec un rendu WebGL logiciel. `start.bat` n'a jamais été exécuté.
8. Firefox, Safari, lecteur d'écran, écran tactile réel : non testés.

## 6. Tests exécutés

À relancer depuis la racine. Tests navigateur : voir la recette dans `docs/ARCHITECTURE.md`.

| Test | Ce qu'il vérifie | Résultat |
|---|---|---|
| `node tests/ephemeris-vs-horizons.mjs` | Soleil et Terre contre JPL Horizons | OK : 0,004° en azimut, 0,002° en élévation sur le site du test |
| `node tests/engine.test.mjs` | Moteur : fenêtres, Apollo 11, prochains levers/couchers | OK : Apollo 11 51 % de Soleil, nuit 14,7 j quel que soit le début de période, levers/couchers identiques à la recherche de référence |
| `node tests/validation-pgda.mjs` | Calcul contre les cartes NASA PGDA, 150 points | OK : corrélation 0,996, écart moyen 1,1 point (Soleil) ; 0,994 et 1,9 point (Terre) |
| `node --test tests/energy.test.mjs` | Calcul énergétique | 29 sur 29 |
| `node tests/tools.test.mjs` | Lecture GeoJSON/CSV, mesures | 30 sur 30 (343 contrôles) |
| `node tests/server.test.mjs` | Serveur local, sécurité, appel réel à Horizons | 26 sur 26, dont un appel réel à JPL Horizons |
| `tools/.venv/bin/python tools/test_data.py` | Intégrité et alignement des données | 7 sur 7 |
| `tests/e2e.browser.mjs` | Parcours complet avec le vrai serveur | 22 sur 22 |
| `tests/map2d.browser.mjs` | Carte 2D, shader contre calcul de référence | 64 sur 64 (shader contre calcul de référence : 180 cas sur 180) |
| `tests/sky-timebar.browser.mjs` | Tour d'horizon, barre de temps | 84 sur 84 |
| `tests/globe.browser.mjs` | Globe, calage de la texture | 47 sur 47 |
| `tests/compare.browser.mjs` | Comparaison | 94 contrôles, tous verts |
| `tests/energy.browser.mjs` | Fenêtre Énergie | 152 contrôles, tous verts |
| `tests/datacenter.browser.mjs` | Écran Données | 15 étapes sur 15 |
| `tests/tools.browser.mjs` | Import, mesure, fenêtres, démo | 34 étapes sur 34 (346 contrôles), dont un cycle complet du mode démonstration |

Les suites navigateur ont toutes été relancées sur le code assemblé le 15/11 après les corrections, sauf
mention. Elles tournent dans Chromium sans écran, avec un rendu WebGL logiciel.

## 7. Relectures indépendantes

Deux relectures ont été faites par des agents qui n'avaient pas écrit le code.

**Relecture scientifique** (lecture seule, scripts dans `tests/review/`). Confirmé juste : éphémérides contre
JPL Horizons sur 4 sites, horizon contre un calcul brut à 50 m (écart moyen 0,006°), pente, part du disque
solaire, intégrité des 17 fichiers de données, 1 436 clés de traduction présentes dans les deux langues.
Trouvé et corrigé : la « plus longue nuit » coupée par les bords de la période (7,4 j affichés pour 14,7 j
réels), un champ solaire aberrant dans le module Énergie, des étiquettes de provenance fausses, la
précision annoncée trop optimiste, le statut d'Artemis III périmé, plusieurs faits historiques.

**Parcours « jury »** dans le navigateur, avec de vrais clics (scripts dans `tests/jury/`) : les 7 objectifs
du défi NASA sont atteints, aucun défaut bloquant. Corrigé ensuite : curseur d'opacité des calques,
navigation absente à 1280 px, message au 4e scénario, réglages qui ne suivaient pas la langue.

**Relevé par le jury et non corrigé dans cette version** (par manque de temps, aucun n'est bloquant) :

1. La fiche d'une région ne tient pas sur un écran : le temps avant le coucher du Soleil est sous le pli à
   1440 × 900. Une ligne de synthèse en tête de fiche réglerait cela.
2. Le mode Simplifié n'allège presque pas la fiche (toutes les sections restent).
3. Un clic dans le carré d'une région non sélectionnée choisit le centre de la région, pas le point cliqué.
   Pour étudier un point précis : cliquer une seconde fois, ou saisir les coordonnées dans la recherche.
4. Rien n'est gardé au rechargement de la page (site, date, scénarios) hormis les préférences ; pas de
   lien partageable.
5. Pas de liste datée des fenêtres (début, fin, durée) : seulement les bandes de la barre de temps, les
   pourcentages, la plus longue coupure et le prochain changement.
6. Comparer : en « même site, autres dates », les trois cartes ont le même en-tête (la date est en bas) ;
   pas de bouton « décaler de N jours » ni « déplacer de N km ».
7. Mineurs : le focus du clavier sort des fenêtres modales ; la lecture sous le curseur ne donne pas la
   valeur du calque actif ; des étiquettes de la carte se chevauchent en vue d'ensemble ; à 1 000 000× la
   lecture saccade ; le champ de date suit le format du navigateur ; en anglais, les titres du manifeste
   de données restent en français.

