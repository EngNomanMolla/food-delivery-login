import 'package:flutter/material.dart';
import 'package:test_project/exchange_code_for_tokens.dart';
import 'package:test_project/get_login_url.dart';
import 'package:test_project/start_server.dart';
import 'package:test_project/webview_screen.dart';
class AuthScreen extends StatefulWidget {
  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  String? loginUrl;

  @override
  void initState() {
    super.initState();
    startServer((code)async {
      print('getting code');
      // Received the authorization code, now exchange it for tokens
     await exchangeCodeForTokens(code);
    });
    initiateLogin();
  }

  void initiateLogin() async {
    try {
      final url = await getLoginUrl();
      setState(() {
        loginUrl = url;
      });
    } catch (e) {
      print('Error during login: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Keycloak Auth')),
      body: Center(
        child: loginUrl != null
            ? SignInWebView(initialUrl: loginUrl!)
            : CircularProgressIndicator(),
      ),
    );
  }
}