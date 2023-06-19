import 'package:flutter/material.dart';
import 'package:flutter_scroll_controller/constants/constants.dart';
import 'package:flutter_scroll_controller/utils/show_snacbar.dart';

import '../widgets/move_down_button.dart';
import '../widgets/move_up_button.dart';

final PageStorageBucket _pageBucket = PageStorageBucket();
PageStorageKey _myKey = const PageStorageKey("textPage");

class TextPage extends StatefulWidget {
  const TextPage({super.key});

  @override
  State<TextPage> createState() => _TextPageState();
}

class _TextPageState extends State<TextPage> {
  late final ScrollController _scrollController;
  bool _up = false;
  final double _textSize = 150.0;
  bool _isTapped = false;

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
        _up = false;
      });
      showSnackbar(context, "Início do Texto");
    } else if (isPageEnd) {
      setState(() {
        _up = true;
      });
      showSnackbar(context, "Fim do Texto");
    }
    _pageBucket.writeState(context, _up, identifier: ValueKey(_myKey));
  }

  _moveUp() {
    _move(_scrollController.offset - _textSize);
  }

  _moveDown() {
    _move(_scrollController.offset + _textSize);
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
      body: PageStorage(
        key: ValueKey(_myKey),
        bucket: _pageBucket,
        child: GestureDetector(
          onTap: _onTap,
          child: ListView(
            key: const PageStorageKey("list_textPage"),
            controller: _scrollController,
            padding: const EdgeInsets.all(20.0),
            children: [
              Text(text),
            ],
          ),
        ),
      ),
      floatingActionButton: _isTapped
          ? _up
              ? MoveUpButton(
                  onPressed: _moveUp,
                )
              : MoveDownButton(
                  onPressed: _moveDown,
                )
          : null,
    );
  }

  _onTap() {
    setState(() {
      _isTapped = !_isTapped;
    });

    final bool? move =
        _pageBucket.readState(context, identifier: ValueKey(_myKey));

    if (move != null) {
      setState(() {
        _up = move;
      });
    }
  }
}
