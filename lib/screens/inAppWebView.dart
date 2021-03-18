import 'package:flutter/material.dart';

import 'package:flutter_inappwebview/flutter_inappwebview.dart';

import 'package:url_launcher/url_launcher.dart';

class InAppWebViewx extends StatefulWidget {
  final url;
  final title;

  const InAppWebViewx({Key key, this.url, this.title}) : super(key: key);
  @override
  _MyAppState createState() => new _MyAppState();
}

class _MyAppState extends State<InAppWebViewx> {
  InAppWebViewController webView;
  String url = "";
  double progress = 0;
  bool isLoading = true;
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          isLoading
              ? Center(
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: CircularProgressIndicator(
                      valueColor:
                          new AlwaysStoppedAnimation<Color>(Colors.white),
                    ),
                  ),
                )
              : Container()
        ],
      ),
      body: Stack(
        children: [
          isLoading
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : Container(),
          Column(children: <Widget>[
            Expanded(
                child: InAppWebView(
              initialUrl: widget.url,
              initialHeaders: {},
              initialOptions: InAppWebViewGroupOptions(
                crossPlatform: InAppWebViewOptions(
                    debuggingEnabled: true, useOnDownloadStart: true),
              ),
              onWebViewCreated: (InAppWebViewController controller) {
                webView = controller;
              },
              onLoadStart: (InAppWebViewController controller, String url) {
                setState(() {
                  isLoading = true;
                });
              },
              onLoadStop: (InAppWebViewController controller, String url) {
                setState(() {
                  isLoading = false;
                });
              },
              onDownloadStart: (controller, url) async {
                print("onDownloadStart $url");
                print("onDownloadStart $url");
                if (await canLaunch(url)) {
                  await launch(url);
                } else {
                  throw 'Could not launch $url';
                }
              },
              onProgressChanged:
                  (InAppWebViewController controller, int progress) {
                setState(() {
                  webView.injectCSSCode(
                      source:
                          """.menu, #header, #HeaderMain1_topLinks, footer, .topLinks, .footerBottom {
             display:none;
             visibility: hidden;
}""");
                  // 100;
                });
              },
            )),
          ]),
        ],
      ),
    );
  }
}
