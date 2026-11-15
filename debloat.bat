@echo off
Title Windows 11 Safe Debloat Script
echo ========================================================
echo Running Windows 11 Safe Debloat Script...
echo ========================================================
echo.

:: Check for Administrator privileges
net session >nul 2>&1
if %errorLevel% neq 0 (
    echo Failure: Please run this script as an Administrator!
    pause
    exit /b
)

echo Creating a System Restore Point just in case...
powershell -Command "Enable-ComputerRestore -Drive 'C:\'; Checkpoint-Computer -Description 'BeforeDebloat' -RestorePointType 'MODIFY_SETTINGS'"

echo.
echo Removing consumer bloatware apps safely...

powershell -Command ^
"$apps = @(^
    'Microsoft.3DBuilder',^
    'Microsoft.BingNews',^
    'Microsoft.BingWeather',^
    'Microsoft.GetHelp',^
    'Microsoft.Getstarted',^
    'Microsoft.MicrosoftOfficeHub',^
    'Microsoft.MicrosoftSolitaireCollection',^
    'Microsoft.People',^
    'Microsoft.SkypeApp',^
    'Microsoft.Todos',^
    'Microsoft.YourPhone',^
    'Microsoft.ZuneMusic',^
    'Microsoft.ZuneVideo'^
);^
foreach ($app in $apps) {^
    Get-AppxPackage -AllUsers -Name $app | Remove-AppxPackage -ErrorAction SilentlyContinue^
    Get-AppXProvisionedPackage -Online | Where-Object DisplayName -eq $app | Remove-AppxProvisionedPackage -Online -ErrorAction SilentlyContinue^
    Write-Host 'Processed: $app' -ForegroundColor Green^
}"

echo.
echo ========================================================
echo Debloating process complete! 
echo It is recommended to restart your computer now.
echo ========================================================
pause