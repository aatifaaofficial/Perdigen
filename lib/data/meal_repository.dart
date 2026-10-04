import 'package:personal_diet_journal/models/food_item.dart';
import 'package:personal_diet_journal/models/meal.dart';

abstract class MealRepository {
  List<Meal> getMeals(DateTime date);
  Future<void> addMeal(Meal meal);
  Future<void> updateMeal(Meal meal);
  Future<void> deleteMeal(String mealId);
  List<FoodItem> searchFoods(String query, {String? category});
}
