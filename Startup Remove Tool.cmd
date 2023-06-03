@echo off
cls
title Startup Remover

rem Check if you are an administrator
net session >nul 2>&1

if %ERRORLEVEL% equ 0 (
  goto :admin
) else (
  goto :notadmin
)

:admin
cls

rem Deleting Registry
reg delete HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Run /f
reg delete HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\RunOnce /f
reg delete HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Run /f
reg delete HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\RunOnce /f

rem Regenerate Registry
reg add HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Run /f
reg add HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\RunOnce /f
reg add HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Run /f
reg add HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\RunOnce /f

rem Delete Startup Folder
rd /s /q "%userprofile%\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Startup"
rd /s /q "C:\ProgramData\Microsoft\Windows\Start Menu\Programs\Startup"

rem Done
echo Done! Press any key to close...
pause > nul
exit /b

:notadmin
cls
echo.
echo You must be an administrator to run this tool.
echo Right click on this file and select "Run as administrator".
echo.
pause > nul
exit /b