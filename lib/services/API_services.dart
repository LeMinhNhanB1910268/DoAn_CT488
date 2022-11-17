import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:myshop/models/book.dart';

class FetchBook {
  var data = [];
  List<Book> results = [];
  String fetchurl =
      "https://console.firebase.google.com/project/bookapi-9e99f/database/bookapi-9e99f-default-rtdb/";

  Future<List<Book>> getBookList({String? query}) async {
    var url = Uri.parse(fetchurl);
    var response = await http.get(url);
    try {
      if (response.statusCode == 200) {
        data = json.decode(response.body);
        results = data.map((e) => Book.fromJson(e)).toList();
        if (query != null) {
          results = results
              .where((element) =>
                  element.title.toLowerCase().contains(query.toLowerCase()))
              .toList();
        }
      } else {
        print('api error');
      }
    } on Exception catch (e) {
      print('error: $e');
    }
    return results;
  }
}
