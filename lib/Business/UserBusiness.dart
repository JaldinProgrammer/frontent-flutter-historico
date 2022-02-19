import 'dart:convert';
import 'package:historico_academico/Data/DataResponse.dart';
import 'package:historico_academico/Data/UserData.dart';
import 'package:historico_academico/Entities/User.dart';
import 'package:historico_academico/Session/UserSession.dart';


class UserBusiness{
  UserData userData=new UserData();

  Future<DataResponse> logout() async{
    DataResponse dataResponse=await this.userData.logout(UserSession.user.token);
    if (dataResponse.status){
      User usr=new User();
      UserSession.setSession(usr);
    }
    return dataResponse;
  }

  Future<DataResponse> login(String register,String password) async{
    DataResponse response=await userData.login(register,password);
    if (response.status){
      User usr=response.data;
      UserSession.setSession(usr);
    }
    return response;
  }

  Future<DataResponse> index() async {
    DataResponse dataResponse = await userData.index(UserSession.user.token);
    return dataResponse;
  }

  Future<DataResponse> getPpa() async {
    DataResponse dataResponse = await userData.getPpa(UserSession.user.token);
    return dataResponse;
  }

  // Future<DataResponse> signup(String name,String email,String password,String passwordConfirm) async{
  //   DataResponse dataResponse=new DataResponse();
  //
  //   if (password!=passwordConfirm){
  //     dataResponse.status=false;
  //     dataResponse.message='La contraseña y la confirmacion no son iguales';
  //     return dataResponse;
  //   }
  //
  //   dataResponse=await this.userData.signup(name,email,password,passwordConfirm);
  //   if (dataResponse.status){
  //     User usr=dataResponse.data;
  //     UserSession.setSession(usr);
  //   }
  //
  //   return dataResponse;
  // }

  // Future<DataResponse> logout() async{
  //   DataResponse dataResponse=await this.userData.logout(UserSession.user.token);
  //   if (dataResponse.status){
  //     User usr=new User();
  //     UserSession.setSession(usr);
  //   }
  //   return dataResponse;
  // }

}