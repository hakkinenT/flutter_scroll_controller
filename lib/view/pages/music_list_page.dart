import 'package:flutter/material.dart';

import '../../constants/constants.dart';
import '../widgets/move_down_button.dart';
import '../widgets/move_up_button.dart';

class MusicListPage extends StatefulWidget {
  const MusicListPage({super.key});

  @override
  State<MusicListPage> createState() => _MusicListPageState();
}

class _MusicListPageState extends State<MusicListPage> {
  late final ScrollController _scrollController;
  bool up = false;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener(_scrollListener);
  }

  _scrollListener() {
    bool isPageInit = _scrollController.offset <=
            _scrollController.position.minScrollExtent &&
        !_scrollController.position.outOfRange;

    bool isPageEnd = _scrollController.offset >=
            _scrollController.position.maxScrollExtent &&
        !_scrollController.position.outOfRange;

    if (isPageInit) {
      setState(() {
        up = false;
      });
    } else if (isPageEnd) {
      setState(() {
        up = true;
      });
    }
  }

  _moveUp() {
    _scrollController.jumpTo(0.0);
  }

  _moveDown() {
    final maxExtent = _scrollController.position.maxScrollExtent;
    _scrollController.jumpTo(maxExtent);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Musics'),
      ),
      body: ListView.builder(
        controller: _scrollController,
        padding: const EdgeInsets.all(20),
        itemCount: musics.length,
        itemBuilder: (context, index) {
          return Card(
            child: ListTile(
              leading: const Icon(Icons.music_note),
              title: Text(musics[index]),
            ),
          );
        },
      ),
      floatingActionButton: up
          ? MoveUpButton(
              onPressed: () => _moveUp(),
            )
          : MoveDownButton(
              onPressed: () => _moveDown(),
            ),
    );
  }
}
