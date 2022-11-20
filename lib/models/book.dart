import 'package:flutter/foundation.dart';

class Book {
  final String? id;
  final String title;
  final String description;
  final String description1;
  final int volumnCount;
  final String imageUrl;
  final String imageUrl1;
  final String genres;
  final String author;
  final ValueNotifier<bool> _isFavorite;

  Book({
    this.id,
    required this.title,
    required this.description,
    required this.description1,
    required this.volumnCount,
    required this.imageUrl,
    required this.imageUrl1,
    required this.genres,
    required this.author,
    isFavorite = false,
  }) : _isFavorite = ValueNotifier(isFavorite);

  set isFavorite(bool newValue) {
    _isFavorite.value = newValue;
  }

  bool get isFavorite {
    return _isFavorite.value;
  }

  ValueNotifier<bool> get isFavoriteListenable {
    return _isFavorite;
  }

  Book copyWith({
    String? id,
    String? title,
    String? description,
    String? description1,
    int? volumnCount,
    String? imageUrl,
    String? imageUrl1,
    String? genres,
    String? author,
    bool? isFavorite,
  }) {
    return Book(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      description1: description1 ?? this.description1,
      volumnCount: volumnCount ?? this.volumnCount,
      imageUrl: imageUrl ?? this.imageUrl,
      imageUrl1: imageUrl1 ?? this.imageUrl1,
      genres: genres ?? this.genres,
      author: author ?? this.author,
      isFavorite: isFavorite ?? this.isFavorite,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'description': description,
      'description1': description1,
      'volumnCount': volumnCount,
      'imageUrl': imageUrl,
      'imageUrl1': imageUrl1,
      'genres': genres,
      'author': author,
    };
  }

  static Book fromJson(Map<String, dynamic> json) {
    return Book(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      description1: json['description1'],
      volumnCount: json['volumnCount'],
      imageUrl: json['imageUrl'],
      imageUrl1: json['imageUrl1'],
      genres: json['genres'],
      author: json['author'],
    );
  }
}
