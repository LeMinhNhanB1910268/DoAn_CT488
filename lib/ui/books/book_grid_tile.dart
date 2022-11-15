import 'package:flutter/material.dart';
import '../../models/book.dart';
import 'book_detail_screen.dart';

import '../../models/book.dart';
import 'package:flutter/foundation.dart';
import 'package:provider/provider.dart';
import '../watch_later/watch_later_manager.dart';
import '../books/books_manager.dart';

class BookGridTile extends StatelessWidget {
  const BookGridTile(
    this.book, {
    super.key,
  });

  final Book book;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: GridTile(
        footer: buildGridFooterBar(context),
        child: GestureDetector(
          onTap: () {
            Navigator.of(context).pushNamed(
              BookDetailScreen.routeName,
              arguments: book.id,
            );
          },
          child: Image.network(
            book.imageUrl,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }

  Widget buildGridFooterBar(BuildContext context) {
    return GridTileBar(
      backgroundColor: Colors.black87,
      leading: ValueListenableBuilder<bool>(
        valueListenable: book.isFavoriteListenable,
        builder: (ctx, isFavorite, child) {
          return IconButton(
            icon: Icon(
              isFavorite ? Icons.favorite : Icons.favorite_border,
            ),
            color: Theme.of(context).colorScheme.secondary,
            onPressed: () {
              // book.isFavorite = !isFavorite;
              ctx.read<BooksManager>().toggleFavoriteStatus(book);
            },
          );
        },
      ),
      title: Text(
        book.title,
        textAlign: TextAlign.center,
      ),
      trailing: IconButton(
        icon: const Icon(
          Icons.shopping_cart,
        ),
        onPressed: () {
          final cart = context.read<WatchLaterManager>();
          cart.addItem(book);
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                content: const Text(
                  'Item added to list',
                ),
                duration: const Duration(seconds: 2),
                action: SnackBarAction(
                  label: 'UNDO',
                  onPressed: () {
                    cart.removeSingleItem(book.id!);
                  },
                ),
              ),
            );
          // print('Add item to cart');
        },
        color: Theme.of(context).colorScheme.secondary,
      ),
    );
  }
}
