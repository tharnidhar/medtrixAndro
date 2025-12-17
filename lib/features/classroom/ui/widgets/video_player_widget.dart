import 'package:flutter/material.dart';
import 'package:media_kit/media_kit.dart';
import 'package:media_kit_video/media_kit_video.dart';

class MedTrixVideoPlayer extends StatefulWidget {
  final String videoId;
  const MedTrixVideoPlayer({super.key, required this.videoId});

  @override
  State<MedTrixVideoPlayer> createState() => _MedTrixVideoPlayerState();
}

class _MedTrixVideoPlayerState extends State<MedTrixVideoPlayer> {
  late final player = Player();
  late final controller = VideoController(player);

  @override
  void initState() {
    super.initState();
    // Play a dummy video for demo purposes
    player.open(Media('https://user-images.githubusercontent.com/28951144/229373695-22f88f13-d18f-4288-9bf1-c3e078d83722.mp4'));
  }

  @override
  void dispose() {
    player.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Video(controller: controller);
  }
}
