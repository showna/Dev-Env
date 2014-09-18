#!/bin/bash

# This function sets the eProsima target.
# @param The target that will be set (i86, x64). It is concatenated with current version of Gcc
function setTarget
{
if [ $# -ne 1 ]; then
	echo "setTarget needs one parameters"
fi
# Save old EPROSIMA_TARGET and set new.
EXECTEST_EPROSIMA_TARGET_OLD=$EPROSIMA_TARGET
EPROSIMA_TARGET=$1${EPROSIMA_TARGET:3}

# Save old and set LD_LIBRARY_PATH environment variable.
EXECTEST_LD_LIBRARY_PATH_OLD=$LD_LIBRARY_PATH
LD_LIBRARY_PATH=$EPROSIMA_LIBRARY_PATH/proyectos/$EPROSIMA_TARGET:$LD_LIBRARY_PATH

return;
}

# Function to change the LD_LIBRARY_PATH environment variable
# and add the location of a target libraries.
# @param Expect one parameters, the new directories to be added.
function setTargetLibraryPath
{
if [ $# -ne 1 ]; then
	echo "setTargetLibraryPath needs one parameters"
fi
# Store the previous PATH
TARGET_LD_LIBRARY_PATH_OLD=$LD_LIBRARY_PATH
# Add the directories.
LD_LIBRARY_PATH=$1:$LD_LIBRARY_PATH
return;
}

# Function to restore the LD_LIBRARY_PATH environment variable after use setTargetLibraryPath
function restoreTargetLibraryPath
{
LD_LIBRARY_PATH=$TARGET_LD_LIBRARY_PATH_OLD
return;
}

# This function restore old eProsima target.
function restoreTarget
{
# Restore old value of EPROSIMA_TARGET environment variable.
EPROSIMA_TARGET=$EXECTEST_EPROSIMA_TARGET_OLD
# Restore old value of PATH environment variable.
LD_LIBRARY_PATH=$EXECTEST_LD_LIBRARY_PATH_OLD

return;
}

$@
