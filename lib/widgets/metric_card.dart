import 'package:flutter/material.dart';
import 'package:personal_diet_journal/models/dashboard_data.dart';

class MetricCard extends StatelessWidget {
  final MetricGoal metric;
  final VoidCallback? onTap;

  const MetricCard({
    super.key,
    required this.metric,
    this.onTap,
  });

  double _progressValue() {
    if (metric.goal <= 0) return 0;
    return (metric.current / metric.goal).clamp(0.0, 1.0);
  }

  @override
  Widget build(BuildContext context) {
    final progress = _progressValue();
    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(22),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(22),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 250),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(22),
            color: Colors.white,
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
                children: [
                  Container(
                    width: 42,
                    height: 42,
                    decoration: BoxDecoration(
                      color: metric.color.withValues(alpha: 0.14),
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: Icon(
                      metric.icon,
                      color: metric.color,
                      size: 22,
                    ),
                  ),
                  const Spacer(),
                  if (metric.showTrend)
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
                      decoration: BoxDecoration(
                        color: const Color(0xFFDBFBF2),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(
                        metric.trendLabel,
                        style: const TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.w700,
                          color: Color(0xFF1AA77B),
                        ),
                      ),
                    ),
                ],
              ),
              const SizedBox(height: 12),
              Text(
                metric.title,
                style: const TextStyle(
                  fontSize: 13,
                  color: Color(0xFF60706C),
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                metric.value,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w800,
                  color: Color(0xFF17312B),
                ),
              ),
              const SizedBox(height: 12),
              if (!metric.isMood)
                Column(
                  children: [
                    TweenAnimationBuilder<double>(
                      duration: const Duration(milliseconds: 1000),
                      curve: Curves.easeOutCubic,
                      tween: Tween<double>(begin: 0, end: progress),
                      builder: (context, value, child) {
                        return LinearProgressIndicator(
                          value: value,
                          minHeight: 8,
                          borderRadius: BorderRadius.circular(10),
                          backgroundColor: metric.color.withValues(alpha: 0.12),
                          valueColor: AlwaysStoppedAnimation<Color>(metric.color),
                        );
                      },
                    ),
                    const SizedBox(height: 8),
                    Text(
                      metric.subtitle,
                      style: TextStyle(
                        fontSize: 11,
                        color: metric.color.withValues(alpha: 0.9),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                )
              else
                Row(
                  children: [
                    Container(
                      width: 10,
                      height: 10,
                      decoration: BoxDecoration(
                        color: metric.color,
                        shape: BoxShape.circle,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      metric.subtitle,
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF6D7C73),
                      ),
                    ),
                  ],
                ),
            ],
          ),
        ),
      ),
    );
  }
}
