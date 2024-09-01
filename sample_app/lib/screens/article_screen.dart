import 'package:flutter/material.dart';
import 'package:sample_app/models/article.dart';
import 'package:webview_flutter/webview_flutter.dart';

class ArticleScreen extends StatefulWidget {
  const ArticleScreen({super.key, required this.article});

  final Article article;

  @override
  State<ArticleScreen> createState() => _ArticleScreenState();
}

class _ArticleScreenState extends State<ArticleScreen> {
  late WebViewController controller = WebViewController()
    ..loadRequest(Uri.parse(widget.article.url));

  // NOTE: カスケード演算子 (..) を使わない場合、次のようになる
  //
  // late WebViewController controller;
  // @override
  // void initState() {
  //   super.initState();
  //   controller = WebViewController();
  //   controller.loadRequest(Uri.parse(widget.article.url));
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Article Page',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: WebViewWidget(controller: controller),
    );
  }
}
