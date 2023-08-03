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
echo  Archivo: %file_path%            
echo  Usuario: %username%             
echo  IP: %ip%                        
echo  Nombre de archivo: %file_name%  
echo =================================
echo.
echo Por favor actualice toda la informacion necesaria
echo.
echo --------------------------------
echo 0. Usar CURL con Chocolatey
echo 1. Directorio del archivo
echo 2. Nombre de usuario
echo 3. IP 
echo 4. Nombre de archivo (OPCIONAL)
echo --------------------------------
echo 5. Subir archivo
echo 6. Salir
echo --------------------------------

set /p choice=Ingrese el numero de la opcion deseada: 
echo.

if "%choice%"=="0" (
    set "curl_executable=C:\ProgramData\chocolatey\bin\curl.exe"
    set "url=https://%ip%/public.php/webdav/%file_name%"
    start /wait %curl_executable% -k -v -T "%file_path%" -u "%username%:" -H "X-Requested-With: XMLHttpRequest" "%url%"
    pause
    goto menu
) else if "%choice%"=="1" (
    set /p file_path=Ingrese el directorio del archivo: 
    pause
    goto menu
) else if "%choice%"=="2" (
    set /p username=Ingrese el nombre de usuario: 
    pause
    goto menu
) else if "%choice%"=="3" (
    set /p ip=Ingrese la IP: 
    pause
    goto menu
) else if "%choice%"=="4" (
    set /p file_name=Ingrese el nombre de archivo: 
    pause
    goto menu
) else if "%choice%"=="5" (
    if "%file_path%" == "" (
        goto menu
    )
    echo Subiendo archivo...
    goto upload
) else if "%choice%"=="6" (
    echo Saliendo...
    goto exit
) else (
    echo Opcion inválida. Por favor, ingresa un numero válido del 1 al 6.
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
