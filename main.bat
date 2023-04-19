@echo off
net session >nul 2>&1
if %errorLevel% == 0 (
    echo You are running this script as an administrator.
) else (
    echo You need to run this script as an administrator.
    pause
    exit /b
)

set /p confirm=Are you sure you want to make all apps in the Microsoft Store free? (y/n)
if /i "%confirm%" neq "y" (
    echo Okay, the registry tweak has not been applied.
    pause
    exit /b
)

reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Policy\RestrictedApps" /v "Microsoft.WindowsStore_8wekyb3d8bbwe!App" /t REG_SZ /d "" /f
reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Policy\RestrictedApps\Microsoft.WindowsStore_8wekyb3d8bbwe!App" /v "DisableStoreAppsInWindows" /t REG_DWORD /d "0" /f
echo All apps in the Microsoft Store are now free to download! 🤑
pause
