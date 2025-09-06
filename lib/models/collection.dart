class Collection {
  final String name;
  final String description;
  final bool isPublic;
  final String? coverImage;

  Collection({
    required this.name,
    required this.description,
    required this.isPublic,
    this.coverImage,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'description': description,
      'isPublic': isPublic,
      'coverImage': coverImage,
    };
  }

  factory Collection.fromMap(Map<String, dynamic> map) {
    return Collection(
      name: map['name'] ?? '',
      description: map['description'] ?? '',
      isPublic: map['isPublic'] ?? false,
      coverImage: map['coverImage'],
    );
  }
} 