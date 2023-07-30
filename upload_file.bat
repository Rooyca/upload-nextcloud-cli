@echo off

REM change size of screen and color to green
mode con: cols=100 lines=30
color 0a

REM set "curl_executable=C:\ProgramData\chocolatey\bin\curl.exe"

REM Check if the number of arguments is not equal to 2
if "%~2" == "" (
    echo ERROR: Es necesario un nombre de archivo, un username y una IP.
    exit /b 1
)

set "file_path=%1"
set "username=%2"
set "url=https://%3/public.php/webdav/%file_path%"

curl -k -v -T "%file_path%" -u "%username%:" -H "X-Requested-With: XMLHttpRequest" "%url%"

echo.
echo ============================
echo =                          =
echo = El archivo se ha subido. =
echo =                          =
echo ============================
echo.

echo Presione una tecla para continuar...
pause > nul
color 07
cls