0#!/usr/bin/env bash
# Regolith Finder — launch on macOS or Linux:  ./start.sh   (or: bash start.sh)
#   1. Node.js 18 ou plus : serveur local complet (server.mjs), qui ouvre le navigateur.
#   2. Sinon Python 3.7+ : serveur de fichiers ; l'outil fonctionne sans les fonctions en ligne.
#   3. Sinon : explication de ce qu'il faut installer.
# Les options sont transmises à server.mjs (ex. ./start.sh --port 9000 --no-open).
cd "$(dirname "$0")" || exit 1

if command -v node >/dev/null 2>&1; then
  if node -e 'process.exit(Number(process.versions.node.split(".")[0]) >= 18 ? 0 : 1)' 2>/dev/null; then
    exec node server.mjs "$@"
  fi
  echo "Node.js $(node --version) est trop ancien : il faut la version 18 ou plus récente."
fi

PY=""
for c in python3 python; do
  if command -v "$c" >/dev/null 2>&1 && "$c" -c 'import sys; sys.exit(0 if sys.version_info >= (3, 7) else 1)' 2>/dev/null; then PY="$c"; break; fi
done
if [ -n "$PY" ]; then
  echo
  echo "  Node.js 18+ introuvable : lancement avec Python (serveur de fichiers simple)."
  echo "  L'outil fonctionne avec les données embarquées."
  echo "  Fonctions en ligne COUPÉES : comparaison à JPL Horizons, test des sources, téléchargements."
  echo "  Pour les activer : installez Node.js (version LTS, https://nodejs.org) puis relancez ce script."
  echo
  exec "$PY" server-lite.py "$@"
fi

echo
echo "  Ni Node.js (18 ou plus) ni Python 3 n'ont été trouvés sur cette machine."
echo "  Installez Node.js, version LTS : https://nodejs.org"
echo "  puis relancez :  ./start.sh"
echo
exit 1
