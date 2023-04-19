@echo off

:: Check if the script is being run as an administrator
net session >nul 2>&1
if %errorLevel% neq 0 (
    echo You need to run this script as an administrator.
    pause
    exit /b 1
)

:: Prompt the user for confirmation before making changes to the registry
set /p confirm=Are you sure you want to make all apps in the Microsoft Store free? (y/n)
if /i "%confirm%" neq "y" (
    echo Okay, the registry tweak has not been applied.
    pause
    exit /b
)

:: Make changes to the registry to allow free downloads from the Microsoft Store
reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Policy\RestrictedApps" /v "Microsoft.WindowsStore_8wekyb3d8bbwe!App" /t REG_SZ /d "" /f >nul 2>&1
if %errorLevel% neq 0 (
    echo Failed to add registry key. Make sure you have sufficient permissions to modify the registry.
    pause
    exit /b 1
)

reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Policy\RestrictedApps\Microsoft.WindowsStore_8wekyb3d8bbwe!App" /v "DisableStoreAppsInWindows" /t REG_DWORD /d "0" /f >nul 2>&1
if %errorLevel% neq 0 (
    echo Failed to add registry value. Make sure you have sufficient permissions to modify the registry.
    pause
    exit /b 1
)

echo All apps in the Microsoft Store are now free to download! 🤑
pause
exit /b
