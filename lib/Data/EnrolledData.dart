import 'dart:convert';
import 'package:historico_academico/Session/UserSession.dart';
import 'package:http/http.dart' as http;
import 'package:historico_academico/Data/DataResponse.dart';
import 'package:historico_academico/env.dart';
import 'package:historico_academico/Entities/Enrolled.dart';
class EnrroledData{

  Future<DataResponse> delete(String token,Enrroled enrroled) async{
    DataResponse dataResponse=new DataResponse();
    //print("MARCA CARLOS: ${enrroled.id}");
    try {
      var url = Uri.parse(host+'/api/loggedUser/subjects/destroy');
      final http.Response response =await http.post(url,
          headers: { 'Accept' : 'application/json' , 'Authorization' : 'Bearer '+token },
          body: {
            'enrolled_id': enrroled.id,
          }
      );
      print(response.body);
      const JsonDecoder decoder = const JsonDecoder();
      var item = decoder.convert(response.body);
      if (response.statusCode == 200) {
        dataResponse.data=enrroled;
        dataResponse.status=true;
      }
      dataResponse.message=item['message'];
    }catch(error){
      print(error.toString());
      dataResponse.message=error.toString();
    }
    return dataResponse;
  }

  Future<DataResponse> update(String token,Enrroled enrroled) async{
    DataResponse dataResponse=new DataResponse();
    try {
      var url = Uri.parse(host+'/api/loggedUser/subjects/update');
      final http.Response response =await http.post(url,
          headers: { 'Accept' : 'application/json' , 'Authorization' : 'Bearer '+token },
          body: {
            'year':enrroled.year,
            'grade':enrroled.grade,
            'subject_id':enrroled.subject_id,
            'semester_id':enrroled.semester_id,
            'enrolled_id':enrroled.id,
          }
      );

      print(response.body);
      const JsonDecoder decoder = const JsonDecoder();
      var item = decoder.convert(response.body);
      if (response.statusCode == 200) {
        var data=item['data'];
        Enrroled enrolled = Enrroled();
        enrolled.id = data['id'].toString();
        enrolled.grade = data['grade'].toString();
        enrolled.subject_id = data['subject_id'].toString();
        enrolled.semester_id = data['semester_id'].toString();
        enrolled.user_id = data['user_id'].toString();
        dataResponse.data=enrolled;
        dataResponse.status=true;
      }
      dataResponse.message=item['message'];
    }catch(error){
      print(error.toString());
      dataResponse.message=error.toString();
    }
    return dataResponse;
  }


  Future<DataResponse> create(String token, Enrroled enrroled) async{
    DataResponse dataResponse=new DataResponse();
    try{
      var url = Uri.parse(host+'/api/loggedUser/subjects/store');
      final http.Response response =await http.post(url,
        headers: { 'Accept' : 'application/json' , 'Authorization' : 'Bearer '+token},
          body: { 'year': enrroled.year,
            'grade':enrroled.grade,
            'subject_id':enrroled.subject_id,
            'semester_id':enrroled.semester_id,
            'user_id': UserSession.user.id
        },
      );
      print(response.body);
      const JsonDecoder decoder = const JsonDecoder();
      var item = decoder.convert(response.body);
      if (response.statusCode == 200) {
        var data=item['data'];
        Enrroled enrolled = Enrroled();
        enrolled.id = data['id'].toString();
        enrolled.grade = data['grade'].toString();
        enrolled.subject_id = data['subject_id'].toString();
        enrolled.semester_id = data['semester_id'].toString();
        enrolled.user_id = data['user_id'].toString();
        dataResponse.data=enrolled;
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

  Future<DataResponse> index(String token) async{
    DataResponse dataResponse=new DataResponse();
    try {
      var url = Uri.parse(host+'/api/loggedUser/subjects');
      final http.Response response =await http.get(url,
        headers: { 'Accept' : 'application/json' , 'Authorization' : 'Bearer '+token },
      );

      print(response.body);
      const JsonDecoder decoder = const JsonDecoder();
      var item = decoder.convert(response.body);
      if (response.statusCode == 200) {
        List<Enrroled> items=List.generate(0, (index) => new Enrroled());
        List list=item['data'];
        list.forEach((element) {
          Enrroled enrroled=new Enrroled();
          enrroled.id=element['id'].toString();
          enrroled.year=element['year'].toString();
          enrroled.grade=element['grade'].toString();
          enrroled.subject_id=element['subject_id'].toString();
          enrroled.semester_id=element['semester_id'].toString();
          items.add(enrroled);
        });

        dataResponse.data=items;
        dataResponse.status=true;
      }
      dataResponse.message=item['message'];
    }catch(error){
      print(error.toString());
      dataResponse.message=error.toString();
    }
    return dataResponse;
  }


}