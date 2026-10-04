import 'package:flutter/material.dart';

class MealsHeader extends StatelessWidget {
  final VoidCallback onSearch;

  const MealsHeader({super.key, required this.onSearch});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Meals',
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.w800,
                  color: Color(0xFF17312B),
                ),
              ),
              SizedBox(height: 5),
              Text(
                'Track what you eat and understand your nutrition.',
                style: TextStyle(color: Color(0xFF71837D), height: 1.35),
              ),
            ],
          ),
        ),
        IconButton(
          onPressed: onSearch,
          icon: const Icon(Icons.search_rounded),
          tooltip: 'Search foods',
        ),
        const Padding(
          padding: EdgeInsets.only(top: 9),
          child: Icon(Icons.spa_rounded, color: Color(0xFF72C994), size: 25),
        ),
      ],
    );
  }
}
