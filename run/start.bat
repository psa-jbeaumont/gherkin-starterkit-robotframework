@echo off
REM Vérifier si un argument a été passé
if "%1"=="" (
    echo Usage: start.bat ^<TAG^> [--web ^<selenium^|playwright^|dry-run^>] [--headless] [--history]
    echo.
    echo Examples:
    echo   start.bat TNR
    echo   start.bat smoke --web selenium
    echo   start.bat regression --web playwright --headless --history
    echo.
    exit /b 1
)


cd %cd%
REM Définit le répertoire de travail (compatible Jenkins)
set WORKSPACE=%cd%/run/workspace

REM Récupère le chemin de base
set "PATH2RESOURCE=%cd%/resources/socle"

REM Valeurs par défaut des options
set WEB_DRIVER=dry-run
set HEADLESS_MODE=false
set HISTORY_MODE=false

REM Parcours tous les arguments
set "TAG=%~1"
shift

:parse_args
if "%~1"=="" goto args_done

if /i "%~1"=="--web" (
    set "WEB_DRIVER=%~2"
    shift
) else if "%~1"=="--headless" (
    set HEADLESS_MODE=true
) else if "%~1"=="--history" (
    set HISTORY_MODE=true
)

shift
goto parse_args

:args_done

REM Choix du répertoire selon WEB_DRIVER
set "PATH2RESOURCE=%PATH2RESOURCE%;%PATH2RESOURCE%/%WEB_DRIVER%"

REM Construire la commande robot
set ROBOT_OPTS=--parser GherkinParser ^
  --outputdir %WORKSPACE% ^
  --include %TAG% ^
  --language fr ^
  --loglevel TRACE ^
  --variablefile %WORKSPACE%\settings.yaml ^
  --variable HEADLESS_MODE:%HEADLESS_MODE% ^
  --variable HISTORY_MODE:%HISTORY_MODE% ^
  --pythonpath %PATH2RESOURCE%

REM Ajouter timestampoutputs si HISTORY_MODE est activé
if "%HISTORY_MODE%"=="true" (
    set "ROBOT_OPTS=%ROBOT_OPTS% --timestampoutputs"
)

python ^
  -m robot ^
  %ROBOT_OPTS% ^
  %cd%\features