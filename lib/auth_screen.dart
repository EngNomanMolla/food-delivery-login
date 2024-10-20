import 'dart:async';
import './auth_service.dart';
import 'package:flutter/material.dart';
import 'package:uni_links/uni_links.dart';
class AuthScreen extends StatefulWidget {
  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  AuthService authService = AuthService();
  StreamSubscription<String?>? _linkSubscription; // Declare a StreamSubscription

  @override
  void dispose() {
    // Cancel the subscription when the widget is disposed
    _linkSubscription?.cancel();
    super.dispose();
  }

  void _startLinkStream() {
    // Start listening to the link stream
    _linkSubscription = linkStream.listen((String? link) async {
      if (link != null) {
        Uri uri = Uri.parse(link);
        String? code = uri.queryParameters['code'];
        if (code != null) {
          print("[AUTH CODE]: " + code);
          await authService.exchangeCodeForToken(code);
          _stopLinkStream();
        }
      }
    }, onError: (err) {
      // Handle error
      print('Error listening to link stream: $err');
    });
  }

  void _stopLinkStream() {
    // Cancel the subscription to stop listening
    _linkSubscription?.cancel();
    _linkSubscription = null; // Clear the reference
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text('Keycloak Auth')),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () {
                  authService.authenticate(); // Start the authentication process
                  _startLinkStream(); // Start listening to the link stream
                },
                child: Text('Login with OAuth'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}