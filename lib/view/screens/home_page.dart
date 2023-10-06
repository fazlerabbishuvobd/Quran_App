import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:quran_app/view/screens/sura_details.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int selectedIndex = -1;
  bool isLoading = false;
  List<dynamic> suraList = [];

  Future<List<dynamic>> getSuraList() async{
    try{
      setState(() {
        isLoading = true;
      });
      final response = await http.get(Uri.parse('https://equran.id/api/v2/surat'));
      setState(() {
        isLoading =false;
      });
      if(response.statusCode == 200)
        {
          final jsonData = jsonDecode(response.body);
          setState(() {
            suraList = jsonData['data'];
          });
          return suraList;
        }
      else{
        throw Exception('Cannot Connected to Server');
      }
    }catch(e)
    {
      throw Exception(e.toString());
    }
  }

  @override
  void initState() {
    Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {

      });
    });
    getSuraList();
    super.initState();
  }

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
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(DateTime.now().toString().split(' ')[1].split('.')[0],style: const TextStyle(fontSize: 30,fontWeight: FontWeight.bold)),
                    const Row(
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
              const SizedBox(
                height: 10,
              ),

              /// Sura List
              isLoading?const Center(child: CircularProgressIndicator(),):ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: suraList.length,
                itemBuilder: (context, index) {
                  final suraInfo = suraList[index];
                  return GestureDetector(
                    onTap: () {
                      debugPrint("$index");
                      setState(() {
                        selectedIndex = index;
                      });
                      Navigator.of(context).push(MaterialPageRoute(builder: (context) => SuraDetailsPage(index: index+1,)));
                    },
                    child: ListTile(
                      tileColor: selectedIndex == index?Colors.amber:Colors.transparent,
                      leading: Stack(
                        alignment: Alignment.center,
                        children: [
                          Image.asset('assets/icon/star.png'),
                          Text('${index+1}',style: const TextStyle(fontSize: 12,fontWeight: FontWeight.bold))
                        ],
                      ),
                      title: Text(suraInfo['namaLatin'],style: const TextStyle(fontSize: 16,fontWeight: FontWeight.bold)),
                      subtitle: Text("${suraInfo['tempatTurun']} - Verse ${suraInfo['jumlahAyat']}"),
                      trailing: Text(suraInfo['nama'],style: const TextStyle(fontSize: 16,fontWeight: FontWeight.bold)),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
