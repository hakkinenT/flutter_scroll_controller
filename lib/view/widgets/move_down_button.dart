import 'package:flutter/material.dart';

class MoveDownButton extends StatelessWidget {
  const MoveDownButton({super.key, required this.onPressed});

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: onPressed,
      child: const Icon(Icons.arrow_downward),
    );
  }
}
