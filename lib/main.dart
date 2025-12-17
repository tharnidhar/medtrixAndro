import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:dynamic_color/dynamic_color.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:media_kit/media_kit.dart';

// Import your loader and schema
import 'package:myapp/data/marrow/marrow_loader.dart'; 
import 'package:myapp/data/local_db/video_asset.dart';
import 'package:myapp/app_router.dart';

late Isar isar;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  MediaKit.ensureInitialized();

  // 1. Open Isar
  final dir = await getApplicationSupportDirectory();
  isar = await Isar.open(
    [VideoAssetSchema],
    directory: dir.path,
  );

  // 2. SEED THE DATA (This is what you were missing)
  await MarrowLoader.seed(isar);

  runApp(
    const ProviderScope(
      child: MedTrixApp(),
    ),
  );
}

// ... rest of your MedTrixApp class
class MedTrixApp extends StatelessWidget {
  const MedTrixApp({super.key});

  @override
  Widget build(BuildContext context) {
    return DynamicColorBuilder(
      builder: (ColorScheme? lightDynamic, ColorScheme? darkDynamic) {
        return MaterialApp.router(
          debugShowCheckedModeBanner: false,
          title: 'MedTrix StudyOS',
          routerConfig: appRouter,
          theme: ThemeData(
            useMaterial3: true,
            colorScheme:
                lightDynamic ?? ColorScheme.fromSeed(seedColor: Colors.teal),
          ),
          darkTheme: ThemeData(
            useMaterial3: true,
            brightness: Brightness.dark,
            colorScheme: darkDynamic ??
                ColorScheme.fromSeed(
                  seedColor: Colors.teal,
                  brightness: Brightness.dark,
                ),
          ),
          themeMode: ThemeMode.system,
        );
      },
    );
  }
}
