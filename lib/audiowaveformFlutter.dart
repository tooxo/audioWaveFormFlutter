import 'package:ffi/ffi.dart';
import 'dart:ffi'; // For FFI
import 'dart:io' show Platform;

final DynamicLibrary nativeAddLib = Platform.isAndroid
    ? DynamicLibrary.open("waveform.so")
    : DynamicLibrary.process();

class AudiowaveformFlutter {
  static final Pointer<Utf8> Function(Pointer<Utf8> fileName) nativeWaveForm =
      nativeAddLib
          .lookup<NativeFunction<Pointer<Utf8> Function(Pointer<Utf8>)>>(
              "extractWaveData")
          .asFunction();

  static String audioWaveForm(String inputPath) {
    Pointer<Utf8> test = nativeWaveForm(Utf8.toUtf8(inputPath));
    return Utf8.fromUtf8(test);
  }

}
