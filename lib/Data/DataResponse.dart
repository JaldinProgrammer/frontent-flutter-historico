class DataResponse{
  bool status=false;
  dynamic data;
  String message="";

  bool getStatus() => this.status;
  dynamic getData() => this.data;
  String getMessage() => this.message;
}