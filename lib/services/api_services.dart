import 'dart:convert';

import 'package:http/http.dart' as http;

class ApiServices{
  List<dynamic> suraList = [];

  Future<List<dynamic>> getSuraLists() async{
    try{
      final response = await http.get(Uri.parse('https://equran.id/api/v2/surat'));
      if(response.statusCode == 200)
      {
        final jsonData = jsonDecode(response.body);
          return suraList = jsonData['data'];
      }
      else{
        return [];
      }
    }catch(e)
    {
      throw Exception(e.toString());
    }
  }
}