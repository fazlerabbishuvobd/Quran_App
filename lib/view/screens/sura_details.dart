import 'dart:convert';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:quran_app/view/screens/home_page.dart';

import '../widgets/sura_details_screen_shimmer_effect.dart';

class SuraDetailsPage extends StatefulWidget {
  final int index,speaker;
  const SuraDetailsPage({super.key,required this.index,required this.speaker});

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
      await audioPlayer.play(UrlSource(
          widget.speaker==1?suraDetails['audioFull']['01']:widget.speaker==2?suraDetails['audioFull']['02']:
          widget.speaker==3?suraDetails['audioFull']['03']:suraDetails['audioFull']['01'])
      );
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
    final height = MediaQuery.sizeOf(context).height;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amber,
        actions: [
          IconButton(onPressed: (){
            Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => const HomePage()), (route) => false);},
              icon: const Icon(Icons.home)
          )
        ],
      ),
      body: isLoading? const SuraDetailsScreenShimmerEffect():
      SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                height: height*0.141,
                width: double.infinity,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.amber
                ),

                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("${suraDetails['namaLatin']} (${suraDetails['nama']})",style: myFontStyle.copyWith(fontSize: 30,fontWeight: FontWeight.bold)),
                    Text(suraDetails['tempatTurun'],style: myFontStyle.copyWith(fontSize: 16,fontWeight: FontWeight.bold)),
                    Text('Verse ${suraDetails['jumlahAyat']}',style: myFontStyle.copyWith(fontSize: 16,fontWeight: FontWeight.bold)),
                  ],
                ),
              ),
              SizedBox(height: height*0.03),

              ///Ayat
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
                            const Text('-----------------------'),
                            Stack(
                              alignment: Alignment.center,
                              children: [
                                Image.asset('assets/icon/star.png',scale: 2,),
                                Text('${index+1}',style: myFontStyle.copyWith(fontSize: 16,fontWeight: FontWeight.bold))
                              ],
                            ),
                            const Text('-----------------------'),
                          ],
                        ),
                        SizedBox(height: height*0.03),

                        Align(
                          alignment: Alignment.centerRight,
                          child: Text(suraInfo['teksArab'],style: const TextStyle(fontSize: 24,fontWeight: FontWeight.bold,color: Colors.orange),
                            textAlign: TextAlign.right,
                          ),
                        ),
                        SizedBox(height: height*0.03),


                        Text(suraInfo['teksLatin'], style: const TextStyle(fontSize: 16,fontWeight: FontWeight.bold),),
                        SizedBox(height: height*0.03),
                      ],
                    );
                  },
              ),

              SizedBox(height: height*0.1),
            ],
          ),
        ),
      ),
      extendBody: true,

      bottomNavigationBar: isLoading? const Text(''):
      Container(
        margin: const EdgeInsets.all(10),
        padding: const EdgeInsets.all(10),
        height: height*0.15,
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          color: Colors.amber
        ),
        child: Column(
          children: [
            /// Slider
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
                Text(suraDetails['namaLatin'],style: myFontStyle.copyWith(fontSize: 16,fontWeight: FontWeight.bold)),
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
                          Navigator.of(context).push(MaterialPageRoute(builder: (context) => SuraDetailsPage(speaker: widget.speaker,index: suraDetails['suratSelanjutnya']['nomor'])));
                        },
                        child: const Icon(Icons.skip_next,size: 35)
                    ),
                  ],
                ),

                Text(suraDetails['nomor'] == 114?'                  ':suraDetails['suratSelanjutnya']['namaLatin'],style: myFontStyle.copyWith(fontSize: 16,fontWeight: FontWeight.bold)),
              ],
            ),
          ],
        ),
      ),
    );
  }
  final myFontStyle = GoogleFonts.averiaLibre(fontSize: 14);
}
