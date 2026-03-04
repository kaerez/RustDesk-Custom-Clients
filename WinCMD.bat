@echo off

REM Assign the value random password to the password variable
setlocal ENABLEEXTENSIONS ENABLEDELAYEDEXPANSION
set alfanum=ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789
set rustdesk_pw=
for /L %%b in (1, 1, 12) do (
    set /A rnd_num=!RANDOM! %% 62
    for %%c in (!rnd_num!) do (
        set rustdesk_pw=!rustdesk_pw!!alfanum:~%%c,1!
    )
)

REM Get your config string from your Web portal and Fill Below
set rustdesk_cfg="9JCbp5ybj5ibh1GbhtmLkJ3LvozcwRHdoJiOikGchJCLi0TVxgGNUFmS3gzYRZVMrEDMFlXeVFWdVVXS3YHOj1UW4IjQidGb2cGbDhmMiojI5V2aiwiIslmLvNmLuFWbsF2auQmciojI0N3boJye"

REM ############################### Please Do Not Edit Below This Line #########################################

if not exist C:\Temp\ md C:\Temp\
cd C:\Temp\

curl -L "https://github.com/kaerez/RustDesk-Custom-Clients/releases/download/1.4.5-2026-03-04/ksecrd64.exe" -o ksecrd64.exe

ksecrd64.exe --silent-install
timeout /t 20

cd "C:\Program Files\ksecrd64\"
ksecrd64.exe --install-service
timeout /t 20

for /f "delims=" %%i in ('ksecrd64.exe --get-id ^| more') do set rustdesk_id=%%i

ksecrd64.exe --config %rustdesk_cfg%

REM rustdesk.exe --password %rustdesk_pw%

echo ...............................................
REM Show the value of the ID Variable
echo RustDesk ID: %rustdesk_id%

REM Show the value of the Password Variable
echo Password: %rustdesk_pw%
echo ...............................................
