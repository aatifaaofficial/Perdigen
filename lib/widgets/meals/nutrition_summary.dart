import 'package:flutter/material.dart';

class NutritionSummary extends StatelessWidget {
  final double calories;
  final double target;
  final double protein;
  final double carbs;
  final double fat;
  final double fiber;

  const NutritionSummary({
    super.key,
    required this.calories,
    required this.target,
    required this.protein,
    required this.carbs,
    required this.fat,
    required this.fiber,
  });

  @override
  Widget build(BuildContext context) {
    final progress = (calories / target).clamp(0.0, 1.0);
    final remaining = (target - calories).clamp(0, target).round();
    final values = [
      ('Protein', protein, const Color(0xFF24A866)),
      ('Carbs', carbs, const Color(0xFFFFA94D)),
      ('Fat', fat, const Color(0xFF8B68FF)),
      ('Fiber', fiber, const Color(0xFF36C5C0)),
    ];
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF1E9C62), Color(0xFF38B875)],
        ),
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF1E9C62).withValues(alpha: .2),
            blurRadius: 18,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Today's Nutrition",
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              SizedBox(
                width: 106,
                height: 106,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    CircularProgressIndicator(
                      value: 1,
                      strokeWidth: 10,
                      color: Colors.white.withValues(alpha: .2),
                    ),
                    TweenAnimationBuilder<double>(
                      tween: Tween(begin: 0, end: progress),
                      duration: const Duration(milliseconds: 700),
                      builder: (context, value, child) =>
                          CircularProgressIndicator(
                            value: value,
                            strokeWidth: 10,
                            strokeCap: StrokeCap.round,
                            color: Colors.white,
                          ),
                    ),
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          '${calories.round()}',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 22,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        const Text(
                          'kcal',
                          style: TextStyle(color: Colors.white70, fontSize: 11),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 18),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${calories.round()} / ${target.round()} kcal',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 17,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '$remaining kcal remaining',
                      style: const TextStyle(
                        color: Colors.white70,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 14),
                    Wrap(
                      spacing: 12,
                      runSpacing: 8,
                      children: values
                          .map(
                            (item) => _Value(
                              label: item.$1,
                              value: item.$2,
                              color: item.$3,
                            ),
                          )
                          .toList(),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _Value extends StatelessWidget {
  final String label;
  final double value;
  final Color color;
  const _Value({required this.label, required this.value, required this.color});
  @override
  Widget build(BuildContext context) => Row(
    mainAxisSize: MainAxisSize.min,
    children: [
      Icon(Icons.circle, size: 7, color: color),
      const SizedBox(width: 4),
      Text(
        '$label ${value.round()}g',
        style: const TextStyle(
          color: Colors.white,
          fontSize: 11,
          fontWeight: FontWeight.w700,
        ),
      ),
    ],
  );
}
