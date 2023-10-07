import 'package:flutter/material.dart';
import 'package:quran_app/view/screens/sura_details.dart';

class SearchSura extends StatefulWidget {
  final List sura;
  const SearchSura({super.key,required this.sura});

  @override
  State<SearchSura> createState() => _SearchSuraState();
}

class _SearchSuraState extends State<SearchSura> {
  final searchController = TextEditingController();
  int selectedIndex =-1;
  String? searchKey;
  List filteredList = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amber,
        title: TextField(
          controller: searchController,
          decoration: const InputDecoration(
            hintText: 'Eg. Al Fatiha',
            border: InputBorder.none,
            suffix: Icon(Icons.search)
          ),
          onChanged: (value) {
            setState(() {
              filteredList = widget.sura.where((item) => item['namaLatin'].toString().toLowerCase().contains(value.toLowerCase())).toList();
            });
          },
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(10),
          child: filteredList.isEmpty? const Text('Empty'):
          ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: filteredList.length,
            itemBuilder: (context, index) {
              final suraInfo = widget.sura[index];
              return GestureDetector(
                onTap: () {
                  debugPrint("$index");
                  setState(() {
                    selectedIndex = index;
                  });
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => SuraDetailsPage(index: index+1,speaker: 5)));
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
        ),
      ),
    );
  }
}
