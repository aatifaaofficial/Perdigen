import 'package:flutter/material.dart';

class BottomNavBar extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int>? onTap;

  const BottomNavBar({
    super.key,
    required this.currentIndex,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final navItems = [
      _NavItem(label: 'Home', icon: Icons.home_rounded),
      _NavItem(label: 'Meals', icon: Icons.restaurant_rounded),
      _NavItem(label: 'Add', icon: Icons.add_rounded, isCenter: true),
      _NavItem(label: 'Reports', icon: Icons.bar_chart_rounded),
      _NavItem(label: 'Profile', icon: Icons.person_rounded),
    ];

    return Container(
      margin: const EdgeInsets.fromLTRB(16, 0, 16, 18),
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(28),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.08),
            blurRadius: 20,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      child: Row(
        children: List.generate(navItems.length, (index) {
          final item = navItems[index];

          if (item.isCenter) {
            return Expanded(
              child: GestureDetector(
                onTap: () => onTap?.call(index),
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 6),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: const LinearGradient(
                      colors: [Color(0xFF39BC72), Color(0xFF1F9A5D)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xFF39BC72).withValues(alpha: 0.38),
                        blurRadius: 20,
                        offset: const Offset(0, 8),
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(14),
                    child: Icon(
                      item.icon,
                      color: Colors.white,
                      size: 28,
                    ),
                  ),
                ),
              ),
            );
          }

          final selected = currentIndex == index;
          return Expanded(
            child: InkWell(
              onTap: () => onTap?.call(index),
              borderRadius: BorderRadius.circular(16),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      item.icon,
                      color: selected ? const Color(0xFF1C9B60) : const Color(0xFF7C8F8A),
                      size: 24,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      item.label,
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w700,
                        color: selected ? const Color(0xFF1C9B60) : const Color(0xFF6E8A80),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}

class _NavItem {
  final String label;
  final IconData icon;
  final bool isCenter;

  const _NavItem({
    required this.label,
    required this.icon,
    this.isCenter = false,
  });
}
