import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewScreen extends StatefulWidget {
  String url;

  WebViewScreen({required this.url});

  @override
  State<WebViewScreen> createState() => _WebViewScreen();
}

class _WebViewScreen extends State<WebViewScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      );
  }
}
