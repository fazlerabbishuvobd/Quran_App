import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
class SuraDetailsPage extends StatefulWidget {
  const SuraDetailsPage({super.key});

  @override
  State<SuraDetailsPage> createState() => _SuraDetailsPageState();
}

class _SuraDetailsPageState extends State<SuraDetailsPage> {
  AudioPlayer audioPlayer = AudioPlayer();
  bool isPlaying = false;
  double duration = 0.0;
  double position = 0.0;
  bool isLoading = false;

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
    audioPlayer.stop();
    audioPlayer.release();
    audioPlayer.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Al Fatiha"),
        backgroundColor: Colors.amber,
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                height: 150,
                width: double.infinity,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.amber
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("AL - FATIHA",style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold)),
                    const Text("The Opening"),
                    const Text("Verse - 07"),
                    //const Text("الفاتحة"),
                    Text("$duration"),
                    Text("$position"),
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),

              ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: 10,
                  itemBuilder: (context, index) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Stack(
                              alignment: Alignment.center,
                              children: [
                                Image.asset('assets/icon/star.png',scale: 3,),
                                Text('$index',style: const TextStyle(fontSize: 12,fontWeight: FontWeight.bold))
                              ],
                            ),
                            const Row(
                              children: [
                                Icon(Icons.play_circle),
                                SizedBox(width: 10),
                                Icon(Icons.share),
                              ],
                            )
                          ],
                        ),
                        const SizedBox(height: 20),

                        const Text('ٰهِ الرَّحْمٰنِ الرَّحِيْمِٰهِ الرَّحْمٰنِ الرَّحِيْمِٰهِ الرَّحْمٰنِ الرَّحِيْمِٰهِلرَّحِيْمِٰهِ الرَّحْمٰنِ الرَّحِيْمِٰهِ الرَّحْمٰنِ الرَّحِيْمِٰهِ',
                          style: TextStyle(fontSize: 24,fontWeight: FontWeight.bold),
                          textAlign: TextAlign.right,
                        ),
                        const SizedBox(height: 20),

                        const Text('bismillāhir-raḥmānir-raḥīm(i). bismillāhir-raḥmānir-raḥīm(i).',
                            style: TextStyle(fontSize: 16),
                        ),
                        const SizedBox(height: 20),
                      ],
                    );
                  },
              ),
              const SizedBox(height: 150,),
            ],
          ),
        ),
      ),


      bottomSheet: Container(
        margin: const EdgeInsets.all(10),
        padding: const EdgeInsets.all(10),
        height: 120,
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          color: Colors.amber,
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('$position'),
                SizedBox(
                  width: 280,
                  child: Slider(
                    value: position,
                    min: 0.0,
                    max: duration,
                    onChanged: (double value) {
                      _seekTo(value);
                    },
                  ),
                ),
                Text('$duration'),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text("AL FATIHA",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16)),
                Row(
                  children: [
                    const Icon(Icons.skip_previous,size: 35),
                    IconButton(
                      icon: Icon(isPlaying? Icons.pause : Icons.play_circle, size: 35),
                      onPressed: () {

                        _playPause();
                      },
                    ),
                    const Icon(Icons.skip_next,size: 35),
                  ],
                ),
                const Text("AL Bakarah",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
