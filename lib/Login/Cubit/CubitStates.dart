import 'package:shop/Login/ExtractData.dart';

abstract class LoginStates {}

class initial extends LoginStates {}

class Toggle_Password extends LoginStates {}

class Loading extends LoginStates {}

class Login_Success extends LoginStates {
  var Model;

  Login_Success(this.Model);
}

class Login_Failed extends LoginStates {
  late String Error;
  Login_Failed(String Error) {
    this.Error = Error;
  }
}

class Save_Skipped extends LoginStates {}

class Register_Success extends LoginStates {
  var  Model;
  Register_Success(this.Model);
}

class Register_Failed extends LoginStates {}
