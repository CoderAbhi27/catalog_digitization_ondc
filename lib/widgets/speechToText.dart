// import 'dart:html';

import 'package:flutter/material.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;

class SpeechToText extends StatefulWidget {
  const SpeechToText({super.key});

  @override
  State<SpeechToText> createState() => _SpeechToTextState();
}

class _SpeechToTextState extends State<SpeechToText> {
  final stt.SpeechToText _speechToText = stt.SpeechToText();
  bool _speechEnabled = true;
  String _lastWords = '';
  @override
  void initState() {
    super.initState();
    _initSpeech();
  }
  void _initSpeech() async {
    //_speechToText.toString();
    _speechEnabled = await _speechToText.initialize();
    setState(() {});
  }

  /// Each time to start a speech recognition session
  void _startListening() async {

    await _speechToText.listen(onResult: _onSpeechResult);
    setState(() {});
  }

  /// Manually stop the active speech recognition session
  /// Note that there are also timeouts that each platform enforces
  /// and the SpeechToText plugin supports setting timeouts on the
  /// listen method.
  void _stopListening() async {
    await _speechToText.stop();
    setState(() {});
  }

  /// This is the callback that the SpeechToText plugin calls when
  /// the platform returns recognized words.
  void _onSpeechResult(SpeechRecognitionResult result) {
    setState(() {
      _lastWords = result.recognizedWords;
    });
  }

  @override
  Widget build(BuildContext context) {
    // return Text('data');
    return AlertDialog(
        title: Text('Speak...'),
        content:  Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Expanded(
                flex: 1,
                child: Container(
                  padding: EdgeInsets.all(4),
                  child: Text(
                    'Tap the microphone for listening...',
                    style: TextStyle(fontSize: 20.0),
                  ),
                ),
              ),
              Expanded(
                flex: 2,
                child: Container(
                  padding: EdgeInsets.all(10),
                  child: Text(
                    // If listening is active show the recognized words
                    _speechToText.isListening
                        ? '$_lastWords'
                    // If listening isn't active but could be tell the user
                    // how to start it, otherwise indicate that speech
                    // recognition is not yet ready or not supported on
                    // the target device
                        : _speechEnabled
                        ? '$_lastWords'
                        : 'Speech not available',
                  ),
                ),
              ),
            ],
          ),
        ),
        actions: <Widget>[
          // TextButton(
          //   onPressed: () => Navigator.pop(context, 'Cancel'),
          //   child: const Text('Cancel'),
          // ),
            IconButton(
      onPressed:
      // If not yet listening for speech start, otherwise stop
      _speechToText.isNotListening ? _startListening : _stopListening,
        tooltip: 'Listen',
        icon: Icon(_speechToText.isNotListening ? Icons.mic_off : Icons.mic),
      ),

          TextButton(
            onPressed: () => Navigator.pop(context,{'text':'$_lastWords'}),
            child: const Text('OK'),
          ),
        ],

    );
  }
}
