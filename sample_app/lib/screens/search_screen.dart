import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:sample_app/models/article.dart';
import 'package:http/http.dart' as http;
import 'package:sample_app/widgets/article_container.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  List<Article> _articles = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Qiita Search',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Column(
        children: <Widget>[
          // search form
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 36),
            child: TextField(
              style: const TextStyle(color: Colors.black, fontSize: 18),
              decoration: const InputDecoration(
                hintText: 'Enter a keyword',
                hintStyle: TextStyle(color: Colors.grey),
              ),
              onSubmitted: (String keyword) async {
                final results = await searchQuiita(keyword);
                setState(() => _articles = results);
              },
            ),
          ),
          // search result
          Expanded(
            child: ListView(
              children: _articles
                  .map((article) => ArticleContainer(article: article))
                  .toList(),
            ),
          ),
        ],
      ),
    );
  }

  /// Search Qiita articles by keyword
  /// 1. prepare data for http communication
  /// 2. send http request to Qiita API
  /// 3. parse the response
  /// 4. return the result
  Future<List<Article>> searchQuiita(String keyword) async {
    // 1. prepare data for http communication
    final Uri uri = Uri.https(
      'qiita.com',
      '/api/v2/items',
      {'query': 'title:$keyword', 'per_page': '10'},
    );

    final String token = dotenv.env['QIITA_ACCESS_TOKEN'] ?? '';

    // 2. send http request to Qiita API
    final http.Response response = await http.get(
      uri,
      headers: {'Authorization': 'Bearer $token'},
    );

    // 3. parse the response
    // 4. return the result
    if (response.statusCode == 200) {
      final List<dynamic> body = jsonDecode(response.body);
      return body.map((dynamic item) => Article.fromJson(item)).toList();
    } else {
      return [];
    }
  }
}
