class FoodItem {
  final String id;
  final String name;
  final String category;
  final String servingSize;
  final double calories;
  final double protein;
  final double carbohydrates;
  final double fat;
  final double fiber;
  final String? image;

  const FoodItem({
    required this.id,
    required this.name,
    required this.category,
    required this.servingSize,
    required this.calories,
    required this.protein,
    required this.carbohydrates,
    required this.fat,
    required this.fiber,
    this.image,
  });
}
