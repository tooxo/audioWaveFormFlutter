import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:audiowaveformFlutter/audiowaveformFlutter.dart';

void main() {
  const MethodChannel channel = MethodChannel('audiowaveformFlutter');

  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      return '42';
    });
  });

  tearDown(() {
    channel.setMockMethodCallHandler(null);
  });

  test('getPlatformVersion', () async {
    expect(await AudiowaveformFlutter.platformVersion, '42');
  });
}
