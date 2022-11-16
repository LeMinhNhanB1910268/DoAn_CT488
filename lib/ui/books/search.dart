import 'package:flutter/material.dart';
import '../books/books_overview_screen.dart';
import '../../services/API_services.dart';
import '../../models/book.dart';
import 'books_grid.dart';

class SearchBook extends SearchDelegate {
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.close),
        onPressed: () {
          query = '';
        },
      )
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
        icon: Icon(Icons.arrow_back),
        onPressed: () {
          Navigator.pop(context);
        });
  }

  FetchBook _bookList = FetchBook();
  final _showOnlyFavorites = ValueNotifier<bool>(false);
  @override
  Widget buildResults(BuildContext context) {
    return FutureBuilder(
      future: _bookList.getBookList(query: query),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return ValueListenableBuilder<bool>(
              valueListenable: _showOnlyFavorites,
              builder: (context, onlyFavorites, child) {
                return BooksGrid(onlyFavorites);
              });
        }
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return Center(
      child: Text("Search Books"),
    );
  }
}
