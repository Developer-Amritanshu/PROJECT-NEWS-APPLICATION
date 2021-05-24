import 'dart:async';

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class ArticleView extends StatefulWidget {
  final String blogUrl;
  ArticleView({this.blogUrl});
  @override
  _ArticleViewState createState() => _ArticleViewState();
}

class _ArticleViewState extends State<ArticleView> {
  final Completer<WebViewController> _completer =
      Completer<WebViewController>();

        num position = 1 ;
 
  final key = UniqueKey();
 
  doneLoading(String A) {
    setState(() {
      position = 0;
    });
  }
 
  startLoading(String A){
    setState(() {
      position = 1;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Original",
            ),
            Text(
              " News ",
              style: TextStyle(color: Colors.green),
            ),
            Icon(Icons.verified,size: 20,color: Colors.blue,),
          ],
        ),
        actions: [
          Opacity(opacity: 0,
          child: Container(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Icon(Icons.save),
          ),
          )
        ],
        elevation: 0.0,
      ),
      body:IndexedStack(
        index: position,
            children: [
              WebView(
          onPageFinished: doneLoading,
          onPageStarted: startLoading,
          key: key,
          initialUrl: widget.blogUrl,
          onWebViewCreated: ((WebViewController webViewController) {
            _completer.complete(webViewController);
          }),
        ),
        Container(
        color: Colors.white,
        child: Center(
          child: CircularProgressIndicator()),
        ),
              
            ],
      ),
    );
  }
}
