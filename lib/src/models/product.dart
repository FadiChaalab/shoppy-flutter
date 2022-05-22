import 'package:shop/src/models/rating.dart';
import 'package:shop/src/models/review.dart';

class Product {
  final String id;
  final String title;
  final String description;
  final double price;
  final List<String> images;
  final String userId;
  final int quantity;
  final String category;
  final String brand;
  final double remise;
  final List<Rating> ratings;
  final List<Review> reviews;
  final bool flashSales;
  final bool newProduct;
  final bool bestSeller;
  final bool popular;
  final bool blackMarket;
  final bool summerSales;

  Product({
    required this.id,
    required this.title,
    required this.description,
    required this.price,
    required this.images,
    required this.userId,
    required this.quantity,
    required this.category,
    required this.brand,
    required this.remise,
    required this.ratings,
    required this.reviews,
    required this.flashSales,
    required this.newProduct,
    required this.bestSeller,
    required this.popular,
    required this.blackMarket,
    required this.summerSales,
  });

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        id: json["id"],
        title: json["title"],
        description: json["description"],
        price: json["price"].toDouble(),
        images: List<String>.from(json["images"].map((x) => x)),
        userId: json["userId"],
        quantity: json["quantity"],
        category: json["category"],
        brand: json["brand"],
        remise: json["remise"].toDouble(),
        ratings:
            List<Rating>.from(json["ratings"].map((x) => Rating.fromJson(x))),
        reviews:
            List<Review>.from(json["reviews"].map((x) => Review.fromJson(x))),
        flashSales: json["flashSales"],
        newProduct: json["newProduct"],
        bestSeller: json["bestSeller"],
        popular: json["popular"],
        blackMarket: json["blackMarket"],
        summerSales: json["summerSales"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "description": description,
        "price": price,
        "images": List<dynamic>.from(images.map((x) => x)),
        "userId": userId,
        "quantity": quantity,
        "category": category,
        "brand": brand,
        "remise": remise,
        "ratings": List<dynamic>.from(ratings.map((x) => x.toJson())),
        "reviews": List<dynamic>.from(reviews.map((x) => x.toJson())),
        "flashSales": flashSales,
        "newProduct": newProduct,
        "bestSeller": bestSeller,
        "popular": popular,
        "blackMarket": blackMarket,
        "summerSales": summerSales,
      };

  Product copyWith({
    String? id,
    String? title,
    String? description,
    double? price,
    List<String>? images,
    String? userId,
    int? quantity,
    String? category,
    String? brand,
    double? remise,
    List<Rating>? ratings,
    List<Review>? reviews,
    bool? flashSales,
    bool? newProduct,
    bool? bestSeller,
    bool? popular,
    bool? blackMarket,
    bool? summerSales,
  }) {
    return Product(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      price: price ?? this.price,
      images: images ?? this.images,
      userId: userId ?? this.userId,
      quantity: quantity ?? this.quantity,
      category: category ?? this.category,
      brand: brand ?? this.brand,
      remise: remise ?? this.remise,
      ratings: ratings ?? this.ratings,
      reviews: reviews ?? this.reviews,
      flashSales: flashSales ?? this.flashSales,
      newProduct: newProduct ?? this.newProduct,
      bestSeller: bestSeller ?? this.bestSeller,
      popular: popular ?? this.popular,
      blackMarket: blackMarket ?? this.blackMarket,
      summerSales: summerSales ?? this.summerSales,
    );
  }
}
