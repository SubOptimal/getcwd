#include "GetCwd.h" 
#include "jni.h"
#include "string"
#include "unistd.h"
#ifndef _WIN32
#include <sys/param.h>
#endif

using namespace std;

JNIEXPORT jstring JNICALL Java_GetCwd_getCWD(JNIEnv *env, jobject obj) {
#ifndef _WIN32
	char directory[MAXPATHLEN+1] = "\0";
#else
	char directory[_MAX_PATH];
#endif
	getcwd(directory, sizeof(directory));

	return env->NewStringUTF(directory);
}
