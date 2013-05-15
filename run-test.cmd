@echo off

REM JAVA_HOME should best point to the root of the JDK installation which was used for the
REM source compilation or to a compatible JRE
set JAVA_HOME=C:\PROGRA~1\Java\jdk170

REM it's assumed that this script and GetCwd.class / GetCwd.dll are in the same directory
set TEST_PATH=%~dp0
set CLASS_PATH=%~dp0
set LIBRARY_PATH=%~dp0

echo.
echo ===
echo === 1. test - execute from directory where the test files are stored '%TEST_PATH%'
echo ===
pushd %TEST_PATH%
%JAVA_HOME%\bin\java -cp %CLASS_PATH% -Djava.library.path=%LIBRARY_PATH% GetCwd
popd

echo.
echo ===
echo === 2. test - execute from directory '%ProgramFiles%'
echo ===
pushd "%ProgramFiles%"
%JAVA_HOME%\bin\java -cp %CLASS_PATH% -Djava.library.path=%LIBRARY_PATH% GetCwd
popd

echo.
echo ===
echo === 3. test - execute from directory where the test files are stored '%TEST_PATH%' 
echo ===           and set 'user.dir' as JVM option to 'C:\CAFEBABE'
echo ===
pushd %TEST_PATH%
%JAVA_HOME%\bin\java -cp %CLASS_PATH% -Djava.library.path=%LIBRARY_PATH% -Duser.dir=C:\CAFEBABE GetCwd
popd

echo.
echo ===
echo === 4. test - execute from directory'%ProgramFiles%'
echo ===           and set 'user.dir' as JVM option to 'C:\CAFEBABE'
echo ===
pushd "%ProgramFiles%"
%JAVA_HOME%\bin\java -cp %CLASS_PATH% -Djava.library.path=%LIBRARY_PATH% -Duser.dir=C:\CAFEBABE GetCwd
popd

