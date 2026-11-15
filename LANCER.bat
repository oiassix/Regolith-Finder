@echo off
rem Regolith Finder - lancement sous Windows (double-clic).
rem   1. Node.js 18 ou plus : serveur local complet (server.mjs), qui ouvre le navigateur.
rem   2. Sinon Python 3.7 ou plus : serveur simple, sans les fonctions en ligne.
rem   3. Sinon : explication de ce qu'il faut installer.
rem Texte volontairement sans accents : l'affichage de cmd depend de la page de codes.
chcp 65001 >nul
setlocal
title Regolith Finder
cd /d "%~dp0"

where node >nul 2>nul
if errorlevel 1 goto nonode
node -e "process.exit(Number(process.versions.node.split('.')[0]) >= 18 ? 0 : 1)" >nul 2>nul
if errorlevel 1 goto oldnode
node server.mjs %*
if errorlevel 1 goto failed
goto end

:oldnode
echo.
echo   La version de Node.js installee est trop ancienne : il faut la version 18 ou plus recente.
goto trypython

:nonode
echo.
echo   Node.js n'est pas installe sur cet ordinateur.

:trypython
set "PY="
python -c "import sys; sys.exit(0 if sys.version_info >= (3, 7) else 1)" >nul 2>nul
if not errorlevel 1 set "PY=python"
if defined PY goto python
py -3 -c "import sys; sys.exit(0 if sys.version_info >= (3, 7) else 1)" >nul 2>nul
if not errorlevel 1 set "PY=py -3"
if defined PY goto python
goto nothing

:python
echo.
echo   Lancement avec Python : serveur de fichiers simple.
echo   L'outil fonctionne avec les donnees embarquees.
echo   Fonctions en ligne COUPEES : comparaison a JPL Horizons, test des sources, telechargements.
echo   Pour les activer : installez Node.js, version LTS, depuis https://nodejs.org
echo   puis relancez LANCER.bat.
echo.
%PY% server-lite.py %*
if errorlevel 1 goto failed
goto end

:nothing
echo.
echo   Ni Node.js ni Python 3 n'ont ete trouves.
echo   Installez Node.js, version LTS, depuis https://nodejs.org
echo   en gardant les options proposees, puis double-cliquez de nouveau sur LANCER.bat.
echo.
pause
goto end

:failed
echo.
echo   Le serveur s'est arrete avec une erreur. Le message ci-dessus en donne la raison.
echo   Cas frequent : le dossier a ete deplace sans le sous-dossier "public".
echo.
pause

:end
endlocal
