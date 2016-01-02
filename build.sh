#!/bin/sh

print_error() {
	echo $1
	exit 1
}

cleanup_file() {
	while [ $# -ne 0 ]; do
		if [ -f "$1" ]; then
			echo "   remove file '$1'"
			rm "$1"
		fi
		shift
	done
}

# JDK_HOME must point to the root of a JDK installation
JDK_HOME=~/bin/jdk1.7.0

# GPP_BIN must point to the g++ executable
GPP_BIN=/usr/bin/g++

# add JDK and MinGW tools directories to the executable search path
PATH=${JDK_HOME}/bin:${PATH}

echo "check JDK_HOME ..."
[ ! -x "${JDK_HOME}/bin/javac" ] && print_error "ERROR '${JDK_HOME}' does not point to a JDK home directory"

echo "check g++ ..."
[ ! -x "${GPP_BIN}" ] && print_error "ERROR '${GPP_BIN}' does not point to a g++ executable"

echo "cleanup ..."
cleanup_file GetCwd.class GetCwd.h libGetCwd.so

echo "compile Java source ..."
${JDK_HOME}/bin/javac GetCwd.java
[ $? -ne 0 ] && print_error "ERROR compilation of Java source failed"

echo "generate JNI header file ..."
${JDK_HOME}/bin/javah -jni GetCwd
[ $? -ne 0 ] && print_error "ERROR generation of JNI header file failed"

echo "compile the library ..."
${GPP_BIN} -Wall -O0 -o libGetCwd.so -shared -fPIC -I. -I${JDK_HOME}/include -I${JDK_HOME}/include/linux GetCwd.cpp
[ $? -ne 0 ] && print_error "ERROR library compilation failed"
