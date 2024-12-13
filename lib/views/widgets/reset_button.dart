import 'package:flutter/material.dart';

class ResetButton extends StatelessWidget {
  const ResetButton({super.key, required this.resetFiltersAndSearch});

  final void Function() resetFiltersAndSearch;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: resetFiltersAndSearch,
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.black.withOpacity(0.75),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
      ),
      label: const Icon(Icons.refresh, size: 24),
    );
  }
}
