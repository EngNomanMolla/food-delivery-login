import 'dart:convert';

import 'package:http/http.dart' as http;

Future<String> getLoginUrl() async {
  final redirectUri = 'http://localhost:4200/callback';
  final loginApiUrl = 'https://fe.159.223.68.172.sslip.io/oauth/login';

  // Make the API request
  final response = await http.get(Uri.parse('$loginApiUrl?redirect_uri=$redirectUri'));

  if (response.statusCode == 200) {
    return response.body.replaceAll('"', ''); // Login URL
  } else {
    throw Exception('Failed to get login URL');
  }
}
