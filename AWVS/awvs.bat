@echo off
setlocal enabledelayedexpansion
for /f %%i in (list.txt) do (
  
wvs_console /Scan %%i  /Profile ws_default /SaveFolder c:\scanResults\ /Save
  
rem set /a n+=1
rem echo %%i
  
)