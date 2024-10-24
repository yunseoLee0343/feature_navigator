import 'package:flash_card_app/model/category.dart';

class WordCard {
  int id;
  CategoryCode category;
  String korWord; // 한국어 단어
  String engWord; // 영어 단어
  String displayWord;
  String image; // 이미지 경로 (URL 또는 로컬 파일 경로)
  List<bool> history; // 단어 이력
  bool isToggle;

  // 생성자
  WordCard({
    required this.id,
    required this.category,
    required this.korWord,
    required this.engWord,
    required this.displayWord,
    required this.image,
    required this.history,
    required this.isToggle,
  });
}

enum Direction { right, left, none }
