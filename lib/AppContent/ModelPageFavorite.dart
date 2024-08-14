class FavPageModel {
  bool? status;
  FirstData? data;

  FavPageModel.Extract(Map<String, dynamic> map) {
    status = map["status"];
    data = FirstData.Extract(map["data"]);
    // data = map["data"] != null ? FirstData.Extract(map["data"]) : null;
  }
}

class FirstData {
  int? currentPage;
  List<SecondData> data = [];

  FirstData.Extract(Map<String, dynamic> map) {
    currentPage = map["current_page"];
    if (map['data'] != null) {
      for (var element in map['data']) {
        data.add(SecondData.Extract(element));
      }
    }
  }
}

class SecondData {
  int? id;
  FavProductModel? Products;

  SecondData.Extract(Map<String, dynamic> map) {
    id = map["id"];
    Products =
        map["product"] != null ? FavProductModel.Extract(map["product"]) : null;
  }
}

class FavProductModel {
  int? id;
  dynamic price;
  dynamic old_price;
  int? discount;
  String? image;
  String? name;
  String? description;

  FavProductModel.Extract(Map<String, dynamic> map) {
    id = map['id'];
    price = map['price'];
    old_price = map['old_price'];
    discount = map['discount'];
    image = map['image'];
    name = map['name'];
    description = map['description'];
  }
}
