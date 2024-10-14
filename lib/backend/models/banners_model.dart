class BannerModel {
  final String image;
  final String title;

  BannerModel({
    required this.image,
    required this.title,
  });

  Map<String, dynamic> toJson() {
    return {
      'image': image,
      'title': title,
    };
  }

  factory BannerModel.fromJson(Map<String, dynamic> json) {
    return BannerModel(
      image: json['image'] as String,
      title: json['title'] as String,
    );
  }
}
