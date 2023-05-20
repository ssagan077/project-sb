@echo off
IF "%~1"=="" (
   echo 'There is no parameters. Must be client name!'
   Exit /B
)

set Client="%~1"

openfiles >nul 2>&1
if %ErrorLevel% equ 0 (
  echo OK you are Administrator 
) else (
  echo Please, run this script as Administrator. Exiting...
  Exit /B 
)

rem Looking for OpenVPN directory

set OVPNPath=""
@FOR /f "tokens=3*" %%i in ('Reg Query "HKEY_LOCAL_MACHINE\SOFTWARE\OpenVPN" /ve 2^>Nul') do Set "OVPNPath=%%j"
If defined OVPNPath (
  echo OVPNPATH="%OVPNPath%" 
) Else (
  echo "OVPNPATH NOT FOUND !!!"
  Exit /B
)

rem Checking if easy-rsa installed

IF EXIST "%OVPNPath%\easy-rsa\" (
    echo OK Directory OpenVPN exists
    copy vars_tmpl "%OVPNPath%\easy-rsa\"
    copy make_req.sh "%OVPNPath%\easy-rsa\"
) ELSE (
    echo 'Directory "%OVPNPath%\easy-rsa\" Not EXIST' 
    Exit /B 1
)

cd /D "%OVPNPath%\easy-rsa\"
rem Automatically set PATH to openssl.exe
FOR /F "tokens=2*" %%a IN ('REG QUERY "HKEY_LOCAL_MACHINE\SOFTWARE\OpenVPN" /v bin_dir') DO set "PATH=%PATH%;%%b"

bin\sh.exe make_req.sh "%Client%"