import 'package:flutter/material.dart';
import 'package:meals_app/data/dummy_data.dart';
import 'package:meals_app/screens/meals.dart';
import 'package:meals_app/widgets/category_grid_item.dart';

import '../models/category.dart';
import '../models/meal.dart';

class Categories extends StatelessWidget {
  const Categories({super.key, required this.onToggleFavorite, required this.availableMeals});

  final void Function(Meal meal) onToggleFavorite;
  final List <Meal> availableMeals;

  @override
  Widget build(BuildContext context) {
    void _selectCategory(BuildContext context, Category category) {
      final filteredMeals = availableMeals
          .where((meal) => meal.categories.contains(category.id))
          .toList();

      Navigator.of(context).push(MaterialPageRoute(
          builder: (ctx) => MealsScreen(
                onToggleFavorite: onToggleFavorite,
                title: category.title,
                meals: filteredMeals,
              )));
    }

    return SafeArea(
      child: GridView(
        padding: const EdgeInsets.all(24),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 3 / 2,
            crossAxisSpacing: 20,
            mainAxisSpacing: 20),
        children: [
          for (final category in availableCategories)
            CategoryGridItem(
              onSelectCategory: () {
                _selectCategory(context, category);
              },
              category: category,
            )
        ],
      ),
    );
  }
}
