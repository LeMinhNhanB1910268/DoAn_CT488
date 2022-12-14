import 'package:flutter/material.dart';

import 'watch_later_manager.dart';
import 'item_card.dart';

import 'package:provider/provider.dart';

class WatchLaterScreen extends StatelessWidget {
  static const routeName = '/watch_later';

  const WatchLaterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final watch_later = context.watch<WatchLaterManager>();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Watch Later'),
      ),
      body: Column(
        children: <Widget>[
          buildWatchLaterSummary(watch_later, context),
          const SizedBox(height: 10),
          Expanded(
            child: buildWatchLaterDetails(watch_later),
          )
        ],
      ),
    );
  }

  Widget buildWatchLaterDetails(WatchLaterManager watch_later) {
    return ListView(
      children: watch_later.bookEntries
          .map(
            (entry) => WatchLaterItemCard(
              bookId: entry.key,
              cardItem: entry.value,
            ),
          )
          .toList(),
    );
  }

  Widget buildWatchLaterSummary(
      WatchLaterManager watch_later, BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(15),
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            const Text(
              'Watch Later List:',
              style: TextStyle(fontSize: 20),
            ),
            const Spacer(),
            Chip(
              label: Text(
                '${watch_later.bookCount}',
                style: TextStyle(fontSize: 20),
              ),
              backgroundColor: Theme.of(context).canvasColor,
            ),
          ],
        ),
      ),
    );
  }
}
