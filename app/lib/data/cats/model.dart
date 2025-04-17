import 'package:app/domain/entities/cat.dart';

class CatModel {
  final String imageUrl;
  final String id;
  final String origin;
  final String lifeSpan;
  final String temperament;
  final String breed;
  final String description;

  const CatModel({
    required this.imageUrl,
    required this.id,
    required this.origin,
    required this.lifeSpan,
    required this.temperament,
    required this.breed,
    required this.description,
  });

  factory CatModel.fromJson(Map<String, dynamic> json) {
    return switch (json) {
      {'url': String url, 'id': String id, 'breeds': List<dynamic> breeds} =>
        CatModel(
          imageUrl: url,
          id: id,
          origin: breeds[0]["origin"] as String,
          lifeSpan: breeds[0]["life_span"] as String,
          temperament: breeds[0]["temperament"] as String,
          breed: breeds[0]["name"] as String,
          description: breeds[0]['description'],
        ),
      _ => throw const FormatException('Failed to parse cat model.'),
    };
  }

  Cat getCat() {
    return Cat(
      imageUrl: imageUrl,
      origin: origin,
      lifeSpan: lifeSpan,
      temperament: temperament,
      breed: breed,
      description: description,
    );
  }
}
