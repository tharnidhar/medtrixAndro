import 'dart:io';
import 'package:dio/dio.dart';
import '../../core/storage/path_manager.dart';
import '../../core/security/file_obfuscator.dart';
import '../../data/schemas/video_asset.dart';
import '../../data/repositories/video_repository.dart';

class DownloadService {
  final Dio dio = Dio();

  Future<void> downloadVideo(
    VideoAsset asset,
    VideoRepository repo,
  ) async {
    final dir = await PathManager.videoDir();
    final temp = File('${dir.path}/${asset.id}.mp4');
    final obf = File('${dir.path}/${asset.id}.bin');

    await dio.download(asset.remoteUrl, temp.path);

    await FileObfuscator.obfuscate(temp, obf);
    await temp.delete();

    asset
      ..localFileName = obf.path
      ..isDownloaded = true
      ..lastAccessed = DateTime.now();

    await repo.save(asset);
  }
}
