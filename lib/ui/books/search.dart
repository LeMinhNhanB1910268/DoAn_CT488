import '../../models/book.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'book_grid_tile.dart';
import 'books_manager.dart';

class SearchBook extends SearchDelegate {
  List<Book> searchTerms = [];
  @override
  // Future<void> gettitle(BuildContext context) async {}
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.close),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  // second overwrite to pop out of search menu
  @override
  Widget? buildLeading(BuildContext context) {
    final book = context
        .select<BooksManager, List<Book>>((booksManager) => booksManager.items);
    List<Book> books = [];
    // int a = booksManager.bookCount
    for (int i = 0; i < book.length; i++) {
      books += [book[i]];
    }
    searchTerms = books;
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  // third overwrite to show query result
  @override
  Widget buildResults(BuildContext context) {
    List<Book> matchQuery = [];
    for (var fruit in searchTerms) {
      if ((fruit.title.toLowerCase().contains(query.toLowerCase())) || (fruit.genres.toLowerCase().contains(query.toLowerCase())) || (fruit.author.toLowerCase().contains(query.toLowerCase()))) {
        matchQuery.add(fruit);
      }
    }
    return GridView.builder(
      padding: const EdgeInsets.all(10.0),
      itemCount: matchQuery.length,
      itemBuilder: (ctx, i) => BookGridTile(matchQuery[i]),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 3 / 4,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
    );
  }

  // last overwrite to show the
  // querying process at the runtime
  @override
  Widget buildSuggestions(BuildContext context) {
    List<Book> matchQuery = [];
    for (var fruit in searchTerms) {
      if ((fruit.title.toLowerCase().contains(query.toLowerCase())) || (fruit.genres.toLowerCase().contains(query.toLowerCase())) || (fruit.author.toLowerCase().contains(query.toLowerCase()))) {
        matchQuery.add(fruit);
      }
    }
    return GridView.builder(
      padding: const EdgeInsets.all(10.0),
      itemCount: matchQuery.length,
      itemBuilder: (ctx, i) => BookGridTile(matchQuery[i]),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 3 / 4,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
    );
  }
}
