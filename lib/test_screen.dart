
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';

class TextToSpeechExample extends StatefulWidget {
  @override
  _TextToSpeechExampleState createState() => _TextToSpeechExampleState();
}

class _TextToSpeechExampleState extends State<TextToSpeechExample> {
  FlutterTts flutterTts = FlutterTts();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Text-to-Speech Example'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            speakText("Hello, RESHMA");
          },
          child: Text('Speak Text'),
        ),
      ),
    );
  }

  Future<void> speakText(String text) async {
    await flutterTts.setLanguage("en-US");
    await flutterTts.setPitch(1.0);
    await flutterTts.speak(text);
  }
}

void main() {
  runApp(MaterialApp(
    home: TextToSpeechExample(),
  ));
}