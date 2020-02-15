import 'package:flutter/material.dart';

class MyTitle extends StatelessWidget {
  /// 标题文字
  final String text;

  MyTitle({@required this.text});

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      Expanded(
          child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
              child: SelectableText(this.text)))
    ]);
  }
}
