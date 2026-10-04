import 'package:flutter/material.dart';
import 'package:personal_diet_journal/models/food_item.dart';

class FoodItemCard extends StatelessWidget {
  final FoodItem food;
  final VoidCallback onTap;
  const FoodItemCard({super.key, required this.food, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 10),
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
      child: InkWell(
        borderRadius: BorderRadius.circular(18),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(13),
          child: Row(
            children: [
              Text(food.image ?? '🥗', style: const TextStyle(fontSize: 30)),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      food.name,
                      style: const TextStyle(
                        fontWeight: FontWeight.w800,
                        color: Color(0xFF17312B),
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      food.servingSize,
                      style: const TextStyle(
                        color: Color(0xFF71837D),
                        fontSize: 12,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      '${food.calories.round()} kcal  ·  P ${food.protein}g  ·  C ${food.carbohydrates}g  ·  F ${food.fat}g',
                      style: const TextStyle(
                        color: Color(0xFF4D6B60),
                        fontSize: 11,
                      ),
                    ),
                  ],
                ),
              ),
              const Icon(
                Icons.add_circle_outline_rounded,
                color: Color(0xFF24A866),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
