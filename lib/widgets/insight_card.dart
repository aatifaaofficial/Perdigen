import 'package:flutter/material.dart';
import 'package:personal_diet_journal/models/dashboard_data.dart';

class InsightCard extends StatelessWidget {
  final List<Insight> insights;
  final VoidCallback? onViewInsights;

  const InsightCard({
    super.key,
    required this.insights,
    this.onViewInsights,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFFEAFBF2), Color(0xFFF3FCF6)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(26),
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
                  color: const Color(0xFFDBF5E5),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: const Icon(
                  Icons.lightbulb_rounded,
                  color: Color(0xFF1CA864),
                ),
              ),
              const SizedBox(width: 12),
              const Text(
                'Smart Insight 💡',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w800,
                  color: Color(0xFF15362D),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          for (int i = 0; i < insights.length; i++)
            Padding(
              padding: EdgeInsets.only(bottom: i == insights.length - 1 ? 0 : 12),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(
                    insights[i].icon,
                    size: 18,
                    color: const Color(0xFF1CA864),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      insights[i].detail,
                      style: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF23453C),
                        height: 1.5,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          const SizedBox(height: 16),
          InkWell(
            onTap: onViewInsights,
            child: const Text(
              'View Insights →',
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w800,
                color: Color(0xFF1B9D5F),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
