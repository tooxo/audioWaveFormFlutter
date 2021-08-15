import 'package:ffi/ffi.dart';
import 'dart:ffi'; // For FFI
import 'dart:io' show Platform;

final DynamicLibrary nativeAddLib = Platform.isAndroid
    ? DynamicLibrary.open("libwaveform.so")
    : DynamicLibrary.process();

class AudiowaveformFlutter {
  static final void Function(
          Pointer<Utf8> fileName, Pointer<Utf8> outputFileName)
      _nativeWaveForm = nativeAddLib
          .lookup<NativeFunction<Void Function(Pointer<Utf8>, Pointer<Utf8>)>>(
              "extractWaveData")
          .asFunction();

  static void audioWaveForm(AudioWaveformConfig config) {
    _nativeWaveForm(
        config.inputPath.toNativeUtf8(), config.outputPath.toNativeUtf8());
  }
}

class AudioWaveformConfig {
  String inputPath;
  String outputPath;

  AudioWaveformConfig(this.inputPath, this.outputPath);
}
