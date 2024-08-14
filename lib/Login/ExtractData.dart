class LoginModel {
  bool? status;
  String? message;
  DataModel? data;


LoginModel.ExtractData( Model)
{

status=Model['status'];
message=Model['message'];

data=Model['data']==null?null :DataModel.ExtractData(Model['data']);//
}

}

class DataModel {
  int? id;
  String? name;
  String ?email;
  String? phone;
  late var image;
  int ?points;
  int? credit;
  String? token;
  

   DataModel.ExtractData(   Model) {

id=Model['id'];
name=Model['name'];
email=Model['email'];
phone=Model['phone'];
image=Model['image'];
points=Model['points'];
credit=Model['credit'];
token=Model['token'];


  }
}
