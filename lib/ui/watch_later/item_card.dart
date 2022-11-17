import 'package:flutter/material.dart';

import '../../models/watch_later_item.dart';
import '../books/book_detail_screen.dart';
import '../shared/dialog_utils.dart';

import 'package:provider/provider.dart';
import '../../ui/watch_later/watch_later_manager.dart';

class WatchLaterItemCard extends StatelessWidget {
  final String bookId;
  final WatchLaterItem cardItem;

  const WatchLaterItemCard({
    required this.bookId,
    required this.cardItem,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: ValueKey(cardItem.id),
      background: Container(
        color: Theme.of(context).errorColor,
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 20),
        margin: const EdgeInsets.symmetric(
          horizontal: 15,
          vertical: 4,
        ),
        child: const Icon(
          Icons.delete,
          color: Colors.white,
          size: 40,
        ),
      ),
      direction: DismissDirection.endToStart,
      confirmDismiss: (direction) {
        return showConfirmDialog(
          context,
          'Do you want to remove the item from the Watch Later?',
        );
      },
      onDismissed: (direction) {
        context.read<WatchLaterManager>().removeItem(bookId);
      },
      child: buildItemCard(context),
    );
  }

  Widget buildItemCard(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(
        horizontal: 15,
        vertical: 4,
      ),
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: ListTile(
          onTap: () {
            Navigator.of(context).pushNamed(
              BookDetailScreen.routeName,
              arguments: bookId,
            );
          },
          leading: Image(
            image: NetworkImage(cardItem.imageUrl),
          ),
          title: Text(cardItem.title),
        ),
      ),
    );
  }
}
