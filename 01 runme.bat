@echo off
REM This is simply a CMD launcher to execute powershell scripts as administrator
REM Needed for the pretty unicode header
chcp 65001
title CNS Automate Cleaner x Steven Olsen
color 0a
cls

echo --------------------------------------------------------------------------------
echo -  ██████╗███╗   ██╗███████╗    ██╗██████╗ ██╗  ██╗  ████████╗███████╗██╗  ██╗ -
echo - ██╔════╝████╗  ██║██╔════╝   ██╔╝██╔══██╗╚██╗██╔╝  ╚══██╔══╝██╔════╝██║ ██╔╝ -
echo - ██║     ██╔██╗ ██║███████╗  ██╔╝ ██████╔╝ ╚███╔╝█████╗██║   █████╗  █████╔╝  -
echo - ██║     ██║╚██╗██║╚════██║ ██╔╝  ██╔══██╗ ██╔██╗╚════╝██║   ██╔══╝  ██╔═██╗  -
echo - ╚██████╗██║ ╚████║███████║██╔╝   ██║  ██║██╔╝ ██╗     ██║   ███████╗██║  ██╗ -
echo -  ╚═════╝╚═╝  ╚═══╝╚══════╝╚═╝    ╚═╝  ╚═╝╚═╝  ╚═╝     ╚═╝   ╚══════╝╚═╝  ╚═╝ -
echo --------------------------------------------------------------------------------
echo.
echo We're going to Launch AutomateCleaner.ps1
pause
powershell.exe -NoProfile -ExecutionPolicy Bypass -Command "Start-Process PowerShell -ArgumentList '-NoProfile -ExecutionPolicy Bypass -File ""%~dp0AutomateCleaner.ps1""' -Verb RunAs"