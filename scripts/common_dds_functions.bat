:: This file set the environment for DDS middlewares
goto %*

:: This function sets the RTI DDS version.
:: @param The version of RTI DDS to be set.
:setRTIversion
:: Save old and set NDDSHOME environment variable.
set DDSVERSION_NDDSVERSION_OLD=%NDDSVERSION%
set DDSVERSION_NDDSHOME_OLD=%NDDSHOME%
set NDDSVERSION=%2
for /d %%I in ("%NDDSHOME%") do set NDDSHOME=%%~dpI%NDDSVERSION%

:: Save old and set PATH environment variable.
set DDSVERSION_PATH_OLD=%PATH%
set PATH=%NDDSHOME%\scripts;%PATH%

goto :EOF

:: This function sets the RTI DDS target. Execute it after :setRTIversion
:: @param The target that will be set
:setRTItarget
:: Save old NDDSTARGET and set new.
set DDSTARGET_NDDSTARGET_OLD=%NDDSTARGET%
set NDDSTARGET=%2

:: Save old and set PATH environment variable.
set DDSTARGET_PATH_OLD=%PATH%
set PATH=%NDDSHOME%\lib\%NDDSTARGET%;%PATH%
goto :EOF

:: This function restore old RTI DDS version.
:restoreRTIversion
:: Restore old value of NDDSHOME environment variable.
set NDDSHOME=%DDSVERSION_NDDSHOME_OLD%
set NDDSVERSION=%DDSVERSION_NDDSVERSION_OLD%
:: Restore old value of PATH environment variable.
set PATH=%DDSVERSION_PATH_OLD%

goto :EOF

:: This function restore old RTI DDS target. Execute it before :restoreRTIversion
:restoreRTItarget
:: Restore old value of NDDSTARGET environment variable.
set NDDSTARGET=%DDSTARGET_NDDSTARGET_OLD%
:: Restore old value of PATH environment variable.
set PATH=%DDSTARGET_PATH_OLD%

goto :EOF
