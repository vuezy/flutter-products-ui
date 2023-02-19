class Product {
  late int id;
  late String title;
  late String description;
  late num price;
  late int discount;
  late int discountPrice;
  late num rating;
  late int stock;
  late String brand;
  late String category;
  late String thumbnail;
  late List<dynamic> images;

  Product.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    description = json['description'];
    price = json['price'];
    discount = json['discountPercentage'].round();
    discountPrice = ((100 - json['discountPercentage']) / 100 * json['price']).round();
    rating = json['rating'];
    stock = json['stock'];
    brand = json['brand'];
    category = _changeCategoryFormat(json['category']);
    thumbnail = json['thumbnail'];
    images = json['images'];
  }

  String _changeCategoryFormat(String category) {
    String result = '';
    for (int i = 0; i < category.length; i++) {
      if (i == 0 || category[i - 1] == '-') {
        result += category[i].toUpperCase();
      }
      else if (category[i] == '-') {
        result += ' ';
      }
      else {
        result += category[i];
      }
    }
    return result;
  }
}