import 'package:flutter/material.dart';

enum CategoryCode {
  animal("동물", "animal", Icons.pets_outlined),
  plant("식물", "plant", Icons.local_florist_outlined),
  food("음식", "food", Icons.fastfood_outlined),
  occupation("직업", "occupation", Icons.work_outline),
  nature("자연", "nature", Icons.forest_outlined),
  transportation("교통", "transportation", Icons.directions_car_outlined),
  family("가족", "family", Icons.family_restroom_outlined),
  activity("활동", "activity", Icons.surfing_outlined),
  culture("문화", "culture", Icons.theater_comedy_outlined),
  electronics("전자제품", "electronics", Icons.devices_outlined),
  emotion("감정", "emotion", Icons.emoji_emotions_outlined);

  final String korean;
  final String english;
  final IconData icon;
  const CategoryCode(this.korean, this.english, this.icon);

  // JSON으로 직렬화
  Map<String, dynamic> toJson() => {
        'korean': korean,
        'english': english,
        'icon': icon.codePoint,
      };

  // JSON에서 역직렬화
  static CategoryCode fromJson(Map<String, dynamic> json) {
    return CategoryCode.values.firstWhere(
        (e) => e.korean == json['korean'] && e.english == json['english']);
  }
}
