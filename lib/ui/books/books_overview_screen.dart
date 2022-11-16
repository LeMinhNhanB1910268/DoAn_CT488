import 'package:flutter/material.dart';
import 'package:myshop/ui/books/search.dart';
import 'package:myshop/ui/watch_later/watch_later_screen.dart';

import 'books_grid.dart';
import '../shared/app_drawer.dart';
import 'top_right_badge.dart';

// import '../../models/book.dart';
// import 'package:flutter/foundation.dart';
import 'package:provider/provider.dart';
import '../watch_later/watch_later_manager.dart';
import '../books/books_manager.dart';

enum FilterOptions { favorites, all }

class BooksOverviewScreen extends StatefulWidget {
  const BooksOverviewScreen({super.key});

  @override
  State<BooksOverviewScreen> createState() => _BooksOverviewScreenState();
}

class _BooksOverviewScreenState extends State<BooksOverviewScreen> {
  final _showOnlyFavorites = ValueNotifier<bool>(false);
  late Future<void> _fetchBooks;

  @override
  void initState() {
    super.initState();
    _fetchBooks = context.read<BooksManager>().fetchBooks();
  }

  // var _showOnlyFavorites = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Review Books'),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              showSearch(context: context, delegate: SearchBook());
            },
          ),
          buildBookFilterMenu(),
          buildShoppingWatchLaterIcon(),
        ],
      ),
      drawer: const AppDrawer(),
      body: FutureBuilder(
        future: _fetchBooks,
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
      ),
    );
  }

  // @override
  // Widget buildSearch(BuildContext context) {
  //   return Scaffold(
  //     appBar
  //   )
  // }
  // @override
  // List<Widget> buildActions(BuildContext context) {
  //   return [
  //     IconButton(
  //         icon: const Icon(Icons.clear),
  //         onPressed: () {
  //           query = '';
  //         })
  //   ];
  // }

  Widget buildShoppingWatchLaterIcon() {
    return Consumer<WatchLaterManager>(
      builder: (ctx, watchLaterManager, child) {
        return TopRightBadge(
          data: watchLaterManager.bookCount,
          child: IconButton(
            icon: const Icon(
              Icons.watch_later,
            ),
            onPressed: () {
              Navigator.of(ctx).pushNamed(WatchLaterScreen.routeName);
            },
          ),
        );
      },
    );
  }

  Widget buildBookFilterMenu() {
    return PopupMenuButton(
      onSelected: (FilterOptions selectedValue) {
        if (selectedValue == FilterOptions.favorites) {
          _showOnlyFavorites.value = true;
        } else {
          _showOnlyFavorites.value = false;
        }
      },
      icon: const Icon(
        Icons.more_vert,
      ),
      itemBuilder: (ctx) => [
        const PopupMenuItem(
          value: FilterOptions.favorites,
          child: Text('Only Favorites'),
        ),
        const PopupMenuItem(
          value: FilterOptions.all,
          child: Text('Show All'),
        ),
      ],
    );
  }
}

// class CustomSearch extends SearchDelegate {
//   List<String> allData = ['American', 'Russia', 'China'];
//   @override
//   List<Widget> buildActions(BuildContext context) {
//     return [
//       IconButton(
//         icon: const Icon(Icons.clear),
//         onPressed: () {
//           query = '';
//         },
//       )
//     ];
//   }

//   @override
//   Widget buildLeading(BuildContext context) {
//     return IconButton(
//         icon: const Icon(Icons.arrow_back),
//         onPressed: () {
//           close(context, null);
//         });
//   }

//   @override
//   List buildSuggestions(BuildContext context) {
//     List<String> matchQuery = [];
//     for (var item in allData) {
//       if (item.toLowerCase().contains(query.toLowerCase())) {
//         matchQuery.add(item);
//       }
//     }
//     return ListView.buildSearch(
//         itemCount: matchQuery.length,
//         itemBuilder: (context, index) {
//           var result = matchQuery[index];
//           returnListTile(
//             title: Text(result),
//           );
//         });
//   }

//   @override
//   List buildResults(BuildContext context) {
//     List<String> matchQuery = [];
//     for (var item in allData) {
//       if (item.toLowerCase().contains(query.toLowerCase())) {
//         matchQuery.add(item);
//       }
//     }
//     return ListView.builderSearch(
//         itemCount: matchQuery.length,
//         itemBuilder: (context, index) {
//           var result = matchQuery[index];
//           returnListTile(
//             title: Text(result),
//           );
//         });
//   }
// }
