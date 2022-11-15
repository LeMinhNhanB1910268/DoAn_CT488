import 'package:myshop/models/book.dart';
import '../../models/watch_later_item.dart';
import '../../models/book.dart';
import 'package:flutter/foundation.dart';
import 'package:provider/provider.dart';

class WatchLaterManager with ChangeNotifier {
  Map<String, WatchLaterItem> _items = {
    'p1': WatchLaterItem(
      id: 'c1',
      title: 'Red Shirt',
      volumnCount: 29,
      imageUrl: 'https://media.vov.vn/sites/default/files/styles/large/public/2021-08/man_city_0.jpg',
    ),
  };

  int get bookCount {
    return _items.length;
  }

  List<WatchLaterItem> get books {
    return _items.values.toList();
  }

  Iterable<MapEntry<String, WatchLaterItem>> get bookEntries {
    return {..._items}.entries;
  }

  // double get totalAmount {
  //   var total = 0.0;
  //   _items.forEach((key, WatchLaterItem) {
  //     total += cartItem.imageUrl * cartItem.volumnCount;
  //   });
  //   return total;
  // }

  void addItem(Book book) {
    if (_items.containsKey(book.id)) {
      // change volumnCount...
      _items.update(
        book.id!,
        (existingWatchLaterItem) => existingWatchLaterItem.copyWith(
          volumnCount: existingWatchLaterItem.volumnCount + 1,
        ),
      );
    } else {
      _items.putIfAbsent(
        book.id!,
        () => WatchLaterItem(
          id: 'c${DateTime.now().toIso8601String()}',
          title: book.title,
          imageUrl: book.imageUrl,
          volumnCount: 1,
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
    if (_items[bookId]?.volumnCount as num > 1) {
      _items.update(
        bookId,
        (existingWatchLaterItem) => existingWatchLaterItem.copyWith(
          volumnCount: existingWatchLaterItem.volumnCount - 1,
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
