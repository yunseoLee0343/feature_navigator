import 'package:flash_card_app/repository/card_repo.dart';
import 'package:flash_card_app/view/category_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class CategoryListPage extends ConsumerWidget {
  final String? categoryName;

  const CategoryListPage({super.key, required this.categoryName});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final wordCardList =
        ref.read(cardListProvider.notifier).filterByCategory(categoryName);

    return Scaffold(
      backgroundColor: const Color(0xFFF8F8F8),
      appBar: AppBar(
          backgroundColor: const Color(0xFFF8F8F8),
          title: Padding(
            padding: const EdgeInsets.all(4.0),
            child: Text(
              categoryName.toString(),
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ),
          automaticallyImplyLeading: false,
          centerTitle: false,
          actions: [
            IconButton(
              icon: const Icon(Icons.arrow_back, size: 32),
              onPressed: () {
                context.pop();
              },
            ),
          ]),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView.builder(
            itemCount: wordCardList.length,
            itemBuilder: (context, index) {
              final wordCard = wordCardList[index];
              return CategoryListWidget(wordCard: wordCard);
            }),
      ),
    );
  }
}
