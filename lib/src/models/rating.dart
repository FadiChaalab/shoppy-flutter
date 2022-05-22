class Rating {
  final String id;
  final double rating;

  Rating(this.id, this.rating);

  factory Rating.fromJson(Map<String, dynamic> json) => Rating(
        json["id"],
        json["rating"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "rating": rating,
      };
}
