import 'package:flutter/material.dart';

class WaterTrackerCard extends StatelessWidget {
  final int consumed;
  final int goal;
  final VoidCallback? onAdd;

  const WaterTrackerCard({
    super.key,
    required this.consumed,
    required this.goal,
    this.onAdd,
  });

  @override
  Widget build(BuildContext context) {
    final filled = consumed.clamp(0, goal);
    final percent = goal == 0 ? 0.0 : (filled / goal);

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
          Row(
            children: [
              const Text(
                'Water Intake',
                style: TextStyle(
                  fontSize: 18,
                  color: Color(0xFF15362D),
                  fontWeight: FontWeight.w800,
                ),
              ),
              const Spacer(),
              InkWell(
                onTap: onAdd,
                borderRadius: BorderRadius.circular(12),
                child: Container(
                  width: 36,
                  height: 36,
                  decoration: BoxDecoration(
                    color: const Color(0xFFEEF8FF),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Icon(
                    Icons.add_rounded,
                    color: Color(0xFF2F7BFF),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Text(
            '$consumed / $goal glasses',
            style: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w800,
              color: Color(0xFF17312B),
            ),
          ),
          const SizedBox(height: 16),
          Wrap(
            spacing: 8,
            runSpacing: 10,
            children: List.generate(goal, (index) {
              final isFilled = index < filled;
              return AnimatedContainer(
                duration: const Duration(milliseconds: 250),
                width: 26,
                height: 32,
                decoration: BoxDecoration(
                  color: isFilled ? const Color(0xFF69B6FF) : const Color(0xFFEAF3F9),
                  borderRadius: const BorderRadius.vertical(top: Radius.circular(8)),
                  border: Border.all(
                    color: isFilled ? const Color(0xFF4FA4FF) : const Color(0xFFDDEAF5),
                    width: 1,
                  ),
                ),
                child: isFilled
                    ? Container(
                        margin: const EdgeInsets.only(top: 8),
                        decoration: const BoxDecoration(
                          gradient: LinearGradient(
                            colors: [Color(0xFF72CEFF), Color(0xFF3B8FFF)],
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                          ),
                          borderRadius: BorderRadius.vertical(top: Radius.circular(8)),
                        ),
                      )
                    : null,
              );
            }),
          ),
          const SizedBox(height: 16),
          RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: '${(percent * 100).round()}%',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w800,
                    color: Color(0xFF1A9E63),
                  ),
                ),
                const TextSpan(
                  text: ' of your daily goal',
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF6D7F7B),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
