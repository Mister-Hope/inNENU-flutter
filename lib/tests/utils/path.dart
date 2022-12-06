import 'dart:io';

import 'package:flutter/material.dart';
import 'package:innenu/utils/path.dart';
import 'package:innenu/widgets/components/components.dart';
import 'package:path_provider/path_provider.dart';

class PathTestState extends State<PathTest> {
  String tempPath = '';
  String appDataPath = '';
  String appFilePath = '';
  String extPath = '';
  String downloadPath = '';

  @override
  void initState() {
    super.initState();
    Path.tempPath.then((tempPath) {
      setState(() {
        this.tempPath = tempPath;
      });
    });
    Path.appDataPath.then((appDataPath) {
      setState(() {
        this.appDataPath = appDataPath;
      });
    });
    Path.appFilePath.then((appFilePath) {
      setState(() {
        this.appFilePath = appFilePath;
      });
    });

    extPath = extPath;

    if (!Platform.isIOS) {
      getExternalStorageDirectories(type: StorageDirectory.downloads)
          .then((downloadPath) {
        this.downloadPath = downloadPath![0].path;
      });
    }
  }

  @override
  Widget build(BuildContext context) => Scaffold(
      appBar: AppBar(
        title: const Text('File 相关测试'),
      ),
      body: ListView(
        children: [
          const TitleComponent('应用文件目录'),
          TextComponent(text: appFilePath),
          const TitleComponent('应用数据目录'),
          TextComponent(text: appDataPath),
          const TitleComponent('缓存目录'),
          TextComponent(text: tempPath),
          const TitleComponent('外部存储目录'),
          TextComponent(text: extPath),
          const TitleComponent('下载目录'),
          TextComponent(text: downloadPath),
        ],
      ));
}

class PathTest extends StatefulWidget {
  const PathTest({Key? key}) : super(key: key);

  @override
  PathTestState createState() => PathTestState();
}
