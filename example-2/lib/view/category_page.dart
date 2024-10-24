import 'package:flash_card_app/repository/card_repo.dart';
import 'package:flash_card_app/repository/category_repo.dart';
import 'package:flash_card_app/view/category_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class CategoryPage extends ConsumerWidget {
  const CategoryPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final categoryList = ref.watch(allCategoriesProvider);
    final cardMethod = ref.read(cardListProvider.notifier);

    return Scaffold(
      backgroundColor: const Color(0xFFF8F8F8),
      appBar: AppBar(
          backgroundColor: const Color(0xFFF8F8F8),
          title: Padding(
            padding: const EdgeInsets.all(4.0),
            child: Text(
              '카테고리',
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ),
          centerTitle: false,
          automaticallyImplyLeading: false,
          actions: [
            IconButton(
              icon: const Icon(
                Icons.arrow_back,
                size: 32,
              ),
              onPressed: () {
                context.pop();
              },
            ),
          ]),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 16.0,
                  mainAxisSpacing: 16.0,
                ),
                itemCount: categoryList.length,
                itemBuilder: (context, index) {
                  final wordCard = categoryList[index];
                  return CategoryWidget(wordCard: wordCard);
                },
              ),
            ),
            const SizedBox(
              height: 48,
            ),
            GestureDetector(
              onTap: () => showModalBottomSheet(
                context: context,
                builder: (BuildContext context) => Container(
                  height: 240,
                  padding:
                      const EdgeInsets.symmetric(vertical: 32, horizontal: 24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "단어 기록을 초기화하시겠습니까?",
                            style: TextStyle(color: Colors.black, fontSize: 20),
                          ),
                          Text("해당 작업은 복구 할 수 없습니다."),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          GestureDetector(
                            onTap: () => Navigator.pop(context),
                            child: const Text(
                              "취소",
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 24,
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 36,
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.pop(context);
                              cardMethod.resetHistory();

                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  // Future.delayed(const Duration(seconds: 1),
                                  //     () {
                                  //   Navigator.of(context).pop(true);
                                  // });
                                  return const Padding(
                                    padding: EdgeInsets.symmetric(
                                        vertical: 16, horizontal: 32),
                                    child: AlertDialog(
                                      title: Text(
                                        '초기화 완료!',
                                        style: TextStyle(
                                            fontSize: 16, fontFamily: "Jalnan"),
                                      ),
                                      // content: Text('다시 한번 시작해봐요!'),
                                    ),
                                  );
                                },
                              );
                            },
                            child: const Text(
                              "초기화 하기",
                              style: TextStyle(
                                color: Colors.red,
                                fontSize: 24,
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
              child: const Padding(
                padding: EdgeInsets.all(16.0),
                child: Center(
                  child: Text(
                    "단어 기록 초기화",
                    style: TextStyle(
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
