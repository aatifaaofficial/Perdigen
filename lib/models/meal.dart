import 'food_item.dart';

class MealFood {
  final FoodItem food;
  final double quantity;

  const MealFood({required this.food, this.quantity = 1});

  MealFood copyWith({FoodItem? food, double? quantity}) {
    return MealFood(
      food: food ?? this.food,
      quantity: quantity ?? this.quantity,
    );
  }
}

class Meal {
  final String id;
  final String type;
  final DateTime date;
  final List<MealFood> foods;

  const Meal({
    required this.id,
    required this.type,
    required this.date,
    required this.foods,
  });

  double _total(double Function(FoodItem food) value) =>
      foods.fold(0, (sum, item) => sum + value(item.food) * item.quantity);

  double get totalCalories => _total((food) => food.calories);
  double get totalProtein => _total((food) => food.protein);
  double get totalCarbohydrates => _total((food) => food.carbohydrates);
  double get totalFat => _total((food) => food.fat);
  double get totalFiber => _total((food) => food.fiber);

  Meal copyWith({String? type, DateTime? date, List<MealFood>? foods}) {
    return Meal(
      id: id,
      type: type ?? this.type,
      date: date ?? this.date,
      foods: foods ?? this.foods,
    );
  }
}
