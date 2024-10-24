import 'package:flash_card_app/model/card.dart';
import 'package:flash_card_app/repository/card_repo.dart';
import 'package:flash_card_app/view/card_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class MainPage extends ConsumerStatefulWidget {
  const MainPage({super.key});

  @override
  ConsumerState<MainPage> createState() => _MainPageState();
}

class _MainPageState extends ConsumerState<MainPage> {
  int _index = 0;
  Direction _direction = Direction.none;
  final totalCount = 20;

  @override
  Widget build(BuildContext context) {
    final cardList = ref.watch(cardListProvider);
    final cardMethod = ref.read(cardListProvider.notifier);

    return Scaffold(
        backgroundColor: const Color(0xFFF8F8F8),
        appBar: AppBar(
          backgroundColor: const Color(0xFFF8F8F8),
          title: Padding(
            padding: const EdgeInsets.all(4.0),
            child: Text(
              "나만의 단어집",
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ),
          centerTitle: false,
          actions: [
            IconButton(
                onPressed: () {
                  context.push('/category');
                },
                icon: const Icon(
                  Icons.settings,
                  size: 32,
                ))
          ],
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text('$_index/$totalCount'),
                  LinearProgressIndicator(
                    value: _index / totalCount,
                    color: const Color(0XFF72C083),
                    backgroundColor: Colors.white,
                    minHeight: 8,
                    borderRadius: const BorderRadius.all(Radius.circular(16)),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Stack(
                children: [
                  if (_index >= totalCount - 1)
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.all(40.0),
                        child: Column(
                          children: [
                            Text(
                              '오늘 단어를 다 봤어요!',
                              style: Theme.of(context).textTheme.bodyLarge,
                            ),
                            Expanded(
                              child: Image.asset(
                                'lib/assets/images/ImageSection.png',
                                fit: BoxFit.contain,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  if (_index < totalCount)
                    CardSwiper(
                      cardsCount: cardList.length,
                      isDisabled: !cardList[_index].isToggle,
                      scale: 0.9,
                      isLoop: false,
                      onTapDisabled: () {
                        cardMethod.toggleAnswer(_index);
                      },
                      numberOfCardsDisplayed: () {
                        if (_index == totalCount - 1) {
                          return 1;
                        }
                        if (_index == totalCount - 2) {
                          return 2;
                        }
                        return 3;
                      }(),
                      allowedSwipeDirection:
                          const AllowedSwipeDirection.symmetric(
                        horizontal: true,
                      ),
                      onSwipe: (oldIndex, currentIndex, direction) {
                        cardMethod.editHistory(
                          direction == CardSwiperDirection.right,
                          _index,
                        );
                        setState(() {
                          _index++;
                        });
                        return true;
                      },
                      cardBuilder: (context, index, percentThresholdX,
                          percentThresholdY) {
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
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 32),
              child: _index < totalCount
                  ? Text(cardMethod.getHistory(_index))
                  : GestureDetector(
                      onTap: () {
                        setState(() {
                          _index = 0;
                          cardMethod.shuffleCard();
                        });
                      },
                      child: Text(
                        "$totalCount단어 더보기",
                        style: const TextStyle(
                            decoration: TextDecoration.underline),
                      ),
                    ),
            )
          ],
        ));
  }
}
