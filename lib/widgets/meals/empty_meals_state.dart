import 'package:flutter/material.dart';

class EmptyMealsState extends StatelessWidget {
  final VoidCallback onAdd;
  const EmptyMealsState({super.key, required this.onAdd});
  @override
  Widget build(BuildContext context) => Center(
    child: Padding(
      padding: const EdgeInsets.symmetric(vertical: 48, horizontal: 28),
      child: Column(
        children: [
          const Text('🥗', style: TextStyle(fontSize: 50)),
          const SizedBox(height: 12),
          const Text(
            'No meals logged yet',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w800,
              color: Color(0xFF17312B),
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'Start tracking your meals to understand your daily nutrition.',
            textAlign: TextAlign.center,
            style: TextStyle(color: Color(0xFF71837D), height: 1.4),
          ),
          const SizedBox(height: 18),
          FilledButton.icon(
            onPressed: onAdd,
            icon: const Icon(Icons.add_rounded),
            label: const Text('Add Your First Meal'),
          ),
        ],
      ),
    ),
  );
}
