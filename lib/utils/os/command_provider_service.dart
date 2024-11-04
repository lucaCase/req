import 'dart:io';

class CommandProviderService {
  static String getStartCommand() {
    String os = Platform.operatingSystem;
    switch (os) {
      case "windows":
        return "explorer";
      case "linux":
        return "xdg-open";
      case "macos":
        return "open";
      default:
        throw UnsupportedError("Unsupported platform");
    }
  }
}
