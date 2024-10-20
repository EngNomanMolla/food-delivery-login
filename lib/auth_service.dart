import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';

class AuthService {
  final redirectUri = 'http://localhost:4200/callback';
  final loginApiUrl = 'https://fe.159.223.68.172.sslip.io/oauth/login';
  final callbackUri = 'https://fe.159.223.68.172.sslip.io/oauth/callback';

  Future<String> getLoginUrl() async {

    // Make the API request
    final response = await http.get(Uri.parse('$loginApiUrl?redirect_uri=$redirectUri'));

    if (response.statusCode == 200) {
      return response.body.replaceAll('"', ''); // Login URL
    } else {
      throw Exception('Failed to get login URL');
    }
  }

  Future<void> authenticate() async {
    
    String _authUrl = await getLoginUrl();
    Uri authUrl = Uri.parse(_authUrl);

    // Launch the URL
    await launchUrl(authUrl);
  }

  Future<void> exchangeCodeForToken(String code) async {
    
    Uri url = Uri.parse('$callbackUri?code=$code&redirect_uri=$redirectUri');

    final response = await http.get(url);

    if (response.statusCode == 200) {
      print('Token response: ${response.body}');
    } else {
      print('Error: ${response.body}');
    }
  }
}
