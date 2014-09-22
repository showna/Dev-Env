#!/bin/bash

# This file set the environment for DDS middlewares
# @param The version of RTI DDS to be set.
function setRTIversion
{
if [ $# -ne 1 ]; then
	echo "setRTIversion needs one parameters"
fi
DDSVERSION_NDDSVERSION_OLD=$NDDSVERSION
DDSVERSION_NDDSHOME_OLD=$NDDSHOME
NDDSVERSION=$1
NDDSHOME=`dirname $NDDSHOME`/$NDDSVERSION

# Save old and set PATH environment variable.
DDSVERSION_PATH_OLD=$PATH
PATH=$NDDSHOME/scripts:$PATH

return;
}

# This function sets the RTI DDS target. Execute it after :setRTIversion
# @param The target that will be set (i86, x64). It is concatenated with current version of Gcc
function setRTItarget
{
if [ $# -ne 1 ]; then
	echo "setRTITarget needs one parameters"
fi
# Save old NDDSTARGET and set new.
DDSTARGET_NDDSTARGET_OLD=$NDDSTARGET
NDDSTARGET=$1${NDDSTARGET:3}

# Save old and set LD_LIBRARY_PATH environment variable.
DDSTARGET_LD_LIBRARY_PATH_OLD=$LD_LIBRARY_PATH
LD_LIBRARY_PATH=$NDDSHOME/lib/$NDDSTARGET:$LD_LIBRARY_PATH

return;
}

# This function restore old RTI DDS version.
function restoreRTIversion
{
# Restore old value of NDDSHOME environment variable.
NDDSHOME=$DDSVERSION_NDDSHOME_OLD
NDDSVERSION=$DDSVERSION_NDDSVERSION_OLD
# Restore old value of PATH environment variable.
PATH=$DDSVERSION_PATH_OLD

return;
}

# This function restore old RTI DDS target. Execute it before :restoreRTIversion
function restoreRTItarget
{
# Restore old value of NDDSTARGET environment variable.
NDDSTARGET=$DDSTARGET_NDDSTARGET_OLD
# Restore old value of PATH environment variable.
LD_LIBRARY_PATH=$DDSTARGET_LD_LIBRARY_PATH_OLD

return;
}

# This function converts RTI target to EPROSIMA target.
# @param Optional param that will be the variable where the target will be stored. Default variable is "target".
function getEPROSIMAtarget
{
    if [ $# -ge 1 ]; then
        ptarget=$1
    else
        ptarget=target
    fi
    eval $ptarget=${NDDSTARGET:0:((${#NDDSTARGET} - 5))}
}

# This function prints RTI target to EPROSIMA target. Useful for Makefiles.
function printEPROSIMAtarget
{
    target=${NDDSTARGET:0:((${#NDDSTARGET} - 5))}
    echo $target
}

$@
