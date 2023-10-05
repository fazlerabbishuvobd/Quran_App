import 'package:flutter/material.dart';
class SuraDetailsPage extends StatefulWidget {
  const SuraDetailsPage({super.key});

  @override
  State<SuraDetailsPage> createState() => _SuraDetailsPageState();
}

class _SuraDetailsPageState extends State<SuraDetailsPage> {
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
            children: <Widget>[
              Container(
                padding: const EdgeInsets.all(10),
                height: 150,
                width: double.infinity,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.amber
                ),
                child: const Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("AL - FATIHA",style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold)),
                    Text("The Opening"),
                    Text("Verse - 07"),
                    Text("الفاتحة"),
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
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("$index"),
                            const Row(
                              children: [
                                Icon(Icons.play_circle),
                                SizedBox(width: 10),
                                Icon(Icons.share),
                              ],
                            )
                          ],
                        ),
                        const SizedBox(height: 20,),
                        const Text('ٰهِ الرَّحْمٰنِ الرَّحِيْمِٰهِ الرَّحْمٰنِ الرَّحِيْمِٰهِ الرَّحْمٰنِ الرَّحِيْمِٰهِ الرَّحْمٰنِ الرَّحِيْمِٰهِ الرَّحْمٰنِ الرَّحِيْمِٰهِ الرَّحْمٰنِ الرَّحِيْمِٰهِ الرَّحْمٰنِ الرَّحِيْمِٰهِ الرَّحْمٰنِ الرَّحِيْمِٰهِ الرَّحْمٰنِ الرَّحِيْمِٰهِ الرَّحْمٰنِ الرَّحِيْمِٰهِ الرَّحْمٰنِ الرَّحِيْمِبِسْمِ اللّٰهِ الرَّحْمٰنِ الرَّحِيْمِ ٰهِ الرَّحْمٰنِ الرَّحِيْمِ',style: TextStyle(fontSize: 24,fontWeight: FontWeight.bold),),
                        const SizedBox(height: 20,),
                        const Text('bismillāhir-raḥmānir-raḥīm(i).',style: TextStyle(fontSize: 16)),
                        const SizedBox(height: 20,),
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
            Slider(
              value: 10,
              min: 0.0,
              max: 10,
              onChanged: (double value) {
              },
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("AL FATIHA",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16)),
                Row(
                  children: [
                    Icon(Icons.skip_previous,size: 35,),
                    Icon(Icons.play_circle,size: 35,),
                    Icon(Icons.skip_next,size: 35,),
                  ],
                ),
                Text("AL Bakarah",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
