import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:rdvv_app/screens/inAppWebView.dart';
import 'package:firebase_admob/firebase_admob.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await FlutterDownloader.initialize(
      debug: true // optional: set false to disable printing logs to console
      );
  await Permission.storage.request();
  runApp(MyApp());
  WidgetsFlutterBinding.ensureInitialized();
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  InterstitialAd _interstitialAd;

  @override
  void initState() {
    FirebaseAdMob.instance
        .initialize(appId: "ca-app-pub-6614495494674157~3284855263");
    // TODO: implement initState
    _interstitialAd = InterstitialAd(
      adUnitId: InterstitialAd.testAdUnitId,
    );

    _interstitialAd.load().then((value) {
      _interstitialAd..show();
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(primaryColor: CupertinoColors.activeBlue),
      home: Scaffold(
        backgroundColor: Color(0xfff7f9fb),
        appBar: AppBar(
          title: Text(
            'RDVV Jabalpur',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
        ),
        body: Container(
          padding: EdgeInsets.all(2.0),
          child: GridView(
            gridDelegate:
                SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
            children: [
              RdvvCard(
                title: 'Results',
                imageURI: 'image/result.jpg',
                webViewLink:
                    "http://www.rdunijbpin.org/1436/Result-Links?MenuID=1369",
              ),
              RdvvCard(
                title: 'Time Table',
                imageURI: 'image/timetabel2.jpg',
                webViewLink: "http://www.rdunijbpin.org/1366/Time-Table",
              ),
              RdvvCard(
                title: 'Online Services',
                imageURI: 'image/online.jpg',
                webViewLink: "https://rdvv.mponline.gov.in/Portal/Index.aspx",
              ),
              RdvvCard(
                title: 'Scholarship Portal',
                imageURI: 'image/scholarship.jpg',
                webViewLink: "http://www.rdunijbpin.org/1392/Scholarship",
              ),
              RdvvCard(
                title: 'Download Forms',
                imageURI: 'image/download.jpg',
                webViewLink:
                    "https://drive.google.com/drive/folders/1s1aoxDwG5Tn-T3B3RzMFRJ0dUTOIbrla?usp=sharing",
              ),
              RdvvCard(
                title: 'Important Link',
                imageURI: 'image/important.jpg',
                webViewLink: "http://www.rdunijbpin.org/1067/News",
              ),
              RdvvCard(
                title: 'IQAC',
                imageURI: 'image/iqac2.jpg',
                webViewLink:
                    "http://www.rdunijbpin.org/site/information/GenericPDFListing.aspx?Doctype=BA8B7280-FCF7-414F-B2A0-FD530EA8285E",
              ),
              RdvvCard(
                title: 'UTD-CBCS-Notices',
                imageURI: 'image/notices.jpg',
                webViewLink:
                    "http://www.rdunijbpin.org/1482/UTD-CBCS-Timetable-and-Notices?Doctype=7FFB8791-4BE1-43A5-92D4-49AA0A412D83",
              ),
              RdvvCard(
                title: 'E-Contents',
                imageURI: 'image/contents.jpg',
                webViewLink:
                    "http://www.rdunijbpin.org/site/information/GenericPDFListing.aspx?Doctype=54de9757-c91a-428a-a26a-a8b13fb2cfe4",
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class RdvvCard extends StatelessWidget {
  final title;
  final imageURI;
  final webViewLink;
  const RdvvCard({this.title, this.imageURI, this.webViewLink});

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: GestureDetector(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (contex) => InAppWebViewx(
                        url: webViewLink,
                        title: title,
                      )));
        },
        child: Card(
          elevation: 3,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          //color: Colors.green[400],
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(25.0),
                child: Image.asset(
                  imageURI,
                  height: 100,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                title,
                textAlign: TextAlign.center,
                maxLines: 2,
                style: TextStyle(
                    color: Colors.black,
                    fontSize: screenSize.height / 43,
                    fontWeight: FontWeight.bold),
              )
            ],
          ),
        ),
      ),
    );
  }
}
