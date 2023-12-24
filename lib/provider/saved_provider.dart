import 'package:flutter/material.dart';

import '../api/api_service.dart';
import '../model/news_model.dart';

class SavedProvider extends ChangeNotifier{
  List<NewsModel> newsList = <NewsModel>[];
  List<NewsModel> savedNewsList = <NewsModel>[];



  savedNews(NewsModel news){
    savedNewsList.add(news);
    notifyListeners();
  }
}