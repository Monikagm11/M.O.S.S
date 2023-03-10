import 'package:audioplayers/audioplayers.dart';
import 'package:avatar_glow/avatar_glow.dart';
import "package:flutter/material.dart";
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:speech_to_text/speech_to_text.dart';

class VoiceCommand extends StatefulWidget {
  const VoiceCommand({super.key});

  @override
  State<VoiceCommand> createState() => _VoiceCommandState();
}

class _VoiceCommandState extends State<VoiceCommand> {
  SpeechToText speechToText = SpeechToText();
  bool _isListening = false;
  String _text =
      'Press the button and start speaking, \n Commands are :  \n Help for false alarm \n Stop for Stopping alarm \n Police for Calling Police , Ambulance for Calling Ambulance ';
  final audioPlayer = AudioPlayer();

  void _audioPath() async {
    await audioPlayer.setSource(AssetSource('siren.mp3'));
  }

  @override
  void initState() {
    super.initState();
    _audioPath();
  }

  void _playAudio() async {
    await audioPlayer.resume();
  }

  void _stopAudio() async {
    await audioPlayer.pause();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.fromLTRB(30.0, 30.0, 30.0, 150.0),
        child: Text(
          _text,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: AvatarGlow(
        animate: _isListening,
        glowColor: Theme.of(context).primaryColor,
        endRadius: 75.0,
        duration: const Duration(milliseconds: 2000),
        repeatPauseDuration: const Duration(milliseconds: 100),
        repeat: true,
        showTwoGlows: true,
        child: CircleAvatar(
          backgroundColor: Theme.of(context).colorScheme.background,
          radius: 40,
          child: GestureDetector(
            onTapDown: (details) async {
              if (!_isListening) {
                bool available = await speechToText.initialize();
                if (available) {
                  setState(() {
                    _isListening = true;
                  });
                  speechToText.listen(
                    onResult: (result) {
                      setState(() {
                        _text = result.recognizedWords;
                      });
                      if (_text.toLowerCase() == 'help') {
                        _playAudio();
                      }
                      if (_text.toLowerCase() == 'stop') {
                        _stopAudio();
                      }
                      if (_text.toLowerCase() == 'police') {
                        FlutterPhoneDirectCaller.callNumber('100');
                      }
                      if (_text.toLowerCase() == 'ambulance') {
                        FlutterPhoneDirectCaller.callNumber('102');
                      }
                    },
                  );
                }
              }
            },
            onTapUp: ((details) {
              setState(() {
                _isListening = false;
                speechToText.stop();
              });
            }),
            child: Icon(
              _isListening ? Icons.mic : Icons.mic_none,
              color: Theme.of(context).colorScheme.primary,
              size: 40,
            ),
          ),
        ),
      ),
    );
  }
}
