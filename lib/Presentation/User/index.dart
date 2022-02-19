import 'dart:ffi';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:historico_academico/Business/EnrolledBusiness.dart';
import 'package:historico_academico/Entities/Enrolled.dart';
import 'package:historico_academico/Business/UserBusiness.dart';
import 'package:historico_academico/Entities/User.dart';
import 'package:historico_academico/Data/DataResponse.dart';
import 'package:historico_academico/Presentation/Enrolled/edit.dart';
import 'package:historico_academico/assets/widgets/dialog.dart';
import 'package:historico_academico/Data/UserData.dart';
import 'package:historico_academico/main.dart';
class UserIndex extends StatefulWidget {
  const UserIndex({Key? key}) : super(key: key);

  @override
  _UserIndexState createState() => _UserIndexState();
}

class _UserIndexState extends State<UserIndex> {

  UserBusiness userBusiness = new UserBusiness();
  EnrolledBusiness enrolledBusiness = new EnrolledBusiness();
  User _user = new User();
  String _ppa = "0";
  List<Widget> _listMaterias = List.generate(0, (index) =>SizedBox(height: 1,));
  List<String> data = [];
  @override
  void initState(){
    _loadEnrolledData();
    _loadUserData();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;
    const Color _mainColor = Color.fromARGB(255, 55, 66, 250);
    return Scaffold(
      backgroundColor: Colors.black,
      body: Card(
        child: Column(
          children: [
            Container(
              height: 330,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(50),
                ),
                color: _mainColor,
                  boxShadow: [
                    new BoxShadow(
                        color: _mainColor.withOpacity(0.5),
                        offset: new Offset(-10, 0.0),
                        blurRadius: 20.0,
                        spreadRadius: 4.0
                    )
                  ]
              ),
              child: Stack(
                children: [
                  Positioned(
                    child: Container(
                      height: 100,
                      width: 350,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(50),
                          bottomRight: Radius.circular(50)
                        )
                      ),
                    ),
                    top: 80,
                    left: 0,
                  ),
                  Positioned(
                    top: 110,
                      left: 20,
                      child: Text(
                        _user.name,
                        style: const TextStyle(
                            fontSize: 20,
                            color: _mainColor,
                            fontWeight: FontWeight.bold,
                        ),
                      )
                  ),
                  Positioned(
                      top: 200,
                      left: 20,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Registro",
                            style: TextStyle(color: Colors.white, fontSize: 13),
                          ),
                          const SizedBox(
                            height: 2,
                          ),
                          Text(
                            _user.register,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 3,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              TextButton(
                                  onPressed: (){
                                    Navigator.pushReplacementNamed(context,createEnrolledRoute());
                                  },
                                  child: Icon(Icons.add, color: Colors.white,),
                                  style: ButtonStyle(
                                    backgroundColor: MaterialStateProperty.all(Colors.blueAccent.shade200),
                                    overlayColor: MaterialStateProperty.all(_mainColor)
                                  ),
                              ),
                              SizedBox(width: 20,),
                              TextButton(
                                onPressed: ()async{
                                  await Future.delayed(Duration(milliseconds: 10));
                                  showLoadingIndicator(context,'Good bye');
                                  DataResponse dataResponse=await userBusiness.logout();
                                  setState(() {
                                    hideOpenDialog(context);
                                    if (dataResponse.status){
                                      Navigator.pushNamedAndRemoveUntil(context,loginRoute(), (Route<dynamic> route) => false);
                                    }else{
                                      showAlertDialog(context, "Error al cerrar sesion", dataResponse.message);
                                    }
                                  });
                                },
                                child: Icon(Icons.logout, color: Colors.blueAccent,),
                                style: ButtonStyle(
                                    backgroundColor: MaterialStateProperty.all(Colors.white),
                                    overlayColor: MaterialStateProperty.all(_mainColor),
                                ),
                              ),
                              SizedBox(width: width*0.3),
                              Column(
                                children: [
                                  const Text(
                                    "ppa",
                                    style: TextStyle(color: Colors.white, fontSize: 20),
                                  ),
                                  const SizedBox(
                                    height: 2,
                                  ),
                                  Text(
                                    _ppa,
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 32,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          )
                        ],
                      ),
                  ),
                ],
              ),
            ),
            Expanded(
                child: listOfGrades()
            )
          ],
        ),
      ),
    );
  }

  Widget listOfGrades(){
    return ListView.builder(
        itemCount: _listMaterias.length,
        itemBuilder: (context,index){
          return _listMaterias[index];
        }
    );
  }

  Widget _gradeCard(bool direction, Enrroled materia){

    Radius bl = Radius.circular(80.0);
    Radius tp = Radius.circular(0.0);
    Color cardColor = Color.fromARGB(255, 12, 147, 58);
    if(!direction){
      bl = Radius.circular(0.0);
      tp = Radius.circular(80.0);
    }
    if(double.parse(materia.grade) <= 80.0){
      cardColor = Colors.deepOrange.shade800;
    }
    return Container(
      margin: EdgeInsets.only(bottom: 10,top: 25),
      height: 250,
      padding: EdgeInsets.only(left: 20,right: 20,bottom: 20),
      child: Container(
        decoration: BoxDecoration(
            color: cardColor,
            borderRadius: BorderRadius.only(
              bottomLeft: bl,
              topRight: tp,
            ),
            boxShadow: [
              new BoxShadow(
                  color: cardColor.withOpacity(0.5),
                  offset: new Offset(-10, 0.0),
                  blurRadius: 20.0,
                  spreadRadius: 4.0
              )
            ]
        ),
        padding: EdgeInsets.only(
            left: 30,
            top: 15.0,
            bottom: 50
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Periodo",
              style: TextStyle(color: Colors.white, fontSize: 13),
            ),
            SizedBox(
              height: 2,
            ),
            Text(
              "${materia.semester_id} - ${materia.year}",
              style: TextStyle(
                color: Colors.white,
                fontSize: 15,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 9,),
            Container(
              child: Row(
                children: [
                  Column(
                    children: [
                      SizedBox(height: 9,),
                      Text(
                        "Nota",
                        style: TextStyle(color: Colors.white, fontSize: 13),
                      ),
                      SizedBox(
                        height: 2,
                      ),
                      Text(
                        "${materia.grade}",
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(width: 130, height: 5,),
                  TextButton(
                    onPressed: (){
                      Navigator.pushNamed(context, updateEnrolledRoute(),arguments: EditEnrolledArguments(materia));
                    },
                    child: Icon(Icons.edit, color: Colors.black),
                    style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(Colors.yellow),
                        overlayColor: MaterialStateProperty.all(cardColor)
                    ),
                  ),
                  SizedBox(width: 20,),
                  TextButton(
                    onPressed: ()async{
                      _deleteEnrolledData(materia);
                    },
                    child: Icon(Icons.delete, color: Colors.black,),
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.red.shade800),
                      overlayColor: MaterialStateProperty.all(cardColor),
                    ),
                  ),

                ],
              ),
            ),
            SizedBox(height: 9,),
            Text(
              "Materia",
              style: TextStyle(color: Colors.white, fontSize: 13),
            ),
            SizedBox(
              height: 2,
            ),
            Flexible(
              child: Text(
                "${materia.subject_id}",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _loadUserData() async{
    await Future.delayed(Duration(milliseconds: 10));
     showLoadingIndicator(context,'');
    DataResponse dataResponse=await userBusiness.index();
    DataResponse dataResponsePpa = await userBusiness.getPpa();
    setState(() {
      hideOpenDialog(context);
      _user = dataResponse.data;
      _ppa = dataResponsePpa.data.toString();
    });
  }

  void _deleteEnrolledData(Enrroled enrroled) async{
    await Future.delayed(Duration(milliseconds: 10));
    showLoadingIndicator(context,'');
    DataResponse dataResponse=await enrolledBusiness.delete(enrroled);
    setState(() {
      hideOpenDialog(context);
      if (dataResponse.status){
        Navigator.pushReplacementNamed(context,userIndexRoute());
      }else{
        showAlertDialog(context, "Error al eliminar nota", dataResponse.message);
      }
      });
  }

  void _loadEnrolledData() async{
    await Future.delayed(Duration(milliseconds: 10));
    showLoadingIndicator(context,'');
    DataResponse dataResponse=await enrolledBusiness.index();
    List<Enrroled> materias = dataResponse.data;
    bool f = true;
    setState(() {
        hideOpenDialog(context);
        materias.forEach((element) {
            var c = _gradeCard(f,element);
            _listMaterias.add(c);
          f=!f;
        });
    });
  }
}
