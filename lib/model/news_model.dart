class NewsModel {
  late String newsTitle;
  late String newsDes;
  late String newsUrl;
  late String newsImg;
  late String newsAuthor;
  late String newsDate;
  late String newsContent;

  NewsModel({
    this.newsTitle = "Title",
    this.newsDes = "Description",
    this.newsUrl = "Url",
    this.newsImg = "Img",
    this.newsAuthor = "Author",
    this.newsDate = "Date",
    this.newsContent = "Description"
  });

  factory NewsModel.fromMap(Map news) {
    return NewsModel(
      newsTitle: news["title"] ?? "",
      newsDes: news["description"]?? "",
      newsImg: news["urlToImage"]?? "",
      newsUrl: news["url"]?? "",
      newsAuthor: news["author"]?? "",
      newsDate: news["publishedAt"]?? "",
      newsContent: news["content"]?? "",
    );
  }

}
