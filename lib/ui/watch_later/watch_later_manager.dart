import 'package:reviewbooks/models/book.dart';
import '../../models/watch_later_item.dart';
import 'package:flutter/foundation.dart';

class WatchLaterManager with ChangeNotifier {
  Map<String, WatchLaterItem> _items = {};

  int get bookCount {
    return _items.length;
  }

  List<WatchLaterItem> get books {
    return _items.values.toList();
  }

  Iterable<MapEntry<String, WatchLaterItem>> get bookEntries {
    return {..._items}.entries;
  }

  void addItem(Book book) {
    if (_items.containsKey(book.id)) {
      // change volumnCount...
      _items.update(
        book.id!,
        (existingWatchLaterItem) => existingWatchLaterItem.copyWith(
          quantity: existingWatchLaterItem.quantity + 1,
        ),
      );
      // bookCount();
    } else {
      _items.putIfAbsent(
        book.id!,
        () => WatchLaterItem(
          id: 'c${DateTime.now().toIso8601String()}',
          title: book.title,
          quantity: 1,
          imageUrl: book.imageUrl,
        ),
      );
    }
    notifyListeners();
  }

  void removeItem(String bookId) {
    _items.remove(bookId);
    notifyListeners();
  }

  void removeSingleItem(String bookId) {
    if (!_items.containsKey(bookId)) {
      return;
    }
    if (_items[bookId]?.quantity as num > 1) {
      _items.update(
        bookId,
        (existingWatchLaterItem) => existingWatchLaterItem.copyWith(
          quantity: existingWatchLaterItem.quantity - 1,
        ),
      );
    } else {
      _items.remove(bookId);
    }
    notifyListeners();
  }

  void clear() {
    _items = {};
    notifyListeners();
  }
}
