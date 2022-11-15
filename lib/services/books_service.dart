import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/book.dart';
import '../models/auth_token.dart';

import 'firebase_service.dart';

class BooksService extends FirebaseService {
  BooksService([AuthToken? authToken]) : super(authToken);

  Future<List<Book>> fetchBooks([bool filterByUser = false]) async {
    final List<Book> books = [];

    try {
      final filters =
          filterByUser ? 'orderBy="creatorId"&equalTo="$userId"' : '';
      final booksUrl =
          Uri.parse('$databaseUrl/books.json?auth=$token&$filters');
      final response = await http.get(booksUrl);
      final booksMap = json.decode(response.body) as Map<String, dynamic>;

      if (response.statusCode != 200) {
        print(booksMap['error']);
        return books;
      }

      final userFavoritesUrl =
          Uri.parse('$databaseUrl/userFavorites/$userId.json?auth=$token');

      final userFavoritesResponse = await http.get(userFavoritesUrl);
      final userFavoritesMap = json.decode(userFavoritesResponse.body);

      booksMap.forEach((bookId, book) {
        final isFavorite = (userFavoritesMap == null)
            ? false
            : (userFavoritesMap[bookId] ?? false);
        books.add(
          Book.fromJson({
            'id': bookId,
            ...book,
          }).copyWith(isFavorite: isFavorite),
        );
      });
      return books;
    } catch (error) {
      print(error);
      return books;
    }
  }

  // Add Book
  Future<Book?> addBook(Book book) async {
    try {
      final url = Uri.parse('$databaseUrl/books.json?auth=$token');
      final response = await http.post(
        url,
        body: json.encode(
          book.toJson()
            ..addAll({
              'creatorId': userId,
            }),
        ),
      );

      if (response.statusCode != 200) {
        throw Exception(json.decode(response.body)['error']);
      }

      return book.copyWith(
        id: json.decode(response.body)['name'],
      );
    } catch (error) {
      print(error);
      return null;
    }
  }

  // Update Book
  Future<bool> updateBook(Book book) async {
    try {
      final url =
          Uri.parse('$databaseUrl/books/${book.id}.json?auth=$token');
      final response = await http.patch(
        url,
        body: json.encode(book.toJson()),
      );

      if (response.statusCode != 200) {
        throw Exception(json.decode(response.body)['error']);
      }

      return true;
    } catch (error) {
      print(error);
      return false;
    }
  }

  // Delete Book
  Future<bool> deleteBook(String id) async {
    try {
      final url = Uri.parse('$databaseUrl/books/$id.json?auth=$token');
      final response = await http.delete(url);

      if (response.statusCode != 200) {
        throw Exception(json.decode(response.body)['error']);
      }

      return true;
    } catch (error) {
      print(error);
      return false;
    }
  }

  // Favorite Book
  Future<bool> saveFavoriteStatus(Book book) async {
    try {
      final url = Uri.parse(
          '$databaseUrl/userFavorites/$userId/${book.id}.json?auth=$token');
      final response = await http.put(
        url,
        body: json.encode(
          book.isFavorite,
        ),
      );
      if (response.statusCode != 200) {
        throw Exception(json.decode(response.body)['error']);
      }
      return true;
    } catch (error) {
      print(error);
      return false;
    }
  }
}
