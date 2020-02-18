import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

part 'grid.g.dart';

/// 列表配置
@JsonSerializable()
class MyGridConfig {
  /// 列表文字
  @JsonKey(defaultValue: '')
  final String text;

  /// 列表图标
  @JsonKey(defaultValue: '')
  final String icon;

  /// 列表目标
  final String aim;

  /// 跳转地址
  final String url;

  MyGridConfig({@required this.text, @required this.icon, this.aim, this.url});
  factory MyGridConfig.fromJson(Map<String, dynamic> json) =>
      _$MyGridConfigFromJson(json);

  Map<String, dynamic> toJson() => _$MyGridConfigToJson(this);
}

@JsonSerializable()
class MyGrid extends StatelessWidget {
  /// 段落内容
  @JsonKey(fromJson: _getContentFromJson)
  final List<MyGridConfig> content;

  /// 列表标题
  final dynamic head;

  /// 列表页脚
  final dynamic foot;

  MyGrid(this.content, {this.head, this.foot});
  factory MyGrid.fromJson(Map<String, dynamic> json) => _$MyGridFromJson(json);

  Map<String, dynamic> toJson() => _$MyGridToJson(this);

  /// 从 JSON 生成 content
  static List<MyGridConfig> _getContentFromJson(
          List<Map<String, String>> content) =>
      List.generate(
          content.length, (index) => MyGridConfig.fromJson(content[index]));

  /// 获取渲染的项
  Widget _gridTile(int index) {
    final config = content[index];

    return GridTile(
        child: Column(children: [
      // 图标
      Container(
        margin: const EdgeInsets.only(top: 8, bottom: 4),
        width: 40,
        height: 40,
        child: CachedNetworkImage(
          imageUrl: config.icon,
          errorWidget: (context, url, error) => Icon(Icons.error),
        ),
      ),

      // 文字
      Padding(
        padding: const EdgeInsets.only(bottom: 8),
        child: Text(config.text),
      ),
    ]));
  }

  /// 渲染的列表
  List<Widget> get _getGrid => List.generate(content.length, _gridTile);

  @override
  Widget build(BuildContext context) => GridView.count(
        crossAxisCount: 3,
        children: _getGrid,
      );
}