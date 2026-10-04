import 'package:personal_diet_journal/models/meal.dart';
import 'package:personal_diet_journal/models/food_item.dart';
import 'meal_repository.dart';
import 'mock_food_data.dart';

class MockMealRepository implements MealRepository {
  final List<Meal> _meals = [
    Meal(
      id: 'breakfast-1',
      type: 'Breakfast',
      date: DateTime(2026, 9, 20),
      foods: [
        MealFood(food: mockFoodData[0]),
        MealFood(food: mockFoodData[1]),
      ],
    ),
    Meal(
      id: 'lunch-1',
      type: 'Lunch',
      date: DateTime(2026, 9, 20),
      foods: [
        MealFood(food: mockFoodData[4], quantity: 1.3),
        MealFood(food: mockFoodData[5]),
        MealFood(food: mockFoodData[8]),
      ],
    ),
    Meal(
      id: 'dinner-1',
      type: 'Dinner',
      date: DateTime(2026, 9, 20),
      foods: [
        MealFood(food: mockFoodData[7]),
        MealFood(food: mockFoodData[16]),
        MealFood(food: mockFoodData[8]),
      ],
    ),
  ];

  @override
  List<Meal> getMeals(DateTime date) => _meals
      .where(
        (meal) =>
            meal.date.year == date.year &&
            meal.date.month == date.month &&
            meal.date.day == date.day,
      )
      .toList();

  @override
  Future<void> addMeal(Meal meal) async => _meals.add(meal);

  @override
  Future<void> updateMeal(Meal meal) async {
    final index = _meals.indexWhere((item) => item.id == meal.id);
    if (index >= 0) _meals[index] = meal;
  }

  @override
  Future<void> deleteMeal(String mealId) async =>
      _meals.removeWhere((meal) => meal.id == mealId);

  @override
  List<FoodItem> searchFoods(String query, {String? category}) {
    final normalized = query.trim().toLowerCase();
    return mockFoodData.where((food) {
      final matchesQuery =
          normalized.isEmpty || food.name.toLowerCase().contains(normalized);
      final matchesCategory =
          category == null || category == 'All' || food.category == category;
      return matchesQuery && matchesCategory;
    }).toList();
  }
}
