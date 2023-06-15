import 'package:flutter/material.dart';
import 'package:flutter_scroll_controller/constants/constants.dart';

import '../widgets/move_down_button.dart';
import '../widgets/move_up_button.dart';

class TextPage extends StatefulWidget {
  const TextPage({super.key});

  @override
  State<TextPage> createState() => _TextPageState();
}

class _TextPageState extends State<TextPage> {
  late final ScrollController _scrollController;
  bool up = false;
  final textSize = 150.0;

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
    _move(_scrollController.offset - textSize);
  }

  _moveDown() {
    _move(_scrollController.offset + textSize);
  }

  _move(double offset) {
    if (_scrollController.hasClients) {
      _scrollController.animateTo(offset,
          duration: const Duration(milliseconds: 500), curve: Curves.linear);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Read Text'),
      ),
      body: ListView(
        controller: _scrollController,
        padding: const EdgeInsets.all(20.0),
        children: [
          Text(text),
        ],
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
