import 'package:feature_navigator/feature_router.dart';
import 'package:flash_card_app/repository/card_repo.dart';
import 'package:flash_card_app/utill/router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  Future<bool> _loadIsFirst() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool('isFirst') ?? true; // 기본값을 true로 설정
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return FutureBuilder<bool>(
      future: _loadIsFirst(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const MaterialApp(
            home: Scaffold(
              body: Center(child: CircularProgressIndicator()),
            ),
          );
        } else if (snapshot.hasError) {
          return MaterialApp(
            home: Scaffold(
              body: Center(child: Text('Error: ${snapshot.error}')),
            ),
          );
        } else if (snapshot.hasData) {
          final isFirst = snapshot.data!;
          final cardMethod = ref.read(cardListProvider.notifier);
          cardMethod.setHistory();

          final GoRouter router = createRouter(isFirst);

          FeatureRouter(
            goRouter: router,
            apiKey: 'your-gpt-api-key',
          );

          return MaterialApp.router(
            debugShowCheckedModeBanner: false,
            routerConfig: router,
            theme: ThemeData(
              textTheme: const TextTheme(
                titleMedium: TextStyle(
                  fontFamily: 'Jalnan',
                  fontSize: 20,
                  color: Colors.black,
                ),
                bodyLarge: TextStyle(
                  fontFamily: 'Jalnan',
                  color: Colors.black,
                  fontSize: 32,
                ),
                bodyMedium: TextStyle(
                  fontFamily: "Jeju",
                  fontSize: 18,
                  color: Color(0xFF666666),
                ),
              ),
            ),
          );
        } else {
          return const MaterialApp(
            home: Scaffold(
              body: Center(child: Text('Unknown error occurred')),
            ),
          );
        }
      },
    );
  }
}
