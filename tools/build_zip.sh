#!/usr/bin/env bash
# Construit l'archive à transmettre : livrables/regolith-finder.zip (dossier racine « regolith-finder/ »).
# Contient l'application, les données embarquées, la documentation, les tests et les scripts de préparation ;
# exclut les téléchargements bruts, les environnements et les dossiers de travail.
set -euo pipefail
cd "$(dirname "$0")/.."
OUT=livrables/regolith-finder.zip
mkdir -p livrables
rm -f "$OUT"
python3 - "$OUT" <<'PY'
import os, sys, zipfile
out = sys.argv[1]
EXCL_DIRS = {'.git', '.dev', '.cache', 'livrables', 'node_modules', '.venv', 'raw', 'check', '.out', '__pycache__'}
n = 0
with zipfile.ZipFile(out, 'w', zipfile.ZIP_DEFLATED, compresslevel=6) as z:
    for root, dirs, files in os.walk('.'):
        dirs[:] = sorted(d for d in dirs if d not in EXCL_DIRS)
        for f in sorted(files):
            p = os.path.join(root, f)
            rel = os.path.relpath(p, '.')
            if rel.endswith(('.pyc', '.log')) or f == '.DS_Store':
                continue
            info = zipfile.ZipInfo.from_file(p, os.path.join('regolith-finder', rel))
            if rel in ('start.sh', 'tools/build_zip.sh', 'tools/fetch_raw.sh'):
                info.external_attr = (0o755 & 0xFFFF) << 16
            comp = zipfile.ZIP_STORED if rel.endswith(('.jpg', '.png', '.webp')) else zipfile.ZIP_DEFLATED
            with open(p, 'rb') as fh:
                z.writestr(info, fh.read(), compress_type=comp, compresslevel=6)
            n += 1
print(f'{n} fichiers -> {out} ({os.path.getsize(out) / 1e6:.1f} Mo)')
PY
