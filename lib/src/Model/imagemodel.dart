
class ImageModel{
  final String id;
  final String name;
  final String user;
  final String image;

  ImageModel({required this.id,required this.name,required this.user,required this.image});

 factory ImageModel.fromJson(Map<String, dynamic> json) {
  return ImageModel(
    id: json['_id'] ?? '', // Provide default values if necessary
    name: json['name'] ?? '',
    user: json['user'] ?? '',
    image: json['image'] ?? '',
  );
}
}