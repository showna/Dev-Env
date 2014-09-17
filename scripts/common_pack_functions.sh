#!/bin/bash

# @brief Return the version of a product.
# @param Optional param that will be the variable where the version will be stored. Default variable is "version".
# @param Optional param that contains the location of the source file where the version is. Default location "include/version.h"
function getVersionFromCPP
{
    if [ $# -ge 1 ]; then
        pversion=$1
    else
        pversion=version
    fi

    if [ $# -ge 2 ]; then
        file=$2
    else
        file=include/version.h
    fi

    if [ ! -f $file ]; then
        echo "File $file doesn't exit"
        return 1;
    fi

    tmpversion=`head -n 1 $file`
    #Doesn't work in all bash versions
    #eval $pversion=${tmpversion:21: -2}
    #version=${version:21: -2}
    tmpversion=${tmpversion:21}
    eval $pversion=${tmpversion:0:((${#tmpversion} - 1))}
}

# @brief Print the version of a product. Useful for Makefiles.
# @param Takes one parameter. This parameters is optional and is the location
# of the file with the version. Default file "include/version.h"
function printVersionFromCPP
{
    if [ $# -eq 1 ]; then
        file=$1
    else
        file=include/version.h
    fi

    if [ ! -f $file ]; then
        exit -1
    fi

    version=`head -n 1 $file`
    #Doesn't work in all bash versions
    #version=${version:21: -2}
    version=${version:21}
    version=${version:0:((${#version} - 1))}
    echo $version
}

# Return the variable 'gccversion'
function getGccVersion
{
    gcc -v  &> gccversion.txt
    gccversion=`tail -n 1 gccversion.txt | cut -d \  -f 3`
    rm gccversion.txt
    echo GCC version ${gccversion}
}

# Print the Gcc version. Useful for Makefiles.
function printGccVersion
{
    gcc -v  &> gccversion.txt
    gccversion=`tail -n 1 gccversion.txt | cut -d \  -f 3`
    rm gccversion.txt
    echo ${gccversion}
}

# Return the variable 'etarget'
function getTargetFromEprosimaTarget
{
    etarget=${EPROSIMA_TARGET:0:3}
}

# Print the architecture of EPROSIMA_TARGET. Useful for Makefiles.
function printArchFromEprosimaTarget
{
    archposition=`awk -v a="$EPROSIMA_TARGET" -v b="gcc" 'BEGIN{print index(a,b)}'`
    echo ${EPROSIMA_TARGET:0:$archposition - 1}
}

# Return the variable 'distroversion'
function getDistroVersion
{
    # For Redhat based systems
    if [ -e /etc/redhat-release ]; then 
        distroinfo=`cat /etc/redhat-release`
	distroarray=($distroinfo)
	distroversion=${distroarray[0]}${distroarray[2]}
	echo Distro $distroversion
    else
        distroversion=unknown
        echo Distro version ${distroversion}
    fi
}

$@
