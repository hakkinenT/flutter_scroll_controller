import 'package:flutter/material.dart';
import 'package:flutter_scroll_controller/view/pages/music_list_page.dart';
import 'package:flutter_scroll_controller/view/pages/text_page.dart';
import 'package:flutter_scroll_controller/view/widgets/custom_elevate_button.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home Page"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomElevatedButton(
              label: "See Text Page",
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const TextPage(),
                  ),
                );
              },
            ),
            const SizedBox(
              height: 20,
            ),
            CustomElevatedButton(
              label: "See Music List Page",
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const MusicListPage(),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
