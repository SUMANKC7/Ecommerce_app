class ProductModel {
  int? id;
  String? title;
  double? price;
  double? rating;
  String? thumbnail;
  double? discountPercentage;

  ProductModel(
    this.id,
    this.title,
    this.price,
    this.rating,
    this.thumbnail,
    this.discountPercentage,
  );

  ProductModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    price = (json['price'] as num).toDouble(); // Ensures price is a double
    rating = (json['rating'] as num).toDouble(); // Ensures rating is a double
    thumbnail = json['thumbnail'];
    discountPercentage = (json["discountPercentage"] as num).toDouble();
  }

  
}