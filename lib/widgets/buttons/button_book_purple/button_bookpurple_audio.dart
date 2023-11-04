import 'package:books_app/utils/screen_size.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';

///[ButtonBookPurpleAudio] has the purpose to let the user have an audio reading
///of the description of the book this has been retrieve by the use of the package
///[flutter_tts] where is has been set up a basic controll for its operation and will
///be shown to the user with an showdialog.
///
class ButtonBookPurpleAudio extends StatefulWidget {
  final String bookDescripton;
  const ButtonBookPurpleAudio({super.key, required this.bookDescripton});

  @override
  State<ButtonBookPurpleAudio> createState() => _ButtonBookPurpleAudioState();
}

enum TtsSate { playing, stopped, paused }

class _ButtonBookPurpleAudioState extends State<ButtonBookPurpleAudio> {
  FlutterTts flutterTts = FlutterTts();
  TtsSate ttsState = TtsSate.stopped;

  get isPlaying => ttsState == TtsSate.playing;
  get isStopped => ttsState == TtsSate.stopped;

  @override
  void initState() {
    super.initState();
    speakText(widget.bookDescripton);
  }

  Future<void> speakText(bookDescripton) async {
    await flutterTts.setSpeechRate(0.5);
    await flutterTts.setVolume(1.0); // 1.0 Max volumen
    await flutterTts.setPitch(1.0);

    if (await flutterTts.isLanguageAvailable("es-MX")) {
      await flutterTts.setLanguage("es-MX");
    } else if (await flutterTts.isLanguageAvailable("en-US")) {
      await flutterTts.setLanguage("en-US");
    }
    if (widget.bookDescripton.isNotEmpty) {
      await flutterTts.speak(bookDescripton);
    } else {
      bookDescripton =
          'The books does not have any audio preview, content is available only after buying';
      await flutterTts.speak(bookDescripton);
    }
  }

  Future stopspeakText(bookDescripton) async {
    var result = await flutterTts.stop();
    if (result == 1) setState(() => ttsState = TtsSate.stopped);
  }

  Future pausespeakText(bookDescripton) async {
    var result = await flutterTts.pause();
    if (result == 1) setState(() => ttsState = TtsSate.paused);
  }

  @override
  void dispose() {
    super.dispose();
    flutterTts.stop();
  }

  @override
  Widget build(BuildContext context) {
    ScreenSize myScreen = ScreenSize(context);

    return SizedBox(
      width: myScreen.screenWidth * 0.5,
      height: myScreen.screenHeight * 0.15,
      child: Align(
        alignment: Alignment.bottomRight,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _buildButtonColumn(Colors.green, Colors.greenAccent,
                Icons.play_arrow, 'PLAY', speakText),
            _buildButtonColumn(Colors.red, Colors.redAccent, Icons.stop, 'STOP',
                stopspeakText),
            _buildButtonColumn(Colors.blue, Colors.blueAccent, Icons.pause,
                'PAUSE', pausespeakText),
          ],
        ),
      ),
    );
  }

  Widget _buildButtonColumn(Color color, Color splashColor, IconData icon,
      String label, Function func) {
    return Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          IconButton(
              icon: Icon(icon),
              color: color,
              splashColor: splashColor,
              onPressed: () => func(widget.bookDescripton)),
          Container(
              margin: const EdgeInsets.only(top: 8.0),
              child: Text(label,
                  style: TextStyle(
                      fontSize: 12.0,
                      fontWeight: FontWeight.w400,
                      color: color)))
        ]);
  }
}
