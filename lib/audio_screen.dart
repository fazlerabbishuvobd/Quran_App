import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';

class AudioPlayerWidget extends StatefulWidget {
  const AudioPlayerWidget({Key? key}) : super(key: key);

  @override
  _AudioPlayerWidgetState createState() => _AudioPlayerWidgetState();
}

class _AudioPlayerWidgetState extends State<AudioPlayerWidget> {
  AudioPlayer audioPlayer = AudioPlayer();
  bool isPlaying = false;
  double duration = 0.0;
  double position = 0.0;

  @override
  void initState() {
    super.initState();

    audioPlayer.onPositionChanged.listen((Duration p) {
      setState(() {
        position = p.inSeconds.toDouble();
      });
    });

    audioPlayer.onDurationChanged.listen((Duration d) {
      setState(() {
        duration = d.inSeconds.toDouble();
      });
    });
  }

  Future<void> _playPause() async {
    if (isPlaying) {
      await audioPlayer.pause();
    } else {
      await audioPlayer.play(UrlSource('https://equran.nos.wjv-1.neo.id/audio-full/Abdullah-Al-Juhany/001.mp3'));
    }
    setState(() {
      isPlaying = !isPlaying;
    });
  }

  void _seekTo(double seconds) {
    Duration newDuration = Duration(seconds: seconds.toInt());
    audioPlayer.seek(newDuration);
  }

  @override
  void dispose() {
    audioPlayer.release();
    audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        IconButton(
          icon: Icon(
            isPlaying ? Icons.pause : Icons.play_arrow,
          ),
          onPressed: () {
            _playPause();
          },
        ),
        Slider(
          value: position,
          min: 0.0,
          max: duration,
          onChanged: (double value) {
            _seekTo(value);
          },
        ),
      ],
    );
  }
}
