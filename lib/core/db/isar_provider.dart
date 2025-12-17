import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import '../../data/schemas/video_asset.dart';

final isarProvider = Provider<Isar>((ref) {
  throw UnimplementedError(
    'isarProvider must be overridden in main.dart',
  );
});

Future<Isar> openIsar() async {
  final dir = await getApplicationSupportDirectory();
  return Isar.open(
    [VideoAssetSchema],
    directory: dir.path,
  );
}
