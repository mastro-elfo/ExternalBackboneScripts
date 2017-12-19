REM This script remove useless files in a project

@echo off
setlocal enabledelayedexpansion

REM External
REM ========
echo Directory External

REM Delete *.out
echo Delete *.out files
del *.out

REM Delete script.bat
echo Delete script.bat file
del script.bat

REM Doc
REM ===
cd ../Doc
echo Directory Doc

REM Delete *.odt
echo Delete *.odt
del *.odt

REM Delete New project.pdf
echo Delete New project.pdf
del "New project.pdf"

REM OutputImages
REM ============
cd ../OutputImages
echo Directory OutputImages

REM Delete all
echo Delete all
for /F "delims=" %%i in ('dir /b') do (rmdir "%%i" /s/q || del "%%i" /s/q)

REM Reports
REM =======
cd ../Reports
echo Directory Reports

REM Delete all
echo Delete all
for /F "delims=" %%i in ('dir /b') do (rmdir "%%i" /s/q || del "%%i" /s/q)

echo Clean complete
pause
