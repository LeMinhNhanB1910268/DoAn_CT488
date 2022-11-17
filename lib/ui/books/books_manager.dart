import '../../models/book.dart';
import 'package:flutter/foundation.dart';
import '../../models/auth_token.dart';
import '../../services/books_service.dart';

class BooksManager with ChangeNotifier {
  List<Book> _items = [];
  final BooksService _booksService;
  BooksManager([AuthToken? authToken])
      : _booksService = BooksService(authToken);

  get book => null;

  set authToken(AuthToken? authToken) {
    _booksService.authToken = authToken;
  }

  Future<void> fetchBooks([bool filterByUser = false]) async {
    _items = await _booksService.fetchBooks(filterByUser);
    notifyListeners();
  }

  Future<void> addBook(Book book) async {
    final newBook = await _booksService.addBook(book);
    if (newBook != null) {
      _items.add(newBook);
      notifyListeners();
    }
  }

  Future<void> updateBook(Book book) async {
    final index = _items.indexWhere((item) => item.id == book.id);
    if (index >= 0) {
      if (await _booksService.updateBook(book)) {
        _items[index] = book;
        notifyListeners();
      }
    }
  }

  Future<void> deleteBook(String id) async {
    final index = _items.indexWhere((item) => item.id == id);
    Book? existingBook = _items[index];
    _items.removeAt(index);
    notifyListeners();

    if (!await _booksService.deleteBook(id)) {
      _items.insert(index, existingBook);
      notifyListeners();
    }
  }

  Future<void> toggleFavoriteStatus(Book book) async {
    final savedStatus = book.isFavorite;
    book.isFavorite = !savedStatus;
    if (!await _booksService.saveFavoriteStatus(book)) {
      book.isFavorite = savedStatus;
    }
  }

  int get itemCount {
    return _items.length;
  }

  List<Book> get items {
    return [..._items];
  }

  List<Book> get favoriteItems {
    return _items.where((prodItem) => prodItem.isFavorite).toList();
  }

  Book findById(String id) {
    return _items.firstWhere((prod) => prod.id == id);
  }
}
