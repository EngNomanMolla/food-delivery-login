import 'package:http/http.dart' as http;
import 'dart:convert';

Future<void> exchangeCodeForTokens(String code) async {
  final tokenApiUrl = 'https://fe.159.223.68.172.sslip.io/oauth/callback';
  final redirectUri = 'http://localhost:4200/callback';

  final response = await http.get(Uri.parse('$tokenApiUrl?code=$code&redirect_uri=$redirectUri'));

  if (response.statusCode == 200) {
    final data = json.decode(response.body);
    final accessToken = data['access_token'];
    final refreshToken = data['refresh_token'];

    print('Access Token: $accessToken');
    print('Refresh Token: $refreshToken');

    // Now, you can store or use the tokens as needed
  } else {
    throw Exception('Failed to exchange code for tokens');
  }
}
