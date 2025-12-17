import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:myapp/features/dashboard/ui/dashboard_screen.dart';
import 'package:myapp/features/dashboard/ui/subject_hub_screen.dart';
import 'package:myapp/features/study_hub/ui/topic_index_screen.dart';
import 'package:myapp/features/classroom/ui/classroom_screen.dart';

final appRouter = GoRouter(
  initialLocation: '/',
  routes: [
    // Level 1: Dashboard
    GoRoute(
      path: '/',
      builder: (context, state) => const DashboardScreen(),
    ),
    
    // Level 2: Subject Hub (e.g. /subject/Marrow)
    GoRoute(
      path: '/subject/:brandId',
      builder: (context, state) {
        final brandId = state.pathParameters['brandId'] ?? "Unknown";
        return SubjectHubScreen(brandId: brandId);
      },
    ),

    // Level 3: Topic Index (e.g. /topics/Anatomy)
    GoRoute(
      path: '/topics/:subjectId',
      builder: (context, state) {
        final subjectId = state.pathParameters['subjectId'] ?? "Unknown";
        return TopicIndexScreen(subjectId: subjectId);
      },
    ),

    // Level 4: The Classroom (Video + PDF)
    GoRoute(
      path: '/classroom/:videoId',
      builder: (context, state) {
        final videoId = state.pathParameters['videoId'] ?? "0";
        return ClassroomScreen(videoId: videoId);
      },
    ),
  ],
);
