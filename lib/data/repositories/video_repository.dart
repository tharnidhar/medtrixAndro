import 'package:isar/isar.dart';
import '../schemas/video_asset.dart';

class VideoRepository {
  final Isar isar;
  VideoRepository(this.isar);

  Future<List<VideoAsset>> getAll() {
    return isar.videoAssets.where().findAll();
  }

  Future<VideoAsset?> getById(int id) {
    return isar.videoAssets.get(id);
  }

  Future<void> save(VideoAsset asset) async {
    await isar.writeTxn(() async {
      await isar.videoAssets.put(asset);
    });
  }
}
