import 'dart:async';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

void main() => runApp(MaterialApp(
      home: WebViewExample(),
      debugShowCheckedModeBanner: false,
    ));

class WebViewExample extends StatefulWidget {
  @override
  _WebViewExampleState createState() => _WebViewExampleState();
}

class _WebViewExampleState extends State<WebViewExample> {
  WebViewController _controller;

  final Completer<WebViewController> _controllerCompleter =
      Completer<WebViewController>();

  Future<bool> _onWillPop(BuildContext context) async {
    if (await _controller.canGoBack()) {
      _controller.goBack();
      return Future.value(false);
    } else {
      return Future.value(true);
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => _onWillPop(context),
      child: SafeArea(
        child: Scaffold(
          body: WebView(
              initialUrl: 'https://flutter.dev',
              onWebViewCreated: (WebViewController webViewController) {
                _controllerCompleter.future
                    .then((value) => _controller = value);
                _controllerCompleter.complete(webViewController);
              },
              javascriptMode: JavascriptMode.unrestricted),
        ),
      ),
    );
  }
}
