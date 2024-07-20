import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:meals_app/screens/categories.dart';
import 'package:meals_app/screens/filters.dart';
import 'package:meals_app/screens/meals.dart';
import 'package:meals_app/widgets/main_drawer.dart';
import 'package:meals_app/providers/favorites_provider.dart';
import 'package:meals_app/providers/filters_provider.dart';

const kInitialFilters = {
  Filter.glutenFree: false,
  Filter.lactoseFree: false,
  Filter.vegetarian: false,
  Filter.vegan: false
};

class TabsScreen extends ConsumerStatefulWidget {
  const TabsScreen({super.key});

  @override
  ConsumerState<TabsScreen> createState() => _TabsScreenState();
}

class _TabsScreenState extends ConsumerState<TabsScreen> {
  int _selectedPageIndex = 0;

  // void _toggleMealFavoriteStatus(Meal meal) {
  //   final isExisting = _favoriteMeals.contains(meal);
  //
  //   void _showInfoMessage(String message) {
  //     ScaffoldMessenger.of(context).clearSnackBars();
  //     ScaffoldMessenger.of(context)
  //         .showSnackBar(SnackBar(content: Text(message)));
  //   }
  //
  //   if (isExisting) {
  //     setState(() {
  //       _favoriteMeals.remove(meal);
  //     });
  //     _showInfoMessage("Meal is no longer favorite");
  //   } else {
  //     setState(() {
  //       _favoriteMeals.add(meal);
  //     });
  //     _showInfoMessage("Marked as favorite!");
  //   }
  // }

  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  void _setSelectScreen(String identifier) async {
    Navigator.of(context).pop();
    if (identifier == 'Filters') {
      await Navigator.of(context).push<Map<Filter, bool>>(
          MaterialPageRoute(builder: (ctx) => const FiltersScreen()));
    }
  }

  @override
  Widget build(BuildContext context) {
    final availableMeals = ref.watch(filteredProvider);

    Widget activePage = Categories(
      // onToggleFavorite: _toggleMealFavoriteStatus,
      availableMeals: availableMeals,
    );
    var activePageTitle = "Categories";

    if (_selectedPageIndex == 1) {
      final favoriteMeals = ref.watch(favoriteMealProvider);

      activePage = MealsScreen(
        meals: favoriteMeals,
        // onToggleFavorite: _toggleMealFavoriteStatus,
      );
      activePageTitle = "Favorites";
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(activePageTitle),
      ),
      drawer: MainDrawer(
        onSelectScreen: _setSelectScreen,
      ),
      body: activePage,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedPageIndex,
        onTap: _selectPage,
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.set_meal), label: "Categories"),
          BottomNavigationBarItem(icon: Icon(Icons.star), label: "Favorites")
        ],
      ),
    );
  }
}
