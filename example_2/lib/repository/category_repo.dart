import 'package:flash_card_app/model/category.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'category_repo.g.dart';

@riverpod
List<CategoryCode> allCategories(AllCategoriesRef ref) {
  // CategoryCode의 모든 값을 리스트로 반환
  return CategoryCode.values.toList();
}
