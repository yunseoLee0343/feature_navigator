import 'package:example/screens/details_screen.dart';
import 'package:example/screens/home_screen.dart';
import 'package:feature_navigator/feature_route.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final GoRouter _router;

  MyApp({super.key})
      : _router = GoRouter(
          routes: [
            FeatureRoute(
              name: 'home',
              path: '/',
              description: 'This is the home screen',
              builder: (context, state) => const HomeScreen(),
            ),
            FeatureRoute(
              name: 'details',
              path: '/details',
              description: 'This is the details screen',
              builder: (context, state) => const DetailsScreen(),
              includeChat: true,
            ),
          ],
        );

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: _router,
    );
  }
}
