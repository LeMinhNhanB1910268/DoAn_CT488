import 'package:flutter/material.dart';
import 'package:reviewbooks/ui/books/books_manager.dart';
import 'package:reviewbooks/models/book.dart';
import 'book_grid_tile.dart';
import 'package:provider/provider.dart';

class BooksGrid extends StatelessWidget {
  final bool showFavorites;

  const BooksGrid(this.showFavorites, {super.key});

  @override
  Widget build(BuildContext context) {
    // Doc ra danh sach cac Book se duoc hien thi tu BooksManager
    final booksManager = BooksManager();
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
