import 'package:flutter/material.dart';

class HealthScoreCard extends StatelessWidget {
  final double score;
  final int maxScore;
  final String message;
  final String motivational;

  const HealthScoreCard({
    super.key,
    required this.score,
    required this.maxScore,
    required this.message,
    required this.motivational,
  });

  @override
  Widget build(BuildContext context) {
    final animatedValue = score / maxScore;
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF39BC72), Color(0xFF1A9E63)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(28),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF6ACD8F).withValues(alpha: 0.4),
            blurRadius: 25,
            offset: const Offset(0, 18),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Today\'s Health Score',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 18),
                Text(
                  message,
                  style: const TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  motivational,
                  style: const TextStyle(
                    fontSize: 13,
                    color: Color(0xFFE8FFF4),
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            width: 142,
            height: 142,
            child: TweenAnimationBuilder<double>(
              duration: const Duration(milliseconds: 1200),
              curve: Curves.easeOutCubic,
              tween: Tween<double>(begin: 0, end: animatedValue),
              builder: (context, value, child) {
                return Stack(
                  alignment: Alignment.center,
                  children: [
                    const Positioned(
                      top: 0,
                      right: 4,
                      child: Icon(
                        Icons.spa_rounded,
                        color: Color(0xFFB7F1C8),
                        size: 22,
                      ),
                    ),
                    const Positioned(
                      bottom: 0,
                      left: 2,
                      child: Icon(
                        Icons.self_improvement_rounded,
                        color: Color(0xFFD8FFE3),
                        size: 25,
                      ),
                    ),
                    SizedBox(
                      width: 116,
                      height: 116,
                      child: CircularProgressIndicator(
                        value: 1,
                        strokeWidth: 10,
                        backgroundColor: Colors.white.withValues(alpha: 0.22),
                        valueColor: const AlwaysStoppedAnimation<Color>(
                          Colors.white24,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 116,
                      height: 116,
                      child: CircularProgressIndicator(
                        value: value,
                        strokeWidth: 10,
                        backgroundColor: Colors.transparent,
                        valueColor: const AlwaysStoppedAnimation<Color>(
                          Colors.white,
                        ),
                        strokeCap: StrokeCap.round,
                      ),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          score.toStringAsFixed(0),
                          style: const TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.w800,
                            color: Colors.white,
                          ),
                        ),
                        const Text(
                          '/ 100',
                          style: TextStyle(
                            fontSize: 12,
                            color: Color(0xFFE8FFF4),
                          ),
                        ),
                      ],
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
