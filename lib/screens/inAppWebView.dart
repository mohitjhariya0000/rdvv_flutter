import 'dart:async';

import 'package:firebase_admob/firebase_admob.dart';
import 'package:flutter/material.dart';

import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:flutter_native_admob/flutter_native_admob.dart';
import 'package:flutter_native_admob/native_admob_controller.dart';

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

  //*----------------Natvie Ads Implementation code  -------------------------

  InterstitialAd _interstitialAd;
  @override
  void initState() {
    _subscription = _nativeAdController.stateChanged.listen(_onStateChanged);
    _interstitialAd = InterstitialAd(
      //? add intertitial id --
      adUnitId: InterstitialAd.testAdUnitId,
    );

    _interstitialAd.load();
    super.initState();
  }

  @override
  void dispose() {
    _subscription.cancel();
    _nativeAdController.dispose();
    super.dispose();
  }

  final _nativeAdController = NativeAdmobController();
  double _height = 0;

  StreamSubscription _subscription;

  void _onStateChanged(AdLoadState state) {
    switch (state) {
      case AdLoadState.loading:
        setState(() {
          _height = 0;
        });
        break;

      case AdLoadState.loadCompleted:
        setState(() {
          _height = 300;
        });
        break;

      default:
        break;
    }
  }
//*-------------------------------end----------------------------------------------------

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        setState(() {
          _interstitialAd..show();
        });
        Navigator.pop(context);
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              setState(() {
                _interstitialAd..show();
              });
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
        body: Column(
          children: [
            Expanded(
              child: Stack(
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
                      onLoadStart:
                          (InAppWebViewController controller, String url) {
                        setState(() {
                          isLoading = true;
                        });
                      },
                      onLoadStop:
                          (InAppWebViewController controller, String url) {
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
                              source: """.menu, #header, #HeaderMain1_topLinks,
                                  footer, .topLinks, .footerBottom
                                  {display:none;visibility: hidden;}""");
                          // 100;
                        });
                      },
                    )),
                  ]),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
