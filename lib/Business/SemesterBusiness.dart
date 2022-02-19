
import 'package:historico_academico/Data/DataResponse.dart';
import 'package:historico_academico/Data/SemesterData.dart';

class SemesterBusiness{
  SemesterData semesterData = new SemesterData();
  Future<DataResponse> index() async => await semesterData.index();
}