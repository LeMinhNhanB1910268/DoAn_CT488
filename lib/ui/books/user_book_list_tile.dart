import 'package:flutter/material.dart';
import 'package:myshop/ui/books/books_manager.dart';

import '../../models/book.dart';
// import 'package:flutter/foundation.dart';
import 'package:provider/provider.dart';

import '../books/edit_book_screen.dart';

class UserBookListTile extends StatelessWidget {
  final Book book;

  const UserBookListTile(
    this.book, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(book.title),
      leading: CircleAvatar(
        backgroundImage: NetworkImage(book.imageUrl),
      ),
      trailing: SizedBox(
        width: 100,
        child: Row(
          children: <Widget>[
            buildEditButton(context),
            buildDeleteButton(context),
          ],
        ),
      ),
    );
  }

  Widget buildDeleteButton(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.delete),
      onPressed: () async {
        context.read<BooksManager>().deleteBook(book.id!);
        ScaffoldMessenger.of(context)
          ..hideCurrentSnackBar()
          ..showSnackBar(
            const SnackBar(
              content: Text(
                'book deleted',
                textAlign: TextAlign.center,
              ),
            ),
          );
      },
      color: Theme.of(context).errorColor,
    );
  }

  Widget buildEditButton(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.edit),
      onPressed: () {
        Navigator.of(context).pushNamed(
          EditBookScreen.routeName,
          arguments: book.id,
        );
      },
      color: Theme.of(context).primaryColor,
    );
  }
}
