import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:http/http.dart' as http;

import 'package:flutter/services.dart';
import 'package:audiowaveformFlutter/audiowaveformFlutter.dart';
import 'package:path_provider/path_provider.dart';

void main() {
    runApp(MyApp());
}

class MyApp extends StatefulWidget {
    @override
    _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
    String _platformVersion = 'Unknown';

    @override
    void initState() {
        initPlatformState();
        super.initState();
    }

    // Platform messages are asynchronous, so we initialize in an async method.
    Future<void> initPlatformState() async {
        // If the widget was removed from the tree while the asynchronous platform
        // message was in flight, we want to discard the reply rather than calling
        // setState to update our non-existent appearance.
        if (!mounted) return;

        String r = (AudiowaveformFlutter.audioWaveForm("test"));

        setState(() {
            _platformVersion = r;
        });
    }

    Future<String> get _localPath async {
        return (await getApplicationDocumentsDirectory()).path;
    }

    Future<void> bp() async {
        print("ButtonPress");
        File f = File(await _localPath + "/test.mp3");
        print(f.path);
        if (await f.exists()) {
            await f.delete();
        }
        await f.create();

        http.Response response = await http.get(
            "https://p.scdn.co/mp3-preview/546cc859633ce69e1b27f9cf22e64f4d9f80b2f4");
        await f.writeAsBytes(response.bodyBytes);

        print(response.statusCode);
        try {
            _platformVersion =
                AudiowaveformFlutter.audioWaveForm(f.path);
        } catch (e, stacktrace){
          print(StackTrace.current);
        }

        txt = "done";
        setState(() {});
    }

    String txt = "Plugi";

    @override
    Widget build(BuildContext context) {
        return MaterialApp(
            home: Scaffold(
                appBar: AppBar(
                    title: Text(
                        txt,
                    ),
                ),
                body: Center(
                    child: Column(
                        children: <Widget>[
                            Text(
                                _platformVersion,
                                key: Key("w"),
                            ),
                            FlatButton(
                                child: Text("aaa"),
                                key: Key("f"),
                                onPressed: bp,
                            )
                        ],
                    ),
                ),
            ),
        );
    }
}
