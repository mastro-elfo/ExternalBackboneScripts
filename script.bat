@echo off
setlocal enabledelayedexpansion

call :basename
call :config
if "%1"=="loop" ( call :loop 
) else ( call :main )
EXIT /b

:main
REM Main procedure
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

:rTrim string char max -- strips white spaces (or other characters) from the end of a string
::                     -- string [in,out] - string variable to be trimmed
::                     -- char   [in,opt] - character to be trimmed, default is space
::                     -- max    [in,opt] - maximum number of characters to be trimmed from the end, default is 32
:$created 20060101 :$changed 20080219 :$categories StringManipulation
:$source http://www.dostips.com
SETLOCAL ENABLEDELAYEDEXPANSION
call set string=%%%~1%%
set char=%~2
set max=%~3
if "%char%"=="" set char= &rem one space
if "%max%"=="" set max=32
for /l %%a in (1,1,%max%) do if "!string:~-1!"=="%char%" set string=!string:~0,-1!
( ENDLOCAL & REM RETURN VALUES
    IF "%~1" NEQ "" SET %~1=%string%
)
EXIT /b

:lTrim string char -- strips white spaces (or other characters) from the beginning of a string
::                 -- string [in,out] - string variable to be trimmed
::                 -- char   [in,opt] - character to be trimmed, default is space
:$created 20060101 :$changed 20080227 :$categories StringManipulation
:$source http://www.dostips.com
SETLOCAL ENABLEDELAYEDEXPANSION
call set "string=%%%~1%%"
set "charlist=%~2"
if not defined charlist set "charlist= "
for /f "tokens=* delims=%charlist%" %%a in ("%string%") do set "string=%%a"
( ENDLOCAL & REM RETURN VALUES
    IF "%~1" NEQ "" SET "%~1=%string%"
)
EXIT /b

:Trim string char max -- strip white spaces (or other characters) from the beginning and end of a string
::                    -- string [in,out] - string variable to be trimmed
::                    -- char   [in,opt] - character to be trimmed, default is space
::                    -- max    [in,opt] - maximum number of characters to be trimmed from the end, default is 32
:$created 20060101 :$changed 20080219 :$categories StringManipulation
:$source http://www.dostips.com
call:lTrim "%~1" "%~2"
call:rTrim "%~1" "%~2" "%~3"
EXIT /b
