import 'package:flutter/material.dart';
import 'package:personal_diet_journal/models/meal.dart';
import 'meal_card.dart';

class MealSection extends StatelessWidget {
  final String type;
  final List<Meal> meals;
  final ValueChanged<Meal> onTap;
  final ValueChanged<Meal> onEdit;
  final ValueChanged<Meal> onDelete;
  final VoidCallback onAdd;
  const MealSection({
    super.key,
    required this.type,
    required this.meals,
    required this.onTap,
    required this.onEdit,
    required this.onDelete,
    required this.onAdd,
  });
  @override
  Widget build(BuildContext context) {
    final icon =
        {
          'Breakfast': '🌅',
          'Lunch': '☀️',
          'Dinner': '🌙',
          'Snack': '🍎',
        }[type] ??
        '🥗';
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              '$icon  $type',
              style: const TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.w800,
                color: Color(0xFF17312B),
              ),
            ),
            const Spacer(),
            if (meals.isEmpty)
              TextButton(onPressed: onAdd, child: const Text('+ Add')),
          ],
        ),
        const SizedBox(height: 10),
        if (meals.isEmpty && type == 'Snack') _SnackEmpty(onAdd: onAdd),
        if (meals.isEmpty && type != 'Snack')
          Text(
            'No $type logged yet.',
            style: const TextStyle(color: Color(0xFF81918B)),
          ),
        ...meals.map(
          (meal) => Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: MealCard(
              meal: meal,
              onTap: () => onTap(meal),
              onEdit: () => onEdit(meal),
              onDelete: () => onDelete(meal),
            ),
          ),
        ),
      ],
    );
  }
}

class _SnackEmpty extends StatelessWidget {
  final VoidCallback onAdd;
  const _SnackEmpty({required this.onAdd});
  @override
  Widget build(BuildContext context) => Container(
    width: double.infinity,
    padding: const EdgeInsets.all(18),
    decoration: BoxDecoration(
      color: const Color(0xFFFFFBED),
      borderRadius: BorderRadius.circular(18),
    ),
    child: Row(
      children: [
        const Text('🍏', style: TextStyle(fontSize: 28)),
        const SizedBox(width: 12),
        const Expanded(
          child: Text(
            'No snacks logged yet.\nA small healthy snack can be part of your balanced day.',
            style: TextStyle(color: Color(0xFF776A42), height: 1.35),
          ),
        ),
        TextButton(onPressed: onAdd, child: const Text('+ Add Snack')),
      ],
    ),
  );
}
