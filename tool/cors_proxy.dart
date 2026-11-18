import 'dart:async';
import 'dart:convert';
import 'dart:io';

final _loginUrl = Uri.https('mediadwi.com', '/api/latihan/login');

const _imageHosts = {'r2.thesportsdb.com', 'www.thesportsdb.com'};

const _corsAllowHeaders = 'Content-Type';
const _corsAllowMethods = 'GET, POST, OPTIONS';

Future<HttpServer> startLoginProxy({int port = 8787, String? allowedOrigin}) async {
  final server = await HttpServer.bind(InternetAddress.loopbackIPv4, port);
  server.listen((request) => unawaited(_handle(request, allowedOrigin)));
  return server;
}

Future<void> main() async {
  final server = await startLoginProxy();
  stdout.writeln('Proxy aktif di http://127.0.0.1:${server.port}');
}

Future<void> _handle(HttpRequest request, String? allowedOrigin) async {
  final out = request.response;
  final origin = request.headers.value('origin');
  final uri = origin == null ? null : Uri.tryParse(origin);
  final localOrigin = uri != null && uri.scheme == 'http' &&
      (uri.host == 'localhost' || uri.host == '127.0.0.1') &&
      uri.userInfo.isEmpty && uri.path.isEmpty && uri.query.isEmpty &&
      uri.fragment.isEmpty;
  if (origin != null && (!localOrigin ||
      (allowedOrigin != null && origin != allowedOrigin))) {
    out.statusCode = HttpStatus.forbidden;
    await out.close();
    return;
  }
  if (origin != null) {
    out.headers.set('Access-Control-Allow-Origin', origin);
    out.headers.set('Vary', 'Origin');
  }
  out.headers.set('Cache-Control', 'no-store');
  if (request.method == 'OPTIONS') {
    out.headers.set('Access-Control-Allow-Methods', _corsAllowMethods);
    out.headers.set('Access-Control-Allow-Headers', _corsAllowHeaders);
    out.statusCode = HttpStatus.noContent;
    await out.close();
    return;
  }

  switch (request.uri.path) {
    case '/api/latihan/login':
      await _login(request, out);
    case '/img':
      await _image(request, out);
    default:
      out.statusCode = HttpStatus.notFound;
      await out.close();
  }
}

Future<void> _image(HttpRequest request, HttpResponse out) async {
  if (request.method != 'GET') {
    out.statusCode = HttpStatus.methodNotAllowed;
    await out.close();
    return;
  }
  final raw = request.uri.queryParameters['u'] ?? '';
  final target = Uri.tryParse(Uri.decodeFull(raw));
  final allowed = target != null &&
      target.scheme == 'https' &&
      target.userInfo.isEmpty &&
      _imageHosts.contains(target.host) &&
      target.hasAuthority &&
      raw.length <= 512;
  if (!allowed) {
    out.statusCode = HttpStatus.badRequest;
    await out.close();
    return;
  }
  final client = HttpClient()..connectionTimeout = const Duration(seconds: 15);
  try {
    final forward = await client.getUrl(target);
    final response = await forward.close().timeout(const Duration(seconds: 15));
    if (response.statusCode != HttpStatus.ok) {
      out.statusCode = HttpStatus.badGateway;
      await out.close();
      return;
    }
    out.headers.contentType =
        response.headers.contentType ?? ContentType('image', 'png');
    await response.pipe(out);
  } catch (_) {
    out.statusCode = HttpStatus.badGateway;
    await out.close();
  } finally {
    client.close(force: true);
  }
}

Future<void> _login(HttpRequest request, HttpResponse out) async {
  out.headers.set('Access-Control-Allow-Methods', _corsAllowMethods);
  out.headers.set('Access-Control-Allow-Headers', _corsAllowHeaders);
  if (request.uri.hasQuery) {
    out.statusCode = HttpStatus.notFound;
    await out.close();
    return;
  }
  if (request.method != 'POST') {
    out.statusCode = HttpStatus.methodNotAllowed;
    await out.close();
    return;
  }
  if (request.headers.contentType?.mimeType !=
      'application/x-www-form-urlencoded') {
    out.statusCode = HttpStatus.unsupportedMediaType;
    await out.close();
    return;
  }
  final client = HttpClient()..connectionTimeout = const Duration(seconds: 15);
  try {
    final body = <int>[];
    await for (final chunk in request.timeout(const Duration(seconds: 15))) {
      if (body.length + chunk.length > 4096) {
        out.statusCode = HttpStatus.requestEntityTooLarge;
        await out.close();
        return;
      }
      body.addAll(chunk);
    }
    final forward = await client.postUrl(_loginUrl);
    forward.followRedirects = false;
    forward.headers.contentType =
        ContentType('application', 'x-www-form-urlencoded', charset: 'utf-8');
    forward.add(body);
    final response = await forward.close().timeout(const Duration(seconds: 15));
    final payload = await utf8.decoder
        .bind(response)
        .join()
        .timeout(const Duration(seconds: 15));
    out.statusCode = response.statusCode;
    out.headers.contentType = ContentType.json;
    out.write(payload);
  } catch (_) {
    out.statusCode = HttpStatus.badGateway;
    out.headers.contentType = ContentType.json;
    out.write(jsonEncode(
        {'status': false, 'message': 'Server login tidak dapat dihubungi.'}));
  } finally {
    client.close(force: true);
    await out.close();
  }
}
