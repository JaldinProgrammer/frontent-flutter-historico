import 'dart:convert';
import 'package:historico_academico/Entities/Subject.dart';
import 'package:http/http.dart' as http;

import 'package:historico_academico/env.dart';
import 'package:historico_academico/Data/DataResponse.dart';
class SubjectData{
  Future<DataResponse> index() async {
    DataResponse dataResponse = new DataResponse();
    try{
      var url = Uri.parse(host+'/api/subject/all');
      final http.Response response =await http.get(url,
        headers: { 'Accept' : 'application/json'},
      );
      print(response.body);
      const JsonDecoder decoder = const JsonDecoder();
      var item = decoder.convert(response.body);
      if (response.statusCode == 200) {
        List<Subject> items=List.generate(0, (index) => new Subject());
        List list=item['data'];
        list.forEach((element) {
          Subject semester=new Subject();
          semester.id=element['id'].toString();
          semester.credit=element['credit'].toString();
          semester.name=element['name'].toString();
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