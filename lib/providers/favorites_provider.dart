import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/meal.dart';

class FavoritesMealsNotifier extends StateNotifier<List<Meal>> {
  FavoritesMealsNotifier() : super([]);

  bool toggleMealFavoriteStatus(Meal meal) {
    final mealIsFavorite = state.contains(meal);

    if (mealIsFavorite) {
      state = state.where((m) => m.id != meal.id).toList();
      return true;
    } else {
      state = [...state, meal];
      return false;
    }
  }
}

final favoriteMealProvider =
    StateNotifierProvider<FavoritesMealsNotifier, List<Meal>>((ref) {
  return FavoritesMealsNotifier();
});
