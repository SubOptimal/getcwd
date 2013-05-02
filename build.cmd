@echo off

REM JDK_HOME must point to the root of a JDK installation
set JDK_HOME=C:\PROGRA~1\Java\jdk170

REM MINGW_HOME must point to the root of a MinGW installation
set MINGW_HOME=M:\opt\MinGW


REM add JDK and MinGW tools directories to the executable search path
set PATH=%JDK_HOME%\bin;%MINGW_HOME%\bin;%PATH%

echo check JDK_HOME ...
if not exist "%JDK_HOME%\bin\javac.exe" call :ERROR '%JDK_HOME%' does not point to a JDK home directory

echo check g++ ...
if not exist "%MINGW_HOME%\bin\g++.exe" call :ERROR '%MINGW_HOME%' does not point to a MinGW home directory

echo cleanup ...
call :CLEAN GetCwd.class GetCwd.h GetCwd.dll

echo compile Java source ...
%JDK_HOME%\bin\javac GetCwd.java
if %errorlevel% neq 0 call :ERROR compilation of Java source failed

echo generate JNI header file ...
%JDK_HOME%\bin\javah -jni GetCwd
if %errorlevel% neq 0 call :ERROR generation of JNI header file failed

echo compile the library ...
%MINGW_HOME%\bin\g++ -Wl,-kill-at -Wall -O0 -o GetCwd.dll -shared -I. -I%JDK_HOME%\include -I%JDK_HOME%\include\win32 GetCwd.cpp 
if %errorlevel% neq 0 call :ERROR library compilation failed

goto :EOF

:CLEAN
if exist %1 echo   remove '%1' && del %1
shift
if "%1" neq "" goto :CLEAN
goto :EOF

:ERROR
echo %*
exit 1