import 'package:shop/src/models/rating.dart';

class Review {
  final String userId;
  final String productId;
  final String comment;
  final String date;
  final String userName;
  final String userAvatar;
  final Rating rating;

  Review(this.userId, this.productId, this.comment, this.date, this.userName,
      this.userAvatar, this.rating);

  factory Review.fromJson(Map<String, dynamic> json) => Review(
        json["userId"],
        json["productId"],
        json["comment"],
        json["date"],
        json["userName"],
        json["userAvatar"],
        Rating.fromJson(json["rating"]),
      );

  Map<String, dynamic> toJson() => {
        "userId": userId,
        "productId": productId,
        "comment": comment,
        "date": date,
        "userName": userName,
        "userAvatar": userAvatar,
        "rating": rating.toJson(),
      };
}
