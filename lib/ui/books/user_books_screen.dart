import 'package:flutter/material.dart';

import 'user_book_list_tile.dart';
import 'books_manager.dart';
import '../shared/app_drawer.dart';
// import '../../models/book.dart';
// import 'package:flutter/foundation.dart';
import 'package:provider/provider.dart';

import '../books/edit_book_screen.dart';

class UserBooksScreen extends StatelessWidget {
  static const routeName = '/user-books';
  const UserBooksScreen({super.key});

  Future<void> _refreshBooks(BuildContext context) async {
    await context.read<BooksManager>().fetchBooks(true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Books'),
        actions: <Widget>[
          buildAddButton(context),
        ],
      ),
      drawer: const AppDrawer(),
      body: FutureBuilder(
        future: _refreshBooks(context),
        builder: (ctx, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return RefreshIndicator(
            onRefresh: () => _refreshBooks(context),
            child: buildUserBookListView(),
          );
        },
      ),
    );
  }

  Widget buildUserBookListView() {
    return Consumer<BooksManager>(
      builder: (ctx, booksManager, child) {
        return ListView.builder(
          itemCount: booksManager.itemCount,
          itemBuilder: (ctx, i) => Column(
            children: [
              UserBookListTile(
                booksManager.items[i],
              ),
              const Divider(),
            ],
          ),
        );
      },
    );
  }

  Widget buildAddButton(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.add),
      onPressed: () {
        Navigator.of(context).pushNamed(
          EditBookScreen.routeName,
        );
      },
    );
  }
}
