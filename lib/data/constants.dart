class Constants {

  static String getUrl(int value) {
    switch (value) {
      case 1:
        return url_1;
      case 2:
        return url_2;
      default:
        return url_1;
    }
  }

  static String url_1 =
      "https://newsapi.org/v2/everything?q=bitcoin&apiKey=ea58907aae9648f09c4d508caefbe124";
  static String url_2 =
      "https://newsapi.org/v2/top-headlines?sources=abc-news&apiKey=ea58907aae9648f09c4d508caefbe124";
}
