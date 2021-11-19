import 'package:flutter/material.dart';

import 'package:innenu/widgets/components/components.dart';

class ImageTest extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Scaffold(
      appBar: AppBar(
        title: const Text('Image 测试'),
      ),
      body: ListView(
        children: const [
          TextComponent(text: '普通图片'),
          ImageComponent('https://mp.innenu.com/img/arrival/pickup.jpg'),
          TextComponent(text: '包含描述文字的图片'),
          ImageComponent('https://mp.innenu.com/img/check/benbu.jpg', '报道图片1'),
          TextComponent(text: '包含大量描述文字的图片'),
          ImageComponent(
            'https://mp.innenu.com/img/check/benbu.jpg',
            '报道图片1报道图片1报道图片1报道图片1报道图片1报道图片1报道图片1报道图片1报道图片1',
          ),
          TextComponent(text: '包含多行描述文字的图片'),
          ImageComponent(
            'https://mp.innenu.com/img/arrival/pickup.jpg',
            '报道图片1\n' '报道图片1',
          ),
          TextComponent(text: '加载失败图片'),
          ImageComponent('https://mp.innenu.com/img/check/not-exist1.jpg'),
        ],
      ));
}
