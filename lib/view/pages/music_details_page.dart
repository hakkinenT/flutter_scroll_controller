import 'package:flutter/material.dart';

class MusicDetailsPage extends StatelessWidget {
  final String name;
  const MusicDetailsPage({super.key, required this.name});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Music Details"),
      ),
      body: Center(
        child: Text(name),
      ),
    );
  }
}
