import 'package:flash_card_app/model/card.dart';
import 'package:flash_card_app/repository/card_repo.dart';
import 'package:flash_card_app/view/card_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TutorialPage extends ConsumerStatefulWidget {
  const TutorialPage({super.key});

  @override
  ConsumerState<TutorialPage> createState() => _TutorialPageState();
}

class _TutorialPageState extends ConsumerState<TutorialPage> {
  int _index = 0;
  int _progress = 0;
  Direction _direction = Direction.none;

  @override
  Widget build(BuildContext context) {
    final cardList = ref.watch(cardListProvider);
    final cardMethod = ref.read(cardListProvider.notifier);

    Future<void> finishTutioral() async {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setBool('isFirst', false);
    }

    String displayText;
    switch (_progress) {
      case 0:
        displayText = "영단어를 보려면 터치해주세요";

      case 1:
        displayText = "알고있는 단어인가요?\n오른쪽으로 슬라이드 해봐요";
        break;
      case 2:
        displayText = "잘했어요!\n다시 한번 터치해봐요";
        break;
      case 3:
        displayText = "모르는 단어인가요?\n왼쪽으로 슬라이드 해봐요";
        break;
      default:
        displayText = "앞으로 20단어씩\n매일 함께 배워봐요!";
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFC0C0C0),
      ),
      body: Container(
        decoration: const BoxDecoration(color: Color(0xffC0C0C0)),
        child: Column(
          children: [
            Center(
              child: Text(
                displayText,
                style: const TextStyle(
                  fontFamily: 'Jalnan',
                  fontSize: 24,
                  color: Colors.white,
                ),
              ),
            ),
            Expanded(
              child: CardSwiper(
                cardsCount: 3,
                isDisabled: !cardList[_index].isToggle,
                scale: 0.9,
                isLoop: false,
                onTapDisabled: () {
                  cardMethod.toggleAnswer(_index);
                  if (_progress > 3) {
                    finishTutioral();
                    context.go('/');
                  }
                  setState(() {
                    _progress += 1;
                  });
                },
                numberOfCardsDisplayed: 2,
                allowedSwipeDirection:
                    const AllowedSwipeDirection.symmetric(horizontal: true),
                onSwipe: (oldIndex, currentIndex, direction) {
                  if (_progress != 1 &&
                      direction == CardSwiperDirection.right) {
                    return false;
                  }
                  if (_progress != 3 && direction == CardSwiperDirection.left) {
                    return false;
                  }
                  cardMethod.setTutorial(_index);
                  setState(
                    () {
                      _progress++;
                      _index++;
                    },
                  );
                  return true;
                },
                cardBuilder:
                    (context, index, percentThresholdX, percentThresholdY) {
                  switch (percentThresholdX.sign.toInt()) {
                    case 1:
                      _direction = Direction.right;
                      break;
                    case -1:
                      _direction = Direction.left;
                      break;
                    default:
                      _direction = Direction.none;
                  }
                  return CardWidget(index: index, direction: _direction);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
