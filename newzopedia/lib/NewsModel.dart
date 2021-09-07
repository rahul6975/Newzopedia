import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'dart:async';

class ArticleNews extends StatefulWidget {
  final newsUrl;

  const ArticleNews({this.newsUrl});

  @override
  _ArticleNewsState createState() => _ArticleNewsState();
}

class _ArticleNewsState extends State<ArticleNews> {
  final Completer<WebViewController> _completer =
      Completer<WebViewController>();
  late bool _isLoadingPage;

  @override
  void initState() {
    super.initState();
    _isLoadingPage = true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(centerTitle: true, title: Text("News")),
      body: Container(
        child: Stack(
          children: [
            WebView(
              initialUrl: widget.newsUrl,
              javascriptMode: JavascriptMode.unrestricted,
              onWebViewCreated: (controller) {
                _completer.complete(controller);
              },
              onPageFinished: (finish) =>
                  setState(() => _isLoadingPage = false),
            ),
            _isLoadingPage
                ? Container(
                    alignment: FractionalOffset.center,
                    child: CircularProgressIndicator(),
                  )
                : Container(),
          ],
        ),
      ),
    );
  }
}
