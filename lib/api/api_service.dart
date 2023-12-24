import 'dart:convert';

import 'package:http/http.dart' as http;

import '../model/news_model.dart';

var linkHeadlines =
    "https://newsapi.org/v2/top-headlines?country=us&apiKey=d11398bce2ae40b8abaa03e72b443518";


Future<dynamic> getNews(int index, String query) async {
  if (index == 0){
    var response = await http.get(Uri.parse(linkHeadlines));
    List data = jsonDecode(response.body)["articles"];
    List<NewsModel> news = data.map((e) => NewsModel.fromMap(e)).toList();
    return news;
  }
  else if (index == 1){
    var response = await http.get(Uri.parse("https://newsapi.org/v2/top-headlines?country=us&category=${query}&apiKey=d11398bce2ae40b8abaa03e72b443518"));
    List data = jsonDecode(response.body)["articles"];
    List<NewsModel> news = data.map((e) => NewsModel.fromMap(e)).toList();
    return news;
  }
}
