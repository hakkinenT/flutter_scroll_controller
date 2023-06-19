import 'package:flutter/material.dart';
import 'package:flutter_scroll_controller/utils/show_snacbar.dart';
import 'package:flutter_scroll_controller/view/pages/music_details_page.dart';

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

  @override
  void dispose() {
    _scrollController.removeListener(_scrollListener);
    super.dispose();
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
      showSnackbar(context, "Início da Lista");
    } else if (isPageEnd) {
      setState(() {
        up = true;
      });
      showSnackbar(context, "Fim da Lista");
    }
  }

  _moveUp() {
    _move(0.0);
  }

  _moveDown() {
    final maxScrollExtent = _scrollController.position.maxScrollExtent;
    _move(maxScrollExtent);
  }

  _move(double value) {
    _scrollController.jumpTo(value);
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
          return InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => MusicDetailsPage(name: musics[index]),
                ),
              );
            },
            child: Card(
              child: ListTile(
                leading: const Icon(Icons.music_note),
                title: Text(musics[index]),
              ),
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
