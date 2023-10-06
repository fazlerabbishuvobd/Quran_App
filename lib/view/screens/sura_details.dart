import 'dart:convert';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class SuraDetailsPage extends StatefulWidget {
  final int index;
  const SuraDetailsPage({super.key,required this.index});

  @override
  State<SuraDetailsPage> createState() => _SuraDetailsPageState();
}

class _SuraDetailsPageState extends State<SuraDetailsPage> {
  Map<String,dynamic> suraDetails ={};

  Future<Map<String,dynamic>> getSuraDetails(int index) async{
    try{
      setState(() {
        isLoading = true;
      });
      final response = await http.get(Uri.parse('https://equran.id/api/v2/surat/$index'));
      setState(() {
        isLoading = false;
      });
      if(response.statusCode == 200)
      {
        final jsonData = jsonDecode(response.body);
        setState(() {
          suraDetails = jsonData['data'];
        });
        return suraDetails;
      }
      else{
        throw Exception('Cannot Connected to Server');
      }
    }catch(e)
    {
      throw Exception(e.toString());
    }
  }

  AudioPlayer audioPlayer = AudioPlayer();
  bool isPlaying = false;
  double duration = 0.0;
  double position = 0.0;
  bool isLoading =false;

  @override
  void initState(){
    super.initState();
    getSuraDetails(widget.index);

    audioPlayer.onPlayerStateChanged.listen((state) {
      setState(() {
        isPlaying = state == PlayerState.playing;
      });
    });

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
      if(isPlaying)
        {

        }
      else{
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Wait 10-30 sec to Load Song'),
            duration: Duration(seconds: 3)));
      }
      await audioPlayer.play(UrlSource(suraDetails['audioFull']['02']));
    }
    setState(() {
      isPlaying = !isPlaying;
    });

  }
  
  void _seekTo(double seconds) {
    Duration newDuration = Duration(seconds: seconds.toInt());
    audioPlayer.seek(newDuration);
  }

  String timeFormat(int seconds) {
    return '${Duration(seconds: seconds)}'.split('.')[0].padLeft(8, '0');
  }

  @override
  void dispose() {
    audioPlayer.release();
    audioPlayer.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: isLoading? Center(child: CircularProgressIndicator(),):Text(suraDetails['namaLatin']),
        backgroundColor: Colors.amber,
      ),
      body: isLoading? const Center(child: CircularProgressIndicator(),):
      SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                height: 120,
                width: double.infinity,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.amber
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("${suraDetails['namaLatin']} (${suraDetails['nama']})",style: const TextStyle(fontSize: 30,fontWeight: FontWeight.bold)),
                    Text(suraDetails['tempatTurun']),
                    Text('Verse ${suraDetails['jumlahAyat']}'),
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),

              ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: suraDetails['jumlahAyat'],
                  itemBuilder: (context, index) {
                    final suraInfo = suraDetails['ayat'][index];
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
                                Text('${index+1}',style: const TextStyle(fontSize: 12,fontWeight: FontWeight.bold))
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

                        Align(
                          alignment: Alignment.centerRight,
                          child: Text(suraInfo['teksArab'],style: const TextStyle(fontSize: 24,fontWeight: FontWeight.bold),
                            textAlign: TextAlign.right,
                          ),
                        ),
                        const SizedBox(height: 20),

                        Text(suraInfo['teksLatin'], style: const TextStyle(fontSize: 16),),
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

      bottomSheet: isLoading? const Center(child: CircularProgressIndicator()):
      Container(
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
                Text(timeFormat(position.toInt())),
                SizedBox(
                  width: 240,
                  child: Slider(
                    value: position,
                    min: 0.0,
                    max: duration,
                    onChanged: (double value) {
                      _seekTo(value);
                    },
                  ),
                ),
                Text(timeFormat(duration.toInt())),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(suraDetails['namaLatin'],style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16)),
                Row(
                  children: [
                    const Icon(Icons.skip_previous,size: 35),
                    IconButton(
                      icon: Icon(isPlaying? Icons.pause : Icons.play_circle, size: 35),
                      onPressed: () {
                        _playPause();
                      },
                    ),
                    GestureDetector(
                        onTap: (){
                          audioPlayer.stop();
                          Navigator.of(context).push(MaterialPageRoute(builder: (context) => SuraDetailsPage(index: suraDetails['suratSelanjutnya']['nomor']),));
                        },
                        child: const Icon(Icons.skip_next,size: 35)),
                  ],
                ),
                Text(suraDetails['suratSelanjutnya']['namaLatin'],style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
