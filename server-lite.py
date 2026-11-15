#!/usr/bin/env python3
"""Simple localhost file server used when Node.js 18+ is unavailable."""

import argparse
import errno
import functools
import http.server
import os
from pathlib import Path
import sys
import threading
import webbrowser


PUBLIC = Path(__file__).resolve().parent / "public"
MAX_PORT_TRIES = 20


class Handler(http.server.SimpleHTTPRequestHandler):
    extensions_map = {
        **http.server.SimpleHTTPRequestHandler.extensions_map,
        ".js": "text/javascript",
        ".mjs": "text/javascript",
        ".css": "text/css",
        ".json": "application/json",
        ".svg": "image/svg+xml",
    }

    def __init__(self, *args, **kwargs):
        super().__init__(*args, directory=str(PUBLIC), **kwargs)


def parse_args():
    parser = argparse.ArgumentParser(description="Serve Regolith Finder on localhost.")
    try:
        default_port = int(os.environ.get("PORT", "3000"))
    except ValueError:
        parser.error("PORT must be an integer.")
    parser.add_argument("--port", type=int, default=default_port)
    parser.add_argument("--no-open", action="store_true")
    args = parser.parse_args()
    if not 0 <= args.port <= 65535:
        parser.error("--port must be between 0 and 65535.")
    return args


def create_server(start_port):
    end_port = min(start_port + MAX_PORT_TRIES, 65535)
    ports = (0,) if start_port == 0 else range(start_port, end_port + 1)
    for port in ports:
        try:
            return http.server.ThreadingHTTPServer(("127.0.0.1", port), Handler)
        except OSError as error:
            if error.errno != errno.EADDRINUSE:
                raise
            if port < end_port:
                print(f"Port {port} occupé, essai du {port + 1}.", flush=True)
    raise OSError(f"Aucun port libre entre {start_port} et {end_port}.")


def main():
    args = parse_args()
    try:
        server = create_server(args.port)
    except OSError as error:
        print(f"Impossible de démarrer le serveur Python : {error}", file=sys.stderr)
        return 1
    url = f"http://127.0.0.1:{server.server_port}/"
    print("\n  Regolith Finder — serveur Python simple")
    print(f"  Adresse : {url}")
    print("  Fonctions en ligne indisponibles sans Node.js 18+.")
    print("  Arrêt   : Ctrl+C\n", flush=True)
    if not args.no_open:
        threading.Timer(1, webbrowser.open, args=(url,)).start()
    try:
        server.serve_forever()
    except KeyboardInterrupt:
        print("\nArrêt du serveur.")
    finally:
        server.server_close()
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
