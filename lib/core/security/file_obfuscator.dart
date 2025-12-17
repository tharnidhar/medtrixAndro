import 'dart:io';

class FileObfuscator {
  static const int headerSize = 1024;
  static const int key = 0x5A;

  static Future<void> obfuscate(File input, File output) async {
    final bytes = await input.readAsBytes();

    for (int i = 0; i < headerSize && i < bytes.length; i++) {
      bytes[i] ^= key;
    }

    await output.writeAsBytes(bytes, flush: true);
  }
}
