import 'dart:async';
import './auth_service.dart';
import 'package:flutter/material.dart';
import 'package:app_links/app_links.dart';

class AuthScreen extends StatefulWidget {
  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  AuthService authService = AuthService();
  late AppLinks _appLinks; // AppLinks is singleton
  StreamSubscription<Uri?>? _linkSubscription; // Declare a StreamSubscription

  @override
    void initState() {
      super.initState();
      _appLinks = AppLinks();
  }

  @override
  void dispose() {
    // Cancel the subscription when the widget is disposed
    _linkSubscription?.cancel();
    super.dispose();
  }

  void _startLinkStream() {
    // Start listening to the link stream
    _linkSubscription = _appLinks.uriLinkStream.listen((Uri link) async {
        String? code = link.queryParameters['code'];
        if (code != null) {
          print("[AUTH CODE]: " + code);
          await authService.exchangeCodeForToken(code);
          _stopLinkStream();
      }
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