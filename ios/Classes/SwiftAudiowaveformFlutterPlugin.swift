import Flutter
import UIKit

public class SwiftAudiowaveformFlutterPlugin: NSObject, FlutterPlugin {
  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "audiowaveformFlutter", binaryMessenger: registrar.messenger())
    let instance = SwiftAudiowaveformFlutterPlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    result("iOS " + UIDevice.current.systemVersion)
  }

  public func dummy(){
    extractWaveData("")
  }
}
