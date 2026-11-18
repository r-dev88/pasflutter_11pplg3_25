import 'dart:io';

import 'cors_proxy.dart';

Future<void> main(List<String> args) async {
  final root = File.fromUri(Platform.script).parent.parent;
  Directory.current = root;
  final device = args.isEmpty ? 'chrome' : args.single;
  if (device != 'chrome' && device != 'web-server') {
    stderr.writeln('Gunakan: dart run tool/run_web.dart [chrome|web-server]');
    exitCode = 64;
    return;
  }

  final build = Directory('build');
  if (Platform.isWindows && build.existsSync()) {
    for (final path in [build.absolute.path, '${build.absolute.path}\\*']) {
      final result = await Process.run('attrib.exe', ['-R', path, '/S', '/D']);
      if (result.exitCode != 0) {
        stderr.write(result.stderr);
        stderr.write(result.stdout);
        exitCode = result.exitCode;
        return;
      }
    }
  }

  final socket = await ServerSocket.bind(InternetAddress.loopbackIPv4, 0);
  final webPort = socket.port;
  await socket.close();
  final origin = 'http://127.0.0.1:$webPort';
  final proxy = await startLoginProxy(port: 0, allowedOrigin: origin);
  stdout.writeln('Web app: $origin');
  stdout.writeln('Login proxy: http://127.0.0.1:${proxy.port}');

  try {
    final bin = File(Platform.resolvedExecutable).parent.parent.parent.parent;
    final sdkFlutter = File('${bin.path}/${Platform.isWindows ? 'flutter.bat' : 'flutter'}');
    final flutter = sdkFlutter.existsSync()
        ? sdkFlutter.path
        : (Platform.isWindows ? 'flutter.bat' : 'flutter');
    final process = await Process.start(flutter, [
      'run', '-d', device,
      '--web-hostname=127.0.0.1',
      '--web-port=$webPort',
      '--dart-define=API_BASE=http://127.0.0.1:${proxy.port}',
      '--no-web-resources-cdn',
    ], runInShell: Platform.isWindows, mode: ProcessStartMode.inheritStdio);
    exitCode = await process.exitCode;
  } finally {
    await proxy.close(force: true);
  }
}
