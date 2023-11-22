import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

part 'title.g.dart';

/// 标题组件
@JsonSerializable()
class TitleComponent extends StatelessWidget {
  const TitleComponent(
    this.text, {
    super.key,
  });
  factory TitleComponent.fromJson(Map<String, dynamic> json) =>
      _$TitleComponentFromJson(json);

  Map<String, dynamic> toJson() => _$TitleComponentToJson(this);

  /// 标题文字
  final String text;

  @override
  Widget build(BuildContext context) => Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
      child: SelectableText(
        text,
        style: Theme.of(context).textTheme.titleLarge,
      ));
}
