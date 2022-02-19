import 'dart:convert';


import 'package:http/http.dart' as http;
import 'package:historico_academico/Data/DataResponse.dart';
import 'package:historico_academico/Entities/User.dart';
import 'package:historico_academico/env.dart';

class UserData{

  Future<DataResponse> logout(String _token) async{
    DataResponse dataResponse=new DataResponse();
    try{
      var url = Uri.parse(host+'/api/logout');
      final http.Response response =await http.post(url,
          headers: { 'Accept' : 'application/json' , 'Authorization' : 'Bearer '+_token },
          body: { });
      print(response.body);
      const JsonDecoder decoder = const JsonDecoder();
      var item = decoder.convert(response.body);

      dataResponse.status=response.statusCode == 200;
      dataResponse.message=item['message'];
    }catch(error){
      print(error.toString());
      dataResponse.message=error.toString();
    }
    return dataResponse;
  }

  Future<DataResponse> login(String register,String password) async{
    DataResponse dataResponse=new DataResponse();
    try{
      var url = Uri.parse(host+'/api/login');
      final http.Response response =await http.post(url,
          headers: { 'Accept' : 'application/json' },
          body: {'register': register, 'password': password});

      print(response.body);
      const JsonDecoder decoder = const JsonDecoder();
      var item = decoder.convert(response.body);

      if (response.statusCode == 200) {
        var data=item['data'];

        User user=new User();
        user.id=data['id'].toString();
        user.name=data['name'];
        user.register=data['register'];
        user.ppa=data['ppa'].toString();
        user.token=item['token'];
        dataResponse.data=user;
        dataResponse.status=true;
      }
      dataResponse.message=item['message'];
    }catch(error){
      print(error.toString());
      dataResponse.message=error.toString();
    }
    return dataResponse;
  }

  Future<DataResponse> getPpa(String token) async{
    DataResponse dataResponse=new DataResponse();
    try{
      var url = Uri.parse(host+'/api/subjects/ppa');
      final http.Response response =await http.get(url,
        headers: { 'Accept' : 'application/json' , 'Authorization' : 'Bearer '+token },
      );
      print(response.body);
      const JsonDecoder decoder = const JsonDecoder();
      var item = decoder.convert(response.body);
      if (response.statusCode == 200) {
        dataResponse.data= item['data'];
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
      var url = Uri.parse(host+'/api/user');
      final http.Response response =await http.get(url,
        headers: { 'Accept' : 'application/json' , 'Authorization' : 'Bearer '+token },
      );
      print(response.body);
      const JsonDecoder decoder = const JsonDecoder();
      var item = decoder.convert(response.body);
      if (response.statusCode == 200) {
        User user = new User();
        Map datos = item['data'];
        user.ppa = datos['ppa'].toString();
        user.id = datos['id'].toString();
        user.register = datos['register'].toString();
        user.name = datos['name'].toString();
        dataResponse.data= user;
        dataResponse.status=true;
      }
      dataResponse.message=item['message'];
    }catch(error){
      print(error.toString());
      dataResponse.message=error.toString();
    }
    return dataResponse;
  }

  // Future<DataResponse> signup(String name,String email,String password,String passwordConfirm) async{
  //   DataResponse dataResponse=new DataResponse();
  //
  //   try{
  //     var url = Uri.parse(host+'/api/signup');
  //     final http.Response response =await http.post(url,
  //         headers: { 'Accept' : 'application/json' },
  //         body: {'name': name,'email': email, 'password': password , 'password_confirm': passwordConfirm});
  //
  //     print(response.body);
  //     const JsonDecoder decoder = const JsonDecoder();
  //     var item = decoder.convert(response.body);
  //     if (response.statusCode == 200) {
  //       var data=item['data'];
  //
  //       User user=new User();
  //       user.id=data['id'].toString();
  //       user.name=data['name'];
  //       user.email=data['email'];
  //       user.token=item['token'];
  //
  //       dataResponse.data=user;
  //       dataResponse.status=true;
  //     }
  //     dataResponse.message=item['message'];
  //   }catch(error){
  //     print(error.toString());
  //     dataResponse.message=error.toString();
  //   }
  //
  //   return dataResponse;
  // }
  //
  // Future<DataResponse> logout(String _token) async{
  //   DataResponse dataResponse=new DataResponse();
  //   try{
  //     var url = Uri.parse(host+'/api/logout');
  //     final http.Response response =await http.post(url,
  //         headers: { 'Accept' : 'application/json' , 'Authorization' : 'Bearer '+_token },
  //         body: { });
  //
  //     print(response.body);
  //     const JsonDecoder decoder = const JsonDecoder();
  //     var item = decoder.convert(response.body);
  //
  //     dataResponse.status=response.statusCode == 200;
  //     dataResponse.message=item['message'];
  //
  //   }catch(error){
  //     print(error.toString());
  //     dataResponse.message=error.toString();
  //   }
  //
  //   return dataResponse;
  // }

}