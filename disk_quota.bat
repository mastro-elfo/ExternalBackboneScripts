@echo off
setlocal enabledelayedexpansion

call :basename
call :config
if "%1"=="loop" ( call :loop
) else ( call :main )
EXIT /b

:main
REM Main procedure
for /f "usebackq delims== tokens=2" %%x in (`wmic logicaldisk where "DeviceID='D:'" get FreeSpace /format:value`) do set FreeSpace=%%x
for /f "usebackq delims== tokens=2" %%x in (`wmic logicaldisk where "DeviceID='D:'" get Size /format:value`) do set Size=%%x
set FreeKB=%FreeSpace:~0,-3%
set SizeKB=%Size:~0,-3%
for /f %%n in ('cscript //nologo eval.vbs "100 * %FreeKB% / %SizeKB%"') do (
	set Percentage=%%n
)
set Percentage=%Percentage:~0,4%
echo %Percentage% to %basename%
echo %Percentage% > %basename%.out
EXIT /b

:basename
REM get basename
set basename=%~n0
EXIT /b

:config
REM load config file
for /F "usebackq eol=[ tokens=* delims=" %%a in ("%basename%.ini") do (
    set "%%a"
)
EXIT /b

:loop
REM count from 1 to 10 with increment 0, i.e. infinite loop
for /L %%n in (1,0,10) do (
	call :main
	call :sleep %DELAY%
)
EXIT /b

:sleep seconds -- waits some seconds before returning
::             -- seconds [in]  - number of seconds to wait
:$created 20060101 :$changed 20080219
:$source http://www.dostips.com
FOR /l %%a in (%~1,-1,1) do (ping -n 2 -w 1 127.0.0.1>NUL)
EXIT /b
