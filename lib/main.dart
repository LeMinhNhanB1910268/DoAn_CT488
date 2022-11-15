import 'package:flutter/material.dart';
import 'ui/books/books_manager.dart';
import 'ui/books/book_detail_screen.dart';
import 'ui/books/books_overview_screen.dart';
import 'ui/books/user_books_screen.dart';
import 'ui/watch_later/watch_later_screen.dart';
import 'package:flutter/foundation.dart';
import 'package:provider/provider.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'ui/screens.dart';

Future<void> main() async {
  // (1) Load the .env file
  await dotenv.load();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        // (2) Create and provide AuthManager
        ChangeNotifierProvider(
          create: (context) => AuthManager(),
        ),
        ChangeNotifierProvider(
          create: (ctx) => WatchLaterManager(),
        ),
        // ChangeNotifierProvider(
        //   create: (ctx) => OrdersManager(),
        // ),
        // ChangeNotifierProvider(
        //   create: (ctx) => booksManager(),
        // ),
        ChangeNotifierProxyProvider<AuthManager, BooksManager>(
          create: (ctx) => BooksManager(),
          update: (ctx, authManager, booksManager) {
            // Khi authManager co bao hieu thay doi thi doc lai authToken cho booksManager
            booksManager!.authToken = authManager.authToken;
            return booksManager;
          },
        )
      ],
      // (3) Consume the AuthManager instance
      child: Consumer<AuthManager>(
        builder: (ctx, authManager, child) {
          return MaterialApp(
            title: 'Review Books',
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              fontFamily: "Lato",
              colorScheme: ColorScheme.fromSwatch(
                primarySwatch: Colors.green,
              ).copyWith(
                secondary: Colors.deepOrange,
              ),
            ),
            home: authManager.isAuth
                ? const BooksOverviewScreen()
                : FutureBuilder(
                    future: authManager.tryAutoLogin(),
                    builder: (ctx, snapshot) {
                      return snapshot.connectionState == ConnectionState.waiting
                          ? const SplashScreen()
                          : const AuthScreen();
                    },
                  ),
            routes: {
              WatchLaterScreen.routeName: (ctx) => const WatchLaterScreen(),
              // OrdersScreen.routeName: (ctx) => const OrdersScreen(),
              UserBooksScreen.routeName: (ctx) => const UserBooksScreen(),
            },
            onGenerateRoute: (settings) {
              if (settings.name == BookDetailScreen.routeName) {
                final bookId = settings.arguments as String;
                return MaterialPageRoute(
                  builder: (ctx) {
                    return BookDetailScreen(
                      ctx.read<BooksManager>().findById(bookId),
                    );
                  },
                );
              }
              if (settings.name == EditBookScreen.routeName) {
                final bookId = settings.arguments as String?;
                return MaterialPageRoute(
                  builder: (ctx) {
                    return EditBookScreen(
                      bookId != null
                          ? ctx.read<BooksManager>().findById(bookId)
                          : null,
                    );
                  },
                );
              }

              return null;
            },
          );
        },
      ),
    );
  }
}
