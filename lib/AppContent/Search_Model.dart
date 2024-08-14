class Search_Model {
  bool? status;
  FirstData? data;

  Search_Model.Extract(Map<String, dynamic> map) {
    status = map["status"];
    data = FirstData.Extract(map["data"]);
    // data = map["data"] != null ? FirstData.Extract(map["data"]) : null;
  }
}

class FirstData {
  int? currentPage;
  List<FirstDataSearch> data = [];

  FirstData.Extract(Map<String, dynamic> map) {
    currentPage = map["current_page"];
    if (map['data'] != null) {
      for (var element in map['data']) {
        data.add(FirstDataSearch.Extract(element));
      }
    }
  }
}

class FirstDataSearch {
  int? id;
  dynamic price;
  dynamic old_price;
  int? discount;
  String? image;
  String? name;
  String? description;

  FirstDataSearch.Extract(Map<String, dynamic> map) {
    id = map['id'];
    price = map['price'];
    old_price = map['old_price'];
    discount = map['discount'];
    image = map['image'];
    name = map['name'];
    description = map['description'];
    
  }
}


