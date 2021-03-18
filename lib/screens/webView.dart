import 'dart:io';

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewPage extends StatefulWidget {
  final appBarTitle;
  final webViewLink;

  const WebViewPage({Key key, this.appBarTitle, this.webViewLink})
      : super(key: key);

  @override
  _WebViewPageState createState() => _WebViewPageState();
}

class _WebViewPageState extends State<WebViewPage> {
  @override
  void initState() {
    super.initState();
    // Enable hybrid composition.
    if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();
  }

  WebViewController webViewController;
  bool isLoaded = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.appBarTitle),
      ),
      body: Container(
        child: Stack(children: [
          WebView(
            onPageStarted: (c) {
              setState(() {
                isLoaded = false;
              });
            },
            onPageFinished: (c) {
              setState(() {
                isLoaded = true;
              });
            },
            initialUrl: widget.webViewLink,
            javascriptMode: JavascriptMode.unrestricted,
          ),
          !isLoaded ? Center(child: CircularProgressIndicator()) : Container()
        ]),
      ),
    );
  }
}
