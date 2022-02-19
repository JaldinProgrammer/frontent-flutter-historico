import 'dart:convert';
import 'package:historico_academico/Entities/Semester.dart';
import 'package:http/http.dart' as http;

import 'package:historico_academico/env.dart';
import 'package:historico_academico/Data/DataResponse.dart';

class SemesterData{
  Future<DataResponse> index() async {
    DataResponse dataResponse = new DataResponse();
    try{
      var url = Uri.parse(host+'/api/semester/all');
      final http.Response response =await http.get(url,
        headers: { 'Accept' : 'application/json'},
      );
      print(response.body);
      const JsonDecoder decoder = const JsonDecoder();
      var item = decoder.convert(response.body);
      if (response.statusCode == 200) {
        List<Semester> items=List.generate(0, (index) => new Semester());
        List list=item['data'];
        list.forEach((element) {
          Semester semester=new Semester();
          semester.id=element['id'].toString();
          semester.period=element['period'].toString();
          items.add(semester);
        });
        dataResponse.data=items;
        dataResponse.status=true;
      }
      dataResponse.message=item['message'];
    }
    catch(error){
      print(error.toString());
      dataResponse.message=error.toString();
    }
    return dataResponse;
  }
}