import 'package:flutter/material.dart';
import 'package:meals_app/data/dummy_data.dart';
import 'package:meals_app/screens/meals.dart';
import 'package:meals_app/widgets/category_grid_item.dart';

import '../models/category.dart';
import '../models/meal.dart';

class Categories extends StatefulWidget {
  const Categories({super.key, required this.availableMeals});

  final List<Meal> availableMeals;

  @override
  State<Categories> createState() => _CategoriesState();
}

class _CategoriesState extends State<Categories>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
      lowerBound: 0,
      upperBound: 1,
    );
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _selectCategory(BuildContext context, Category category) {
    final filteredMeals = widget.availableMeals
        .where((meal) => meal.categories.contains(category.id))
        .toList();

    Navigator.of(context).push(MaterialPageRoute(
        builder: (ctx) => MealsScreen(
              title: category.title,
              meals: filteredMeals,
            )));
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: _animationController,
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
        builder: (context, child) => SlideTransition(
              position:
                  Tween(begin: const Offset(0, 0.3), end: const Offset(0, 0))
                      .animate(CurvedAnimation(
                          parent: _animationController,
                          curve: Curves.easeInOut)),
              child: child,
            ));
  }
}
