import 'dart:io';

class PathProviderService {
  static String getDownloadPath() {
    String downloadPath;

    if (Platform.isLinux || Platform.isMacOS) {
      String home = Platform.environment['HOME'] ?? '';
      downloadPath = '$home/Downloads';
    } else if (Platform.isWindows) {
      String userProfile = Platform.environment['USERPROFILE'] ?? '';
      downloadPath = '$userProfile\\Downloads';
    } else {
      throw UnsupportedError("This platform is not supported");
    }

    return downloadPath;
  }
}
