
import 'package:historico_academico/Data/DataResponse.dart';
import 'package:historico_academico/Data/SubjectData.dart';

class SubjectBusiness{
  SubjectData subjectData = new SubjectData();
  Future<DataResponse> index() async => await subjectData.index();
}