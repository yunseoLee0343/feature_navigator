import 'package:flash_card_app/model/card.dart';
import 'package:flash_card_app/model/category.dart';
import 'package:flash_card_app/repository/card_repo.dart';
import 'package:flash_card_app/view/card_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class CategoryWidget extends StatelessWidget {
  const CategoryWidget({
    super.key,
    required this.wordCard,
  });

  final CategoryCode wordCard;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.push('/category/${wordCard.english}');
      },
      child: Container(
        decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(
              color: const Color(0xFFD9D9D9),
              width: 1.5,
            ),
            borderRadius: const BorderRadius.all(
              Radius.circular(16),
            )),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              wordCard.icon,
              size: 32,
              color: const Color(0xff444444),
            ),
            const SizedBox(
              height: 8,
            ),
            Text(
              wordCard.korean,
              style: const TextStyle(
                fontSize: 16,
                color: Color(0xFF444444),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CategoryListWidget extends ConsumerWidget {
  const CategoryListWidget({
    super.key,
    required this.wordCard,
  });

  final WordCard wordCard;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cardMethod = ref.read(cardListProvider.notifier);

    return GestureDetector(
      onTap: () {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return GestureDetector(
              onTap: () => Navigator.of(context).pop(),
              child: Dialog(
                backgroundColor: Colors.transparent,
                insetPadding: const EdgeInsets.all(0),
                child: Center(
                  child: CardWidget(
                    index: cardMethod.getIndex(wordCard),
                    direction: Direction.none,
                  ),
                ),
              ),
            );
          },
        );
      },
      child: Container(
        padding: const EdgeInsets.all(16),
        margin: const EdgeInsets.only(bottom: 8),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(
            width: 1.5,
            color: const Color(0xFFD9D9D9),
          ),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  wordCard.korWord,
                  style: const TextStyle(fontSize: 20, color: Colors.black),
                ),
                Text(
                  wordCard.engWord,
                  style:
                      const TextStyle(fontSize: 16, color: Color(0xFFCCCCCC)),
                ),
              ],
            ),
            Row(
              children: List.generate(5, (index) {
                Color color;

                if (index < wordCard.history.length) {
                  if (wordCard.history[index]) {
                    color = const Color(0xFFC9E7D0);
                  } else {
                    color = const Color(0xFFF2CACA);
                  }
                } else {
                  color = Colors.white;
                }

                return Container(
                  width: 20,
                  height: 20,
                  margin: const EdgeInsets.all(4.0),
                  decoration: BoxDecoration(
                      color: color,
                      border: Border.all(color: const Color(0xFFAAAAAA)),
                      borderRadius: BorderRadius.circular(4)),
                );
              }),
            )
            // Text(wordCard.history.toString())
          ],
        ),
      ),
    );
  }
}
