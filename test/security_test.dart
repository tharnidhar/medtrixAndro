import 'package:flutter_test/flutter_test.dart';
// CHANGE 'myapp' below to match the "name:" in your pubspec.yaml if it's different
import 'package:myapp/core/security/file_obfuscator.dart'; 

void main() {
  group('The Vault Tests', () {
    test('XOR Operation should be reversible', () {
      // 1. Create dummy data (simulating a file header)
      final List<int> originalData = [10, 20, 30, 40, 50];

      // 2. Corrupt it (Obfuscate)
      final corrupted = FileObfuscator.obfuscateHeader(originalData);

      // 3. Verify it changed
      expect(corrupted, isNot(equals(originalData)));
      print("Original: $originalData");
      print("Corrupted: $corrupted");

      // 4. Fix it (De-Obfuscate)
      // Running the same function again should restore the data.
      final restored = FileObfuscator.obfuscateHeader(corrupted);

      // 5. Verify it matches original
      expect(restored, equals(originalData));
    });
  });
}