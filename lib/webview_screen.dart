import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class SignInWebView extends StatelessWidget {
  final String initialUrl;

  SignInWebView({required this.initialUrl});

  @override
  Widget build(BuildContext context) {
    print(initialUrl);
    final WebViewController controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..loadRequest(Uri.parse(initialUrl));

    return Scaffold(
      appBar: AppBar(
        title: Text('Sign In'),
      ),
      body: WebViewWidget(controller: controller),
    );
  }
}
