import 'package:flutter/material.dart';
import 'package:personal_diet_journal/data/meal_repository.dart';
import 'package:personal_diet_journal/models/meal.dart';
import 'add_meal_page.dart';

class MealDetailsPage extends StatelessWidget {
  final Meal meal;
  final MealRepository repository;
  const MealDetailsPage({
    super.key,
    required this.meal,
    required this.repository,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(meal.type),
        backgroundColor: Colors.transparent,
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.fromLTRB(18, 4, 18, 24),
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFFE8F7EE), Color(0xFFF8FCF9)],
                ),
                borderRadius: BorderRadius.circular(24),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    meal.foods.map((item) => item.food.name).join(' + '),
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w800,
                      color: Color(0xFF17312B),
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    '${meal.totalCalories.round()} kcal total',
                    style: const TextStyle(
                      color: Color(0xFF24A866),
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            ...meal.foods.map(
              (item) => ListTile(
                contentPadding: EdgeInsets.zero,
                leading: Text(
                  item.food.image ?? '🥗',
                  style: const TextStyle(fontSize: 28),
                ),
                title: Text(
                  item.food.name,
                  style: const TextStyle(fontWeight: FontWeight.w700),
                ),
                subtitle: Text('${item.quantity} × ${item.food.servingSize}'),
                trailing: Text(
                  '${(item.food.calories * item.quantity).round()} kcal',
                ),
              ),
            ),
            const SizedBox(height: 10),
            _MetricGrid(meal: meal),
            const SizedBox(height: 24),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: () async {
                      await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => AddMealPage(
                            repository: repository,
                            date: meal.date,
                            initialMeal: meal,
                          ),
                        ),
                      );
                      if (context.mounted) Navigator.pop(context, true);
                    },
                    icon: const Icon(Icons.edit_rounded),
                    label: const Text('Edit Meal'),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: FilledButton.icon(
                    onPressed: () => _delete(context),
                    icon: const Icon(Icons.delete_outline_rounded),
                    label: const Text('Delete'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _delete(BuildContext context) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Delete Meal?'),
        content: const Text(
          "Are you sure you want to remove this meal from today's journal?",
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Delete'),
          ),
        ],
      ),
    );
    if (confirmed == true) {
      await repository.deleteMeal(meal.id);
      if (context.mounted) Navigator.pop(context, true);
    }
  }
}

class _MetricGrid extends StatelessWidget {
  final Meal meal;
  const _MetricGrid({required this.meal});
  @override
  Widget build(BuildContext context) {
    final values = [
      ('Calories', meal.totalCalories, 'kcal'),
      ('Protein', meal.totalProtein, 'g'),
      ('Carbs', meal.totalCarbohydrates, 'g'),
      ('Fat', meal.totalFat, 'g'),
      ('Fiber', meal.totalFiber, 'g'),
    ];
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: values
          .map(
            (item) => Container(
              width: 105,
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: const Color(0xFFF5F9F6),
                borderRadius: BorderRadius.circular(14),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.$1,
                    style: const TextStyle(
                      fontSize: 11,
                      color: Color(0xFF71837D),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '${item.$2.round()}${item.$3}',
                    style: const TextStyle(
                      fontWeight: FontWeight.w800,
                      color: Color(0xFF17312B),
                    ),
                  ),
                ],
              ),
            ),
          )
          .toList(),
    );
  }
}
