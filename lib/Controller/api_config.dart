import 'package:flutter/foundation.dart' show kIsWeb;

class ApiConfig {
  static const _override = String.fromEnvironment('API_BASE');

  static String get base =>
      _override.isEmpty ? 'https://mediadwi.com' : _override;

  static Uri get login => Uri.parse('$base/api/latihan/login');

  static String badge(String url) => kIsWeb
      ? '$base/img?u=${Uri.encodeComponent(url)}'
      : url;
}
