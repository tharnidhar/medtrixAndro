import 'package:isar/isar.dart';

part 'video_asset.g.dart';

@collection
class VideoAsset {
  Id id = Isar.autoIncrement;

  late String title;
  late String subject;
  late String topic;

  late String remoteUrl;        // Always present
  String? localFileName;        // Present if downloaded

  late int durationSeconds;

  bool isDownloaded = false;
  int lastPositionSeconds = 0;

  late DateTime lastAccessed;
}
