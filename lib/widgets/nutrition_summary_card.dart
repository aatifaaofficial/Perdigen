import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:personal_diet_journal/models/dashboard_data.dart';

class NutritionSummaryCard extends StatelessWidget {
  final NutritionBreakdown nutrition;
  final int calories;
  final VoidCallback? onViewDetails;

  const NutritionSummaryCard({
    super.key,
    required this.nutrition,
    required this.calories,
    this.onViewDetails,
  });

  @override
  Widget build(BuildContext context) {
    final items = [
      _NutritionLegendItem(
        label: 'Carbs',
        value: nutrition.carbohydrates,
        color: const Color(0xFFF6B157),
      ),
      _NutritionLegendItem(
        label: 'Protein',
        value: nutrition.protein,
        color: const Color(0xFF70D69D),
      ),
      _NutritionLegendItem(
        label: 'Fat',
        value: nutrition.fat,
        color: const Color(0xFF9A7BFF),
      ),
      _NutritionLegendItem(
        label: 'Fiber',
        value: nutrition.fiber,
        color: const Color(0xFF57C7C1),
      ),
    ];

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(26),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 12,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Nutrition Summary',
            style: TextStyle(
              fontSize: 18,
              color: Color(0xFF15362D),
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(height: 18),
          LayoutBuilder(
            builder: (context, constraints) {
              final chartSize = constraints.maxWidth > 320 ? 170.0 : 140.0;
              return Row(
                children: [
                  SizedBox(
                    width: chartSize,
                    height: chartSize,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        SizedBox(
                          width: chartSize,
                          height: chartSize,
                          child: TweenAnimationBuilder<double>(
                            duration: const Duration(milliseconds: 900),
                            curve: Curves.easeOutCubic,
                            tween: Tween<double>(begin: 0, end: 1),
                            builder: (context, value, child) {
                              return CircularProgressIndicator(
                                value: value,
                                strokeWidth: 18,
                                backgroundColor: const Color(0xFFEAF5EF),
                                valueColor: const AlwaysStoppedAnimation<Color>(
                                  Colors.transparent,
                                ),
                              );
                            },
                          ),
                        ),
                        SizedBox(
                          width: chartSize,
                          height: chartSize,
                          child: CustomPaint(
                            painter: _NutritionChartPainter(
                              percentages: [
                                nutrition.carbohydrates,
                                nutrition.protein,
                                nutrition.fat,
                                nutrition.fiber,
                              ],
                              colors: const [
                                Color(0xFFF6B157),
                                Color(0xFF70D69D),
                                Color(0xFF9A7BFF),
                                Color(0xFF57C7C1),
                              ],
                            ),
                          ),
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              'Total',
                              style: TextStyle(
                                fontSize: 12,
                                color: Color(0xFF7A8D88),
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              '$calories kcal',
                              style: const TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.w800,
                                color: Color(0xFF17312B),
                              ),
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
                        for (final item in items)
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 6),
                            child: Row(
                              children: [
                                Container(
                                  width: 10,
                                  height: 10,
                                  decoration: BoxDecoration(
                                    color: item.color,
                                    shape: BoxShape.circle,
                                  ),
                                ),
                                const SizedBox(width: 8),
                                Text(
                                  '${item.label}: ${item.value.round()}%',
                                  style: const TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w600,
                                    color: Color(0xFF26473D),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        const SizedBox(height: 12),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: InkWell(
                            onTap: onViewDetails,
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 14,
                                vertical: 10,
                              ),
                              decoration: BoxDecoration(
                                color: const Color(0xFFEAF8F1),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: const Text(
                                'View Details →',
                                style: TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w700,
                                  color: Color(0xFF1C9B60),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}

class _NutritionLegendItem {
  final String label;
  final double value;
  final Color color;

  const _NutritionLegendItem({
    required this.label,
    required this.value,
    required this.color,
  });
}

class _NutritionChartPainter extends CustomPainter {
  final List<double> percentages;
  final List<Color> colors;

  const _NutritionChartPainter({
    required this.percentages,
    required this.colors,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final rect = Rect.fromCircle(
      center: size.center(Offset.zero),
      radius: size.width / 2 - 12,
    );

    final total = percentages.fold<double>(0, (sum, value) => sum + value);
    double startAngle = -math.pi / 2;

    for (var i = 0; i < percentages.length; i++) {
      final sweep = (percentages[i] / total) * 2 * math.pi;
      final paint = Paint()
        ..color = colors[i]
        ..style = PaintingStyle.stroke
        ..strokeWidth = 18
        ..strokeCap = StrokeCap.round;
      canvas.drawArc(rect, startAngle, sweep, false, paint);
      startAngle += sweep;
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
