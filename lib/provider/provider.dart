import 'package:flutter/material.dart';

class WebServiceModel {
  final String title;
  final String webUrl;
  final IconData icon;

  WebServiceModel(
      {required this.title, required this.webUrl, required this.icon});
}

class WebViewModel with ChangeNotifier {
  String currentUrl = 'https://flutter.dev';
  bool isConnected = false;
  double progressValue = 0.0;
  bool isBookmarked = false;
  List<WebServiceModel> allOptions = [
    WebServiceModel(
        title: 'Flutter',
        webUrl: 'https://flutter.dev',
        icon: Icons.flutter_dash),
    WebServiceModel(
        title: 'Google', webUrl: 'https://www.google.com', icon: Icons.search),
    WebServiceModel(
        title: 'wikipidia ',
        webUrl: "https://www.wikipedia.org/",
        icon: Icons.wordpress),
    WebServiceModel(
        title: 'GitHub', webUrl: 'https://github.com', icon: Icons.code),
  ];

  void updateUrl(String newUrl) {
    currentUrl = newUrl;
    https: //www.wikipedia.org/
    notifyListeners();
  }

  void changeProgressValue(double value) {
    progressValue = value;
    notifyListeners();
  }

  void toggleBookmark(String url) {
    if (currentUrl == url) {
      isBookmarked = !isBookmarked;
      notifyListeners();
    }
  }

  List<WebServiceModel> getAllOptions() {
    return allOptions;
  }
}
