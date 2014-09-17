goto %*

:: Function to get the current version of the product from a version.h header::
:: An optional parameter is the name of the variable that will be set with the version.
:: An optional parameter is the URL where the version.h file is.
:: Return the variable VERSION by default
:getVersionFromCPP
echo Getting version
if "%2" == "" (
    set vervarname=VERSION
) else (
    set vervarname=%2
)

if "%3" == "" (
    set /p VER_TMP=<"include\version.h"
) else (
    if not exist "%3" (
        set errorstatus=1
        echo "Can't find file %3"
        goto :EOF
    )
    set /p VER_TMP=<"%3"
)
set %vervarname%=%VER_TMP:~21,-1%
set errorstatus=0
goto :EOF
