import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart' as shelf_io;
import 'package:shelf_router/shelf_router.dart';

var router = Router();

final html = ''' 
  <html>
    <head>
      <title>Dart Back-End</title>
    </head>
    <body>
      <h1>Dart Back-End com shelf</h1>
      <p>
        u.u
      </p>
    </body>
  </html>
''';

final json = '''
  {
    "message" : "Tudo Funfando"
  }
''';

void server() async {
  var handler = const Pipeline().addMiddleware(logRequests());

  router.get('/home', handler.addHandler(_echoRequest));

  router.get('/json', handler.addHandler(_echoRequestJson));

  router.get(
      '/hello', handler.addHandler((request) => Response.ok('hello-world')));

  var server = await shelf_io.serve(router, '0.0.0.0', 8080);

  print('Serving at http://${server.address.host}:${server.port}');
}

Response _echoRequest(Request request) => Response.ok(
      html,
      headers: {
        'content-type': 'text/html',
      },
    );

Response _echoRequestJson(Request request) => Response.ok(
      json,
      headers: {
        'content-type': 'text/json',
      },
    );
