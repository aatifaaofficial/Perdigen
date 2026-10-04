import 'package:flutter/material.dart';

class FoodSearchBar extends StatelessWidget {
  final ValueChanged<String> onChanged;
  const FoodSearchBar({super.key, required this.onChanged});
  @override
  Widget build(BuildContext context) => TextField(
    onChanged: onChanged,
    decoration: InputDecoration(
      hintText: 'Search food...',
      prefixIcon: const Icon(Icons.search_rounded),
      filled: true,
      fillColor: const Color(0xFFF3F8F5),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: BorderSide.none,
      ),
    ),
  );
}
