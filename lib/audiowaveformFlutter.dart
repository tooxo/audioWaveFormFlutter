import 'dart:async';

import 'package:ffi/ffi.dart';
import 'package:flutter/services.dart';
import 'dart:ffi'; // For FFI
import 'dart:io' show Platform;

final DynamicLibrary nativeAddLib = Platform.isAndroid
    ? DynamicLibrary.open("libnative_add.so")
    : DynamicLibrary.process();

class AudiowaveformFlutter {
  static const MethodChannel _channel =
      const MethodChannel('audiowaveformFlutter');

  static Future<String> get platformVersion async {
    final String version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }

  static String audioWaveForm(String inputPath) {
    final Pointer<Utf8> Function(Pointer<Utf8> fileName) nativeWaveForm =
        nativeAddLib
            .lookup<NativeFunction<Pointer<Utf8> Function(Pointer<Utf8>)>>(
                "extract_wave_data")
            .asFunction();

    dynamic test =nativeWaveForm(Utf8.toUtf8(inputPath));
    print(test);
    print(Utf8.strlen(test));

    print(Utf8.fromUtf8(test));

    return Utf8.fromUtf8(test);
  }
}
