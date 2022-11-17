// import 'package:flutter/material.dart';

// import '../../models/book.dart';

// class BookDetailScreen extends StatelessWidget {
//   static const routeName = '/book-detail';
//   const BookDetailScreen(
//     this.book, {
//     super.key,
//   });

//   final Book book;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(book.title),
//       ),
//       body: SingleChildScrollView(
//         child: Column(
//           children: <Widget>[
//             SizedBox(
//               height: 300,
//               width: double.infinity,
//               child: Image.network(
//                 book.imageUrl,
//                 fit: BoxFit.cover,
//               ),
//             ),
//             const SizedBox(height: 10),
//             Text(
//               'Số trang: ${book.volumnCount}',
//               style: const TextStyle(
//                 color: Colors.grey,
//                 fontSize: 20,
//               ),
//             ),
//             Text(
//               '${book.title}',
//               textAlign: TextAlign.center,
//               style: const TextStyle(
//                 color: Colors.green,
//                 fontSize: 20,
//               ),
//             ),
//             const SizedBox(
//               height: 10,
//             ),
//             Container(
//               padding: const EdgeInsets.symmetric(horizontal: 10),
//               width: double.infinity,
//               child: Text(
//                 book.description,
//                 textAlign: TextAlign.center,
//                 softWrap: true,
//               ),
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';

import '../../models/book.dart';

class BookDetailScreen extends StatelessWidget {
  static const routeName = '/book-detail';
  const BookDetailScreen(
    this.book, {
    super.key,
  });

  final Book book;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(book.title),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 300,
              width: double.infinity,
              child: Image.network(
                book.imageUrl,
                fit: BoxFit.cover,
              ),
            ),
            Text(
              '${book.title}',
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.green,
                fontSize: 20,
              ),
            ),
            Text(
              '${book.author}',
              textAlign: TextAlign.center,
            ),
            Text(
              '${book.genres}',
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 10),
            Text(
              'Số trang: ${book.volumnCount}',
              style: const TextStyle(
                color: Colors.grey,
                fontSize: 20,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              width: double.infinity,
              child: Text(
                book.description,
                textAlign: TextAlign.center,
                softWrap: true,
              ),
            ),
            const SizedBox(height: 10),
            SizedBox(
              height: 300,
              width: double.infinity,
              child: Image.network(
                book.imageUrl1,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 10),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              width: double.infinity,
              child: Text(
                book.description1,
                textAlign: TextAlign.center,
                softWrap: true,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
