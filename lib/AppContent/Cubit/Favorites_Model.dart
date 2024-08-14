import 'package:flutter/foundation.dart';

class FavouriteModel {
  late bool status;
  late String message;
  FavouriteModel.Extract(Map) {
    status = Map["status"];
    message = Map["message"];
  }
}
