class Cat {
  final String imageUrl;
  final String origin;
  final String lifeSpan;
  final String temperament;
  final String breed;
  final String description;

  Cat({
    required this.imageUrl,
    required this.origin,
    required this.lifeSpan,
    required this.temperament,
    required this.breed,
    required this.description,
  });
}

abstract class CatLoader {
  Future<Cat> loadCat();
}
