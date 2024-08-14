//Theme

import 'package:shop/AppContent/Update_Model.dart';
import 'package:shop/Login/ExtractData.dart';

abstract class ShopStates {}

class Initial extends ShopStates {}

class Bottom_Navigation extends ShopStates {}

class Extract_Data_Success extends ShopStates {}

class Extract_Data_Errro extends ShopStates {}

class Extract_Categories_Data_Success extends ShopStates {}

class Extract_Categories_Data_Errro extends ShopStates {}

class Favoritee_Success extends ShopStates {}

class Favoritee_Error extends ShopStates {
  final messgae;
  Favoritee_Error(this.messgae);
}

class change_Favorite_state_success extends ShopStates {}

class change_Favorite_state_error extends ShopStates {
  final messgae;
  change_Favorite_state_error(this.messgae);
}

class Favorite_Page_Model_Success extends ShopStates {}

class Favorite_Page_Model_Error extends ShopStates {}

class UserData_Success extends ShopStates {}

class UserData_Error extends ShopStates {}

class Search_Success extends ShopStates {}

class Search_Error extends ShopStates {}

class Loading extends ShopStates {}

class Update_Success extends ShopStates {
   LoginModel? ModelUpdate;

  Update_Success(this.ModelUpdate);
  
}

class Update_Error extends ShopStates {}

class Update_Loading extends ShopStates {}

class Change_Mode extends ShopStates{}
// class Bottom_Navigation extends ShopStates{}

// class Bottom_Navigation extends ShopStates{}

// class Bottom_Navigation extends ShopStates{}

