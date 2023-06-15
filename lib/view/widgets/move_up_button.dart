import 'package:flutter/material.dart';

class MoveUpButton extends StatelessWidget {
  const MoveUpButton({super.key, required this.onPressed});

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: onPressed,
      child: const Icon(Icons.arrow_upward),
    );
  }
}
