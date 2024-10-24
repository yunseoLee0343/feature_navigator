import 'dart:convert';

import 'package:flash_card_app/assets/word_data.dart';
import 'package:flash_card_app/model/card.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'card_repo.g.dart';

@riverpod
class CardList extends _$CardList {
  @override
  List<WordCard> build() {
    final List<WordCard> wordCards = wordData.map((data) {
      return WordCard(
        id: data["id"],
        category: data["category"],
        korWord: data["korWord"],
        engWord: data["engWord"],
        displayWord: data["engWord"],
        image: data["image"],
        history: List<bool>.from(data["history"]),
        isToggle: false,
      );
    }).toList();

    wordCards.shuffle();
    return wordCards;
  }

  Future<void> setHistory() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    for (var wordCard in state) {
      final historyString = prefs.getString(wordCard.id.toString());
      if (historyString != null) {
        final dynamic decodedJson = jsonDecode(historyString);
        if (decodedJson is List) {
          wordCard.history = decodedJson.cast<bool>();
        }
      }
    }
  }

  List<WordCard> filterByCategory(String? category) {
    return state.where((card) => card.category.english == category).toList();
  }

  int getIndex(WordCard word) {
    return state.indexOf(word);
  }

  void shuffleCard() {
    List<WordCard> shuffledWordData = state;
    shuffledWordData.shuffle();
    state = shuffledWordData;
  }

  void setTutorial(int index) {
    final wordCard = state[index];

    wordCard.isToggle = false;
    wordCard.displayWord = wordCard.engWord;

    state[index] = wordCard;
  }

  void editHistory(bool isCorrect, int index) async {
    final wordCard = state[index];
    wordCard.history.add(isCorrect);

    if (wordCard.history.length > 5) {
      wordCard.history.removeAt(0);
    }
    wordCard.isToggle = false;
    wordCard.displayWord = wordCard.engWord;

    state[index] = wordCard;
    // 상태를 SharedPreferences에 저장
    await _saveWordData(wordCard);
  }

  Future<void> _saveWordData(WordCard wordCard) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    String jsonString = jsonEncode(wordCard.history);
    await prefs.setString(wordCard.id.toString(), jsonString);
  }

  void toggleAnswer(int index) {
    List<WordCard> newState = List.from(state);

    newState[index].isToggle = !newState[index].isToggle;
    newState[index].displayWord = newState[index].isToggle
        ? newState[index].korWord
        : newState[index].engWord;

    state = newState;
  }

  String getHistory(int index) {
    if (state[index].history.isEmpty) {
      return "처음 보는 단어에요";
    }

    bool lastAnswer = state[index].history.last;
    int count =
        state[index].history.where((value) => value == lastAnswer).length;

    return lastAnswer ? "최근에 $count번 맞춘 단어에요" : "이전에 $count번 틀린 단어에요";
  }

  void resetHistory() async {
    List<WordCard> newState = List.from(state);
    for (var wordCard in newState) {
      wordCard.history = [];
    }

    state = newState;
    await _resetWordData();
  }

  Future<void> _resetWordData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    for (var wordCard in state) {
      prefs.remove(wordCard.id.toString());
    }
  }
}
