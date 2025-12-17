import '../../../data/schemas/video_asset.dart';

class VideoSource {
  static String resolve(VideoAsset asset) {
    return asset.isDownloaded && asset.localFileName != null
        ? asset.localFileName!
        : asset.remoteUrl;
  }
}
