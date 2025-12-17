import 'dart:io';
import 'package:path_provider/path_provider.dart';

class PathManager {
  static Future<Directory> videoDir() async {
    final base = await getApplicationSupportDirectory();
    final dir = Directory('${base.path}/videos');
    if (!dir.existsSync()) dir.createSync(recursive: true);
    return dir;
  }
}
