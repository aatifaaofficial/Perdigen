import 'package:flutter/material.dart';
import 'package:personal_diet_journal/models/meal.dart';

class MealCard extends StatelessWidget {
  final Meal meal;
  final VoidCallback onTap;
  final VoidCallback onEdit;
  final VoidCallback onDelete;
  const MealCard({
    super.key,
    required this.meal,
    required this.onTap,
    required this.onEdit,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    final color =
        {
          'Breakfast': const Color(0xFFFFA94D),
          'Lunch': const Color(0xFF24A866),
          'Dinner': const Color(0xFF8B68FF),
          'Snack': const Color(0xFFF4C84E),
        }[meal.type] ??
        const Color(0xFF24A866);
    final thumbnail = meal.foods.isEmpty
        ? '🥗'
        : (meal.foods.first.food.image ?? '🥗');
    return Card(
      elevation: 0,
      margin: EdgeInsets.zero,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: InkWell(
        borderRadius: BorderRadius.circular(20),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 64,
                height: 64,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: color.withValues(alpha: .14),
                  borderRadius: BorderRadius.circular(18),
                ),
                child: Text(thumbnail, style: const TextStyle(fontSize: 32)),
              ),
              const SizedBox(width: 13),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      meal.foods.map((item) => item.food.name).join(', '),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w800,
                        color: Color(0xFF17312B),
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      meal.foods
                          .map((item) => item.food.servingSize)
                          .join(' · '),
                      style: const TextStyle(
                        color: Color(0xFF71837D),
                        fontSize: 12,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      '${meal.totalCalories.round()} kcal  ·  P ${meal.totalProtein.round()}g  ·  C ${meal.totalCarbohydrates.round()}g  ·  F ${meal.totalFat.round()}g',
                      style: TextStyle(
                        color: color,
                        fontSize: 11,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ],
                ),
              ),
              PopupMenuButton<String>(
                onSelected: (value) {
                  if (value == 'edit') {
                    onEdit();
                  } else if (value == 'delete') {
                    onDelete();
                  } else {
                    onTap();
                  }
                },
                itemBuilder: (_) => const [
                  PopupMenuItem(value: 'edit', child: Text('Edit')),
                  PopupMenuItem(value: 'details', child: Text('View Details')),
                  PopupMenuItem(value: 'delete', child: Text('Delete')),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
