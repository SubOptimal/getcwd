## HOWTO build/run on Windows (tm) ##

### prerequisites  ###

* Java SE JDK (at least version 1.4) [download from Oracle](http://www.oracle.com/technetwork/java/javase/downloads/index.html)
* MinGW (Minimalist GNU for Windows) [download from project page hosted on sourceforge](http://sourceforge.net/projects/mingw/files/)
* optional: git (PortableGit is prefered, as it needs only to be unpacked) [download from project page hosted on Google](https://code.google.com/p/msysgit/downloads/list)

### build ###

1. get the source from the project page (installation directory refered in the HOWTO as %GETCWD_HOME%)<br />
   either download all files in a zip archive<br />
   or clone the repository with git
2. change into the source directory<br />
   `cd %GETCWD_HOME%`
3. amend in `build.cmd` the setting for<br />
   **set JDK_HOME=**the directory into which you have installed the Java SE JDK<br />
   **set MINGW_HOME=**the directory into which you have installed the MinGW
4. executing `build.cmd` will
   -- compile the Java source
   -- generate the JNI header file
   -- compile the C++ library

### run the test ###

1. change into the source directory<br />
   `cd %GETCWD_HOME%`
2. amend in `run-test.cmd` the setting for<br />
  **set JAVA_HOME=**should point either to the JDK used for the build or to a compatible JRE
3. executing `run-test.cmd` will<br />
  run four tests with combinations of<br />
  -- different JVM invocation directories<br />
  -- set the property "user.dir" programmatically<br />
  -- set the property "user.dir" as JVM option
4. each test will print out the current directory from point of view<br />
  ... of the JVM (respectively the OS)<br />
  ... of the running Java code inside the JVM


## HOWTO build/run on Linux ##

### prerequisites  ###

* Java SE JDK (at least version 1.4) [download from Oracle](http://www.oracle.com/technetwork/java/javase/downloads/index.html)
* GNU C++ compiler, install the recent version from your Linux distribution
* optional: git, install the recent version from your Linux distribution

### build ###

1. get the source from the project page (installation directory refered in the HOWTO as ${GETCWD_HOME})<br />
   either download all files in a zip archive<br />
   or clone the repository with git
2. change into the source directory<br />
   `cd ${GETCWD_HOME}`
3. amend in `build.sh` the setting for<br />
   **JDK_HOME=**the directory into which you have installed the Java SE JDK<br />
   **GPP_BIN=**must point to the g++ executable
4. executing `build.sh` will
   -- compile the Java source
   -- generate the JNI header file
   -- compile the C++ library

### run the test ###

1. change into the source directory<br />
   `cd ${GETCWD_HOME}`
2. amend in `run-test.sh` the setting for<br />
  **JAVA_HOME=**should point either to the JDK used for the build or to a compatible JRE
3. executing `run-test.sh` will<br />
  run four tests with combinations of<br />
  -- different JVM invocation directories<br />
  -- set the property "user.dir" programmatically<br />
  -- set the property "user.dir" as JVM option
4. each test will print out the current directory from point of view<br />
  ... of the JVM (respectively the OS)<br />
  ... of the running Java code inside the JVM
