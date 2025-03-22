@echo off

setlocal EnableDelayedExpansion

REM change size of screen and color to green
mode con: cols=100 lines=30
color 0a

REM Variables
set "file_path="
set "username="
set "ip="
for %%A in ("%file_path%") do set "file_name=%%~nxA"

for /F "tokens=2 delims=: " %%A in (.ip) do (
    set "ip=%%A"
)

for /F "tokens=2 delims=: " %%A in (.user) do (
    set "username=%%A"
)

REM Check if the number of arguments is not equal to 3
if NOT "%~4" == "" (
    set "file_path=%1"
    set "username=%2"
    set "ip=%3"
    set "file_name=%4"
    goto upload
) 

:menu
cls
echo ip: %ip% > .ip
echo us: %username% > .user
echo.
echo =================================
echo  File: %file_path%            
echo  User: %username%             
echo  IP: %ip%                        
echo  Filename: %file_name%  
echo =================================
echo.
echo.
echo --------------------------------
echo 0. Use CURL with Chocolatey
echo 1. File path
echo 2. Username
echo 3. IP 
echo 4. Filename (OPTIONAL)
echo --------------------------------
echo 5. Upload File
echo 6. Exit
echo --------------------------------

set /p choice=Choose an option: 
echo.

if "%choice%"=="0" (
    set "curl_executable=C:\ProgramData\chocolatey\bin\curl.exe"
    set "url=https://%ip%/public.php/webdav/%file_name%"
    start /wait %curl_executable% -k -v -T "%file_path%" -u "%username%:" -H "X-Requested-With: XMLHttpRequest" "%url%"
    pause
    goto menu
) else if "%choice%"=="1" (
    set /p file_path=Enter file path: 
    pause
    goto menu
) else if "%choice%"=="2" (
    set /p username=Enter username: 
    pause
    goto menu
) else if "%choice%"=="3" (
    set /p ip=Enter IP: 
    pause
    goto menu
) else if "%choice%"=="4" (
    set /p file_name=Enter filename: 
    pause
    goto menu
) else if "%choice%"=="5" (
    if "%file_path%" == "" (
        goto menu
    )
    echo Uploading file...
    goto upload
) else if "%choice%"=="6" (
    echo ..Bay, Bay..
    goto exit
) else (
    echo Error. Please, enter a number between 1 and 6.
    pause
    goto menu
)

:upload
set "url=https://%ip%/public.php/webdav/%file_name%"
curl -k -v -T "%file_path%" -u "%username%:" -H "X-Requested-With: XMLHttpRequest" "%url%"
echo.
pause
goto menu

:exit
cls
color 07
exit /b
