import 'package:feature_navigator/feature_router.dart';
import 'package:flash_card_app/view/category_list_page.dart';
import 'package:flash_card_app/view/category_page.dart';
import 'package:flash_card_app/view/main_page.dart';
import 'package:flash_card_app/view/tutorial_page.dart';
import 'package:go_router/go_router.dart';

GoRouter createRouter(bool isFirst) {
  return GoRouter(
    initialLocation: isFirst ? '/tutorial' : '/',
    routes: [
      FeatureRoute(
        name: 'main',
        description:
            'The main page of the flashcard app where users can see an overview or access various features.',
        path: '/',
        builder: (context, state) => const MainPage(),
      ),
      FeatureRoute(
        name: 'tutorial',
        description:
            'A tutorial page that guides first-time users on how to use the flashcard app.',
        path: '/tutorial',
        builder: (context, state) => const TutorialPage(),
      ),
      FeatureRoute(
        name: 'category',
        description:
            'The category page where users can select different categories for their flashcards.',
        path: '/category',
        builder: (context, state) => const CategoryPage(),
      ),
      FeatureRoute(
        name: 'category_list',
        description:
            'A detailed list of flashcards in a specific category selected by the user.',
        path: '/category/:categoryName',
        parameters: const {
          'categoryName': [
            "animal",
            "plant",
            "food",
            "occupation",
            "nature",
            "transportation",
            "family",
            "activity",
            "culture",
            "electronics",
            "emotion"
          ],
        },
        builder: (context, state) {
          final categoryName = state.pathParameters['categoryName']!;
          return CategoryListPage(categoryName: categoryName);
        },
      ),
    ],
  );
}
