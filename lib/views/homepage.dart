import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:provider/provider.dart';

import '../provider/provider.dart';

class WebViewScreen extends StatefulWidget {
  const WebViewScreen({Key? key}) : super(key: key);

  @override
  _WebViewScreenState createState() => _WebViewScreenState();
}

class _WebViewScreenState extends State<WebViewScreen> {
  late InAppWebViewController webViewController;

  @override
  Widget build(BuildContext context) {
    final webViewModel = Provider.of<WebViewModel>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text("Web Options"),
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: GridView.builder(
          itemCount: webViewModel.allOptions.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2, childAspectRatio: 0.9),
          itemBuilder: (context, index) {
            return InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => InAppWebViewScreen(
                      url: webViewModel.allOptions[index].webUrl,
                    ),
                  ),
                );
              },
              child: Container(
                height: 100,
                margin: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black45,
                      blurRadius: 6,
                      offset: Offset(3, 3),
                    ),
                  ],
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      webViewModel.allOptions[index].icon,
                      size: 50,
                    ),
                    SizedBox(height: 10),
                    Text(
                      webViewModel.allOptions[index].title,
                      style: TextStyle(fontSize: 16),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class InAppWebViewScreen extends StatefulWidget {
  final String url;

  const InAppWebViewScreen({Key? key, required this.url}) : super(key: key);

  @override
  _InAppWebViewScreenState createState() => _InAppWebViewScreenState();
}

class _InAppWebViewScreenState extends State<InAppWebViewScreen> {
  late InAppWebViewController webViewController;
  bool isBookmarked = false;

  // Function to bookmark the current URL
  void bookmarkPage(String url) {
    setState(() {
      isBookmarked = !isBookmarked;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(isBookmarked ? "Bookmarked!" : "Bookmark removed!"),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Web Viewer"),
        actions: [
          // Back button
          IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () async {
              if (await webViewController.canGoBack()) {
                webViewController.goBack();
              }
            },
          ),
          // Forward button
          IconButton(
            icon: Icon(Icons.arrow_forward),
            onPressed: () async {
              if (await webViewController.canGoForward()) {
                webViewController.goForward();
              }
            },
          ),
          // Refresh button
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: () {
              webViewController.reload();
            },
          ),
          // Bookmark button
          IconButton(
            icon: Icon(isBookmarked ? Icons.bookmark : Icons.bookmark_border),
            onPressed: () {
              bookmarkPage(widget.url); // Bookmark the current URL
            },
          ),
        ],
      ),
      body: InAppWebView(
        initialUrlRequest: URLRequest(url: WebUri(widget.url)),
        onWebViewCreated: (controller) {
          webViewController = controller;
        },
        onLoadStart: (controller, url) {
          print("Loading started: $url");
        },
        onLoadStop: (controller, url) {
          print("Loading stopped: $url");
        },
        onProgressChanged: (controller, progress) {
          // You can use this to show progress or a loading indicator
          print("Loading progress: $progress%");
        },
      ),
    );
  }
}
