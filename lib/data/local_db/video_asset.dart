import 'package:isar/isar.dart';

part 'video_asset.g.dart';

@collection
class VideoAsset {
  Id id = Isar.autoIncrement;

  late String title;
  late String subjectName;
  late String url; // Stores the web link

  late String storageUuid;
  
  bool isDownloaded = false;
  bool isCompleted = false;
  
  late DateTime lastAccessed;
  int timestampSeconds = 0;
}
