import 'package:flutter/material.dart';
import 'package:quran_app/audio_screen.dart';
import 'package:quran_app/view/screens/sura_details.dart';
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int selectedIndex = -1;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 80,
        leading: const Icon(Icons.menu),
        title: const Column(
          children: [
            Text("Assalamuyalaikum",style: TextStyle(fontSize: 14),),
            Text("Fazle Rabbi"),
          ],
        ),
        actions: const [
          CircleAvatar(
            radius: 25,
            backgroundColor: Colors.white,
          )
        ],
        centerTitle: true,
        backgroundColor: Colors.amber,
      ),

      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Container(
          padding: const EdgeInsets.all(10),
          alignment: Alignment.center,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 150,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.amber
                ),
                child: const Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("ISHA",style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold)),
                    Text("08.00 PM",style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold)),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.location_on),
                        Text("Dhaka, Bangladesh"),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),

              const Text("Reading Sura"),
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
                    Text("Last Read",style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold)),
                    Text("AL - FATIHA",style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold)),
                    Text("Continue Reading"),
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),

              /// Sura List
              ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: 10,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        debugPrint("$index");
                        setState(() {
                          selectedIndex = index;
                        });
                        Navigator.of(context).push(MaterialPageRoute(builder: (context) => const SuraDetailsPage()));
                      },
                      child: ListTile(
                        tileColor: selectedIndex == index?Colors.amber:Colors.transparent,
                        leading: Stack(
                          alignment: Alignment.center,
                          children: [
                            Image.asset('assets/icon/star.png'),
                            Text('$index',style: const TextStyle(fontSize: 12,fontWeight: FontWeight.bold))
                          ],
                        ),
                        title: const Text("Al Fatiha",style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold)),
                        subtitle: const Text("Opening - Verse 7"),
                        trailing: const Text("الفاتحة",style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold)),
                      ),
                    );
                  },
              )
            ],
          ),
        ),
      ),
    );
  }
}
