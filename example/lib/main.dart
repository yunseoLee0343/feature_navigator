import 'package:example/screens/details_screen.dart';
import 'package:example/screens/home_screen.dart';
import 'package:feature_navigator/feature_route.dart';
import 'package:feature_navigator/feature_router.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final FeatureRouter _router;

  MyApp({super.key})
      : _router = FeatureRouter(
          useAI: true,
          aiApiKey: 'api-key',
          routes: [
            FeatureRoute(
              name: '배달 화면',
              path: '/',
              description: '배달 가능한 가게를 보여주는 화면 입니다.',
              builder: (context, state) => const HomeScreen(),
            ),
            FeatureRoute(
              name: '주문 화면',
              path: '/details',
              description: '특정 가게에서 음식을 주문하는 화면 입니다.',
              builder: (context, state) => const DetailsScreen(),
              includeChat: true,
            ),
          ],
        );

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: _router.router,
    );
  }
}
