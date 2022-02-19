
import 'package:historico_academico/Data/DataResponse.dart';
import 'package:historico_academico/Data/EnrolledData.dart';
import 'package:historico_academico/Entities/Enrolled.dart';
import 'package:historico_academico/Session/UserSession.dart';

class EnrolledBusiness{
  EnrroledData enrolledData = new EnrroledData();

  Future<DataResponse> delete(Enrroled enrroled) async {
    DataResponse dataResponse =
    await enrolledData.delete(UserSession.user.token, enrroled);
    return dataResponse;
  }

  Future<DataResponse> update(Enrroled enrroled) async {
    DataResponse dataResponse =
    await enrolledData.update(UserSession.user.token, enrroled);
    return dataResponse;
  }

  Future<DataResponse> create(
      String year,
      String grade,
      String subject_id,
      String semester_id
      ) async{
    Enrroled enrroled = Enrroled();
    enrroled.year = year;
    enrroled.grade = grade;
    enrroled.subject_id = subject_id;
    enrroled.semester_id = semester_id;
    return await enrolledData.create(UserSession.user.token, enrroled);
  }

  Future<DataResponse> index() async {
    //List<Enrroled> items = List.generate(0, (index) => new Enrroled());
    DataResponse dataResponse = await enrolledData.index(UserSession.user.token);
    //items = dataResponse.data;
    return dataResponse;
  }

}