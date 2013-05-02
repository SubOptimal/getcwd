#include "GetCwd.h" 
#include "jni.h"
#include "string"
#include "unistd.h"
 
using namespace std;

JNIEXPORT jstring JNICALL Java_GetCwd_getCWD(JNIEnv *env, jobject obj) {

		char directory[_MAX_PATH];

		getcwd(directory, sizeof(directory));

      return env->NewStringUTF(directory);

}
