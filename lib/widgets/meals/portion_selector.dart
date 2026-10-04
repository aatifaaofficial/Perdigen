import 'package:flutter/material.dart';
import 'package:personal_diet_journal/models/food_item.dart';

class PortionSelector extends StatefulWidget {
  final FoodItem food;
  const PortionSelector({super.key, required this.food});
  @override
  State<PortionSelector> createState() => _PortionSelectorState();
}

class _PortionSelectorState extends State<PortionSelector> {
  double quantity = 1;
  @override
  Widget build(BuildContext context) {
    final food = widget.food;
    return AlertDialog(
      title: Text('Add ${food.name}'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Serving size: ${food.servingSize}',
            style: const TextStyle(color: Color(0xFF71837D)),
          ),
          const SizedBox(height: 18),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Quantity',
                style: TextStyle(fontWeight: FontWeight.w700),
              ),
              Row(
                children: [
                  IconButton(
                    onPressed: quantity > .5
                        ? () => setState(() => quantity -= .5)
                        : null,
                    icon: const Icon(Icons.remove_circle_outline_rounded),
                  ),
                  Text(
                    quantity % 1 == 0
                        ? quantity.toInt().toString()
                        : quantity.toStringAsFixed(1),
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  IconButton(
                    onPressed: () => setState(() => quantity += .5),
                    icon: const Icon(Icons.add_circle_outline_rounded),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 10),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: const Color(0xFFEAF8F1),
              borderRadius: BorderRadius.circular(14),
            ),
            child: Text(
              '${(food.calories * quantity).round()} kcal  ·  Protein ${(food.protein * quantity).toStringAsFixed(1)}g  ·  Carbs ${(food.carbohydrates * quantity).toStringAsFixed(1)}g',
              style: const TextStyle(
                color: Color(0xFF1C9B60),
                fontWeight: FontWeight.w700,
                fontSize: 12,
              ),
            ),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Cancel'),
        ),
        FilledButton(
          onPressed: () => Navigator.pop(context, quantity),
          child: const Text('Add to Meal'),
        ),
      ],
    );
  }
}
