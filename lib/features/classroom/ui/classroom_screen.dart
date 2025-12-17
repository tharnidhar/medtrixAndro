import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:isar/isar.dart';

// Imports for your Data & DB
import 'package:myapp/data/local_db/video_asset.dart';
import 'package:myapp/main.dart';

// Imports for your existing widgets
import '../widgets/pdf_viewer_widget.dart';
import '../widgets/ink_canvas_widget.dart';
import '../widgets/floating_toolbar.dart';

class ClassroomScreen extends StatefulWidget {
  final String videoId;
  const ClassroomScreen({super.key, required this.videoId});

  @override
  State<ClassroomScreen> createState() => _ClassroomScreenState();
}

class _ClassroomScreenState extends State<ClassroomScreen> {
  VideoAsset? _video;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadVideo();
  }

  Future<void> _loadVideo() async {
    final id = int.tryParse(widget.videoId);
    if (id != null) {
      final video = await isar.videoAssets.get(id);
      setState(() {
        _video = video;
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // 1. Loading State
    if (_isLoading) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    // 2. Error State (No URL found)
    if (_video == null || _video!.url.isEmpty) {
      return Scaffold(
        appBar: AppBar(title: const Text("Error")),
        body: const Center(child: Text("Video URL not found in database.")),
      );
    }

    // 3. Your Original Layout Logic
    final isLandscape = MediaQuery.of(context).orientation == Orientation.landscape;

    return Scaffold(
      body: SafeArea(
        child: isLandscape
            ? _buildLandscapeLayout()
            : _buildPortraitLayout(),
      ),
      floatingActionButton: const FloatingToolbar(),
    );
  }

  // --- LAYOUT BUILDERS ---

  Widget _buildPortraitLayout() {
    return Column(
      children: [
        // Video Section (Top)
        AspectRatio(
          aspectRatio: 16 / 9,
          child: _buildWebViewPlayer(), // <--- Swapped Native Player for WebView
        ),
        // Notebook Section (Bottom)
        Expanded(child: _buildNotebookArea()),
      ],
    );
  }

  Widget _buildLandscapeLayout() {
    return Row(
      children: [
        // Video Section (Left)
        Expanded(
          flex: 1, // Adjust this flex to resize video vs notes
          child: _buildWebViewPlayer(), // <--- Swapped Native Player for WebView
        ),
        // Notebook Section (Right)
        Expanded(
          flex: 1,
          child: _buildNotebookArea(),
        ),
      ],
    );
  }

  // --- THE NEW WEB PLAYER ---
  Widget _buildWebViewPlayer() {
    return Container(
      color: Colors.black,
      child: InAppWebView(
        initialUrlRequest: URLRequest(url: WebUri(_video!.url)),
        initialSettings: InAppWebViewSettings(
          mediaPlaybackRequiresUserGesture: false,
          allowsInlineMediaPlayback: true,
          iframeAllowFullscreen: true,
          // These settings help with Cloudflare/Stream sites
          javaScriptEnabled: true,
          domStorageEnabled: true,
        ),
      ),
    );
  }

  // --- YOUR EXISTING NOTEBOOK LOGIC (UNCHANGED) ---
  Widget _buildNotebookArea() {
    return Stack(
      children: [
        Positioned.fill(child: MedTrixPdfViewer()),
        Positioned.fill(child: InkCanvasWidget()),
      ],
    );
  }
}