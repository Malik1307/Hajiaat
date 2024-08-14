class Categories_Model {
  bool? status;
  DataModel? Data;
  Categories_Model.Extract(Map<String,dynamic> Model) {
    status = Model['status'];
    Data = DataModel.Extract(Model['data']) ?? null;
  }
}

class DataModel {
  List<DataModelModel> Data = [];

  int? current_page;

  DataModel.Extract(Map Model) {
    current_page = Model['current_page'];
    for (var element in Model['data'])
    Data.add(DataModelModel.Extract(element))  ;///
  }
}

class DataModelModel {
  String? name;
  String? image;
  int? id;

  DataModelModel.Extract(Map Model) {
    name = Model['name'];
    id = Model['id'];
    image = Model['image'];
  }
}
