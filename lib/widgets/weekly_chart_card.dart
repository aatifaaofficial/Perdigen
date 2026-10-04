import 'package:flutter/material.dart';
import 'package:personal_diet_journal/models/dashboard_data.dart';

class WeeklyChartCard extends StatefulWidget {
  final List<WeeklyStat> calories;
  final List<WeeklyStat> water;
  final List<WeeklyStat> sleep;
  final List<WeeklyStat> weight;
  final List<WeeklyStat> mood;

  const WeeklyChartCard({
    super.key,
    required this.calories,
    required this.water,
    required this.sleep,
    required this.weight,
    required this.mood,
  });

  @override
  State<WeeklyChartCard> createState() => _WeeklyChartCardState();
}

class _WeeklyChartCardState extends State<WeeklyChartCard> {
  String selectedMetric = 'Calories';

  List<WeeklyStat> _currentSeries() {
    switch (selectedMetric) {
      case 'Water':
        return widget.water;
      case 'Sleep':
        return widget.sleep;
      case 'Weight':
        return widget.weight;
      case 'Mood':
        return widget.mood;
      case 'Calories':
      default:
        return widget.calories;
    }
  }

  @override
  Widget build(BuildContext context) {
    final data = _currentSeries();
    final maxValue = data.fold<double>(0, (prev, item) => item.value > prev ? item.value : prev);

    return Container(
      padding: const EdgeInsets.all(18),
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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Weekly Progress',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w800,
                  color: Color(0xFF15362D),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                decoration: BoxDecoration(
                  color: const Color(0xFFEAF5EF),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    value: selectedMetric,
                    isDense: true,
                    dropdownColor: Colors.white,
                    style: const TextStyle(
                      color: Color(0xFF1B8E5D),
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                    ),
                    items: const [
                      DropdownMenuItem(value: 'Calories', child: Text('Calories')),
                      DropdownMenuItem(value: 'Water', child: Text('Water')),
                      DropdownMenuItem(value: 'Sleep', child: Text('Sleep')),
                      DropdownMenuItem(value: 'Weight', child: Text('Weight')),
                      DropdownMenuItem(value: 'Mood', child: Text('Mood')),
                    ],
                    onChanged: (value) {
                      if (value != null) {
                        setState(() => selectedMetric = value);
                      }
                    },
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          SizedBox(
            height: 180,
            child: TweenAnimationBuilder<double>(
              duration: const Duration(milliseconds: 1000),
              curve: Curves.easeOutCubic,
              tween: Tween<double>(begin: 0, end: 1),
              builder: (context, value, child) {
                return CustomPaint(
                  painter: _LineChartPainter(
                    data: data,
                    maxValue: maxValue == 0 ? 1 : maxValue,
                    progress: value,
                    color: data.first.color,
                  ),
                  child: const SizedBox.expand(),
                );
              },
            ),
          ),
          const SizedBox(height: 6),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: data.map((point) => Text(point.day, style: const TextStyle(fontSize: 10, color: Color(0xFF6E8A80)))).toList(),
          ),
        ],
      ),
    );
  }
}

class _LineChartPainter extends CustomPainter {
  final List<WeeklyStat> data;
  final double maxValue;
  final double progress;
  final Color color;

  const _LineChartPainter({
    required this.data,
    required this.maxValue,
    required this.progress,
    required this.color,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3
      ..strokeCap = StrokeCap.round;

    final fillPaint = Paint()
      ..shader = LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [color.withValues(alpha: 0.35), color.withValues(alpha: 0.04)],
      ).createShader(Rect.fromLTWH(0, 0, size.width, size.height));

    final points = <Offset>[];
    final plotRect = Rect.fromLTWH(12, 10, size.width - 20, size.height - 30);

    for (int i = 0; i < data.length; i++) {
      final x = plotRect.left + (i / (data.length - 1)) * plotRect.width;
      final valueRatio = data[i].value / maxValue;
      final y = plotRect.bottom - (valueRatio * plotRect.height * progress);
      points.add(Offset(x, y));
    }

    if (points.length > 1) {
      final path = Path()..moveTo(points.first.dx, points.first.dy);
      for (int i = 1; i < points.length; i++) {
        path.lineTo(points[i].dx, points[i].dy);
      }
      canvas.drawPath(path, paint);

      final fillPath = Path.from(path)
        ..lineTo(points.last.dx, plotRect.bottom)
        ..lineTo(points.first.dx, plotRect.bottom)
        ..close();
      canvas.drawPath(fillPath, fillPaint);

      for (final point in points) {
        canvas.drawCircle(point, 4.5, Paint()..color = color);
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
