import 'package:ffi/ffi.dart';
import 'dart:ffi'; // For FFI
import 'dart:io' show Platform;

final DynamicLibrary nativeAddLib = Platform.isAndroid
    ? DynamicLibrary.open("libwaveform.so")
    : DynamicLibrary.process();

class AudiowaveformFlutter {
  static final Pointer<Utf8> Function(Pointer<Utf8> fileName) _nativeWaveForm =
      nativeAddLib
          .lookup<NativeFunction<Pointer<Utf8> Function(Pointer<Utf8>)>>(
              "extractWaveData")
          .asFunction();

  static String audioWaveForm(String inputPath) {
    Pointer<Utf8> test = _nativeWaveForm(inputPath.toNativeUtf8());
    return test.toDartString();
  }

}
