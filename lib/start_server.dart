
import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart' as shelf_io;
import 'package:shelf_router/shelf_router.dart';

void startServer(Function(String) onCodeReceived) async {
  final router = Router();

  // Handle the callback from Keycloak and get the authorization code
  router.get('/callback', (Request request) {
    final code = request.url.queryParameters['code'];
    if (code != null) {
      onCodeReceived(code);  // Pass the code back to the app
      return Response.ok('Authorization successful! You can close this page.');
    } else {
      return Response.notFound('Authorization code not found.');
    }
  });

  var server = await shelf_io.serve(router, 'localhost', 4200);
  print('Serving at http://${server.address.host}:${server.port}');
}
