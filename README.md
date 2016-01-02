# Description #

This project is a JNI (Java Native Interface) library, which returns the directory from which the current JVM was invoked.

The project shows how to create and use an own native method from within Java, using the JNI.

In very short only three (main) steps are needed for the implementation

* write a Java class which declares a native method
* generate a C/C++ header file from the Java class file
* write a C/C++ library which implements the method

After compiling the library you're done and able to use it.

For a more detailed explanation and instructions see the files in this project.


# Intent #

An interesting problem was raised on stack**overflow** [why-does-this-autorun-cmd-registry-hack-affect-a-java-maven-process](http://stackoverflow.com/questions/16249872/why-does-this-autorun-cmd-registry-hack-affect-a-java-maven-process). 

A Windows(tm) registry hack, to change into a specific directory each time a new command line session is started, lead to an unexpected behaviour of a maven test plugin. The plugin was forking a new CMD session to execute the tests.

The behaviour is related to the fact, that simple file operations like exists() always resolve against the directory in which the Java virtual machine was originally invoked. (see also: [Java Bug ID: 4483097](http://bugs.sun.com/bugdatabase/view_bug.do?bug_id=4483097))

short scratch how it comes to this behaviour

- maven is invoked in directory D:\repos\projectA
- the test plugin forks a new CMD process, for which the registry hack switch into directory C:\dev
- for the test plugin the JVM is invoked from directory C:\dev
- wheras the maven plugin itself use D:\repos\projectA as it's current directory
- means the current working directory for the JVM is C:\dev and for the Java code it's D:\repos\projectA (as it's related to the property "user.dir")

AFAIK there is no reliable way with plain Java to get the information in which current working directory the JVM was invoked.

There are some suggestions in the internet how to find out the current working directory from Java. The most common are 

- `new File(".").getAbsolutePath()`
- `System.getProperty("user.dir")`
- `Paths.get(".").toAbsolutePath()`

All rely on the system property "user.dir". They are all right, as long this property was set by the JVM only.

But this property might has been defined also:

* as `-Duser.dir=...` when the JVM is invoked
* using `System.setProperty("user.dir", "...")` (will affect only `File` not `Path`)

In such case the above suggestions fail. This project show those cases and the tiny library gives you a solution how to get the current working directory from which the JVM was invoked.
