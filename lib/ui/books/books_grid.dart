import 'package:flutter/material.dart';
import 'package:myshop/ui/books/books_manager.dart';
import 'package:myshop/models/book.dart';
import 'book_grid_tile.dart';
// import 'books_manager.dart';
// import '../../models/book.dart';
// import 'package:flutter/foundation.dart';
import 'package:provider/provider.dart';

class BooksGrid extends StatelessWidget {
  final bool showFavorites;

  const BooksGrid(this.showFavorites, {super.key});

  @override
  Widget build(BuildContext context) {
    // Doc ra danh sach cac Book se duoc hien thi tu BooksManager
    final booksManager = BooksManager();
    // final books =
    //     showFavorites ? booksManager.favoriteItems : booksManager.items;
    final books = context.select<BooksManager, List<Book>>((booksManager) =>
        showFavorites ? booksManager.favoriteItems : booksManager.items);
    return GridView.builder(
      padding: const EdgeInsets.all(10.0),
      itemCount: books.length,
      itemBuilder: (ctx, i) => BookGridTile(books[i]),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 3 / 4,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
    );
  }
}
