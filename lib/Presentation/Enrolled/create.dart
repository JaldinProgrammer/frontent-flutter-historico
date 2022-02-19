import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:historico_academico/main.dart';
import 'package:numberpicker/numberpicker.dart';

import 'package:historico_academico/Business/EnrolledBusiness.dart';
import 'package:historico_academico/Business/SemesterBusiness.dart';
import 'package:historico_academico/Business/SubjectBusiness.dart';
import 'package:historico_academico/Data/DataResponse.dart';
import 'package:historico_academico/Entities/Semester.dart';
import 'package:historico_academico/Entities/Subject.dart';
import 'package:historico_academico/assets/widgets/dialog.dart';
class CreateEnrolled extends StatefulWidget {
  const CreateEnrolled({Key? key}) : super(key: key);

  @override
  _CreateEnrolledState createState() => _CreateEnrolledState();
}

class _CreateEnrolledState extends State<CreateEnrolled> {
  String _semesterName = '';
  String _subjectName = '';
  String _semesterID = '';
  String _subjectID = '';
  int _grade = 0;
  int _anio = 2021;
  SemesterBusiness semesterBusiness = SemesterBusiness();
  SubjectBusiness subjectBusiness = SubjectBusiness();
  EnrolledBusiness enrolledBusiness = EnrolledBusiness();
  List<Subject> _listMaterias = [];
  List<Semester> _listSemester = [];
  @override
  void initState(){
    _loadSemesterData();
    _loadSubjectsData();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Crear Materia'),
        backgroundColor: Color.fromARGB(255, 55, 66, 250),
      ),
      body: Center(
        child: Column(
          children: [
            SizedBox(height: 10.0,),
            ListTile(
              leading: Icon(Icons.album_outlined, color: Color.fromARGB(255, 55, 66, 250),),
              title: Text('Semestre Elegido: ', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              subtitle: Text(_semesterName),
            ),
            Container(
              height: 70,
              child: CupertinoPicker(
                itemExtent: 50,
                children: _listSemester.map((item) => Center(
                  child: Text(item.period,
                      style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold, color: Color.fromARGB(255, 55, 66, 250)),
                  ),
                )).toList(),
                onSelectedItemChanged: (index){
                  setState(() {
                    _semesterID = _listSemester[index].id;
                    _semesterName = _listSemester[index].period;
                  });
                },
              ),
            ),
            SizedBox(height: 10.0,),
            ListTile(
              leading: Icon(Icons.album_outlined, color: Color.fromARGB(255, 55, 66, 250),),
              title: Text('Materia Elegida: ', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              subtitle: Text(_subjectName),
            ),
            Container(
              height: 70,
              child: CupertinoPicker(
                itemExtent: 50,
                children: _listMaterias.map((item) => Center(
                  child: Text(item.name,
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold, color: Color.fromARGB(255, 55, 66, 250)),
                  ),
                )).toList(),
                onSelectedItemChanged: (index){
                  setState(() {
                    _subjectID = _listMaterias[index].id;
                    _subjectName = _listMaterias[index].name;
                  });
                },
              ),
            ),
            SizedBox(height: 10.0,),
            ListTile(
              leading: Icon(Icons.album_outlined, color: Color.fromARGB(255, 55, 66, 250),),
              title: Text('Nota: ', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              subtitle: Text(_grade.toString()),
            ),
            Container(
              height: 40,
              child: NumberPicker(
                value: _grade,
                textStyle: TextStyle(color: Color.fromARGB(255, 55, 66, 250)),
                minValue: 0,
                maxValue: 100,
                itemHeight: 25,
                axis: Axis.horizontal,
                onChanged: (value){
                  setState(() {
                    _grade =  value.toInt();
                  });
                }
              ),
            ),
            SizedBox(height: 10.0,),
            ListTile(
              leading: Icon(Icons.album_outlined, color: Color.fromARGB(255, 55, 66, 250),),
              title: Text('Año: ', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              subtitle: Text(_anio.toString()),
            ),
            Container(
              height: 40,
              child: NumberPicker(
                  value: _anio,
                  textStyle: TextStyle(color: Color.fromARGB(255, 55, 66, 250)),
                  minValue: 2000,
                  maxValue: 2040,
                  itemHeight: 25,
                  axis: Axis.horizontal,
                  onChanged: (value){
                    setState(() {
                      _anio =  value.toInt();
                    });
                  }
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        backgroundColor: Color.fromARGB(255, 55, 66, 250),
        onPressed: (){storeEnrolled();}
      ),
    );
  }

  Future<void> storeEnrolled() async{
    showLoadingIndicator(context,'Creando materia...');
    DataResponse dataResponse=await enrolledBusiness.create(_anio.toString(), _grade.toString(), _subjectID, _semesterID);
    setState(() {
      hideOpenDialog(context);
      if (dataResponse.status){
        Navigator.pushReplacementNamed(context,userIndexRoute());
      }else{
        showAlertDialog(context, "Error al guardar materia", dataResponse.message);
      }
    });
  }

  void _loadSubjectsData() async{
    await Future.delayed(Duration(milliseconds: 10));
    //showLoadingIndicator(context,'');
    DataResponse dataResponse=await subjectBusiness.index();
    List<Subject> items=dataResponse.data;
    setState(() {
        _listMaterias = items;
    });
  }

  void _loadSemesterData() async{
    await Future.delayed(Duration(milliseconds: 10));
    DataResponse dataResponse=await semesterBusiness.index();
    List<Semester> items=dataResponse.data;
    setState(() {
      _listSemester = items;
    });
  }



}
