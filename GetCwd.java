import java.io.File;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.List;

import java.lang.management.ManagementFactory;
import java.lang.management.RuntimeMXBean;

class GetCwd {
	// define the native method
	private native String getCWD();

	public static void main(String[] args)	{
		System.loadLibrary("GetCwd");

		GetCwd lib = new GetCwd();
		String cwd = lib.getCWD();

		// get property "user.dir" if it was set as JVM option
		RuntimeMXBean RuntimemxBean = ManagementFactory.getRuntimeMXBean();
		List<String> arguments = RuntimemxBean.getInputArguments();
		String jvmOptionUserDir = "";
		for (String arg : arguments) {
			if (arg.startsWith("-Duser.dir")) {
				jvmOptionUserDir = arg;
			}
		}


      System.out.println("JVM start directory ...");
		System.out.println("   as JVM option       : " + jvmOptionUserDir);
		System.out.println("   GetCwd library      : " + cwd);
		System.out.println("   property 'user.dir' : " + System.getProperty("user.dir"));

		// get logical current directory depends on the setting of property "user.dir"
		File file = new File("");
		System.out.println("   CWD using File      : " + file.getAbsolutePath());
		Path path = Paths.get("");
		System.out.println("   CWD using Path      : " + path.toAbsolutePath());

		// now switch to another logical current directory
		// have an effect only for `File` not for `Path`
		// as we don't want to do some IO there it must not exist
		if ("Windows".equalsIgnoreCase(System.getProperty("os.name"))) {
			System.setProperty("user.dir", "C:/I/like/this/CAFEBABE");
		} else {
			System.setProperty("user.dir", "/I/like/this/CAFEBABE");
		}
		System.out.println("   programatic change of 'user.dir' ...");
		System.out.println("   CWD using File      : " + file.getAbsolutePath());
		System.out.println("   CWD using Path      : " + path.toAbsolutePath());
	}
}