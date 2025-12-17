import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_animate/flutter_animate.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text("MedTrix StudyOS"),
        elevation: 0,
        actions: [IconButton(icon: const Icon(Icons.settings), onPressed: () {})],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Your Library", style: Theme.of(context).textTheme.headlineSmall),
            const SizedBox(height: 20),
            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                childAspectRatio: 0.85,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                children: [
                  _brandCard(context, "Marrow", Colors.teal),
                  _brandCard(context, "PrepLadder", Colors.blueAccent),
                  _brandCard(context, "Cerebellum", Colors.purpleAccent),
                  _brandCard(context, "Dams", Colors.orangeAccent),
                ].animate(interval: 100.ms).fadeIn().slideY(begin: 0.1),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _brandCard(BuildContext context, String title, Color color) {
    return InkWell(
      onTap: () => context.push('/subject/$title'),
      borderRadius: BorderRadius.circular(20),
      child: Container(
        decoration: BoxDecoration(
          color: color.withOpacity(0.1),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: color.withOpacity(0.3)),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.library_books, size: 40, color: color),
            const SizedBox(height: 10),
            Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
          ],
        ),
      ),
    );
  }
}
