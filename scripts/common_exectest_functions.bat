goto %*

:: This function sets the eProsima target
:: @param The target that will be set (i86, x64).
:setTarget
:: Save old EPROSIMA_TARGET and set new.
set EXECTEST_EPROSIMA_TARGET_OLD=%EPROSIMA_TARGET%
set EPROSIMA_TARGET=%2

:: Save old and set PATH environment variable.
set EXECTEST_PATH_OLD=%PATH%
set PATH=%EPROSIMA_LIBRARY_PATH%\lib\proyectos\%EPROSIMA_TARGET%;%PATH%
goto :EOF

:: This function restore old eProsima target.
:restoreTarget
:: Restore old value of EPROSIMA_TARGET environment variable.
set EPROSIMA_TARGET=%EXECTEST_EPROSIMA_TARGET_OLD%
:: Restore old value of PATH environment variable.
set PATH=%EXECTEST_PATH_OLD%
goto :EOF

:: Function to change the PATH environment variable
:: and add the location of a target libraries.
:: @param Expect one parameters, the new directories to be added.
:setTargetPath
:: Check the argument
if "%~2"=="" (
   echo "Usage: setTargetPath <directories>"
   exit /B 65
)
:: Store the previous PATH
set EXECTEST_TARGET_PATH_OLD=%PATH%
:: Add the directories.
set "PATH=%~2;%PATH%"
goto :EOF

:: Function to restore the PATH environment variable after use setTargetPath
:restoreTargetPath
set PATH=%EXECTEST_TARGET_PATH_OLD%
goto :EOF
