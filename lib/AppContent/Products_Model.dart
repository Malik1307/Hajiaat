class ProductModel {
late  bool status;
  // String message;
late  ProductData data;

  ProductModel.Extract(dynamic Model) {
    status = Model['status'];
    // message = Model['message'];

    data = ProductData.Extract(Model['data']);
  }
}

class ProductData {
  late List<BannerModel> banners=[];
  late List<ProductModelModel> products=[];

  ProductData.Extract(dynamic Model) {
    ////
    ///
    for (var element in Model['banners']) {
      banners.add(BannerModel.Extract(element));
    }
    for (var element in Model['products']) {
      products.add(ProductModelModel.Extract(element));
    }
  }
}

class ProductModelModel {
late   int id;
late  var price;
late  var old_price;
late  var discount;
late  String name;
late  String image;
late  bool in_favorites;
late  bool in_cart;

  ProductModelModel.Extract(dynamic Model) {
    id = Model['id'];
    price = Model['price'];
    old_price = Model['old_price'];
    discount = Model['discount'];
    name = Model['name'];
    image = Model['image'];
    in_favorites = Model['in_favorites'];
    in_cart = Model['in_cart'];
  }
}

class BannerModel {
late  int id;
late  String image;
  BannerModel.Extract(dynamic Model) {

id=Model['id'];
image = Model['image'];


  }
}
