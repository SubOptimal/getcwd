#!/bin/sh

# JAVA_HOME should best point to the root of the JDK installation which was used for the
# source compilation or to a compatible JRE
JAVA_HOME=~/bin/jdk1.7.0

# it's assumed that this script and GetCwd.class / GetCwd.dll are in the same directory
SCRIPT_PATH=`cd \`dirname $0\`; pwd`
TEST_PATH=${SCRIPT_PATH}
CLASS_PATH=${SCRIPT_PATH}
LIBRARY_PATH=${SCRIPT_PATH}
CURR_PATH=`pwd`

echo
echo "==="
echo "=== 1. test - execute from directory where the test files are stored '${TEST_PATH}'"
echo "==="
cd ${TEST_PATH}
${JAVA_HOME}/bin/java -cp ${CLASS_PATH} -Djava.library.path=${LIBRARY_PATH} GetCwd
cd ${CURR_PATH}

echo
echo "==="
echo "=== 2. test - execute from directory '/usr/bin'"
echo "==="
cd /usr/bin
${JAVA_HOME}/bin/java -cp ${CLASS_PATH} -Djava.library.path=${LIBRARY_PATH} GetCwd
cd ${CURR_PATH}

echo
echo "==="
echo "=== 3. test - execute from directory where the test files are stored '${TEST_PATH}'"
echo "===           and set 'user.dir' as JVM option to '/CAFEBABE'"
echo "==="
cd ${TEST_PATH}
${JAVA_HOME}/bin/java -cp ${CLASS_PATH} -Djava.library.path=${LIBRARY_PATH} -Duser.dir=/CAFEBABE GetCwd
cd ${CURR_PATH}

echo
echo "==="
echo "=== 4. test - execute from directory'/usr/bin'"
echo "===           and set 'user.dir' as JVM option to '/CAFEBABE'"
echo "==="
cd /usr/bin
${JAVA_HOME}/bin/java -cp ${CLASS_PATH} -Djava.library.path=${LIBRARY_PATH} -Duser.dir=/CAFEBABE GetCwd
cd ${CURR_PATH}
