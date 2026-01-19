REM @echo off
REM Vérifier si un argument a été passé
if "%1"=="" (
    echo Usage: start.bat ^<TAG^> [--dry-run] [--headless] [--history]
    echo.
    echo Examples:
    echo   start.bat TNR
    echo   start.bat smoke --dry-run
    echo   start.bat regression --headless --history
    echo.
    exit /b 1
)

REM Définit le répertoire de travail (compatible Jenkins)
set WORKSPACE=/deploy/run/workspace

REM Récupère le chemin de base
set "PATH2RESOURCE=/deploy/resources/socle"

REM Valeurs par défaut des options
set DRY_RUN=false
set HEADLESS_MODE=false
set HISTORY_MODE=false

REM Parcours tous les arguments
set "TAG=%~1"
shift

:parse_args
if "%~1"=="" goto args_done

if "%~1"=="--dry-run" (
    set DRY_RUN=true
) else if "%~1"=="--headless" (
    set HEADLESS_MODE=true
) else if "%~1"=="--history" (
    set HISTORY_MODE=true
)

shift
goto parse_args

:args_done

REM Choix du répertoire selon DRY_RUN
if "%DRY_RUN%"=="true" (
    set "PATH2RESOURCE=%PATH2RESOURCE%;%PATH2RESOURCE%/dry-run"
) else (
    set "PATH2RESOURCE=%PATH2RESOURCE%;%PATH2RESOURCE%/real"
)

REM Construire la commande robot
set ROBOT_OPTS=--parser GherkinParser ^
  --outputdir %WORKSPACE% ^
  --include %TAG% ^
  --language fr ^
  --loglevel TRACE ^
  --variablefile %WORKSPACE%/settings.yaml ^
  --variable HEADLESS_MODE:%HEADLESS_MODE% ^
  --variable HISTORY_MODE:%HISTORY_MODE% ^
  --pythonpath %PATH2RESOURCE%

REM Ajouter timestampoutputs si HISTORY_MODE est activé
if "%HISTORY_MODE%"=="true" (
    set "ROBOT_OPTS=%ROBOT_OPTS% --timestampoutputs"
)

REM Exécuter la commande robot avec Podman
cd ..
podman run  ^
  --rm  ^
  -v %cd%/gherkin-starterkit-robotframework:/deploy ^
  --network=host ^
  --env WORKSPACE=%WORKSPACE% ^
  localhost/robot-grid-slim ^
  %ROBOT_OPTS% ^
  features

cd gherkin-starterkit-robotframework
