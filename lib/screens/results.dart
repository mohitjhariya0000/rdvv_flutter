// import 'package:flutter/material.dart';
// import 'webView.dart';

// class Results extends StatefulWidget {
//   @override
//   _ResultsState createState() => _ResultsState();
// }

// class _ResultsState extends State<Results> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(),
//       body: Container(
//         padding: EdgeInsets.all(9.0),
//         child: GridView(
//           gridDelegate:
//               SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
//           children: [
//             ResultCard(
//               title: "Result1",
//             ),
//             ResultCard(title: "Result2"),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class ResultCard extends StatelessWidget {
//   final String title;
//   final String webViewLinkx;
//   const ResultCard({this.title, this.webViewLinkx});

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: () {
//         Navigator.push(
//             context,
//             MaterialPageRoute(
//                 builder: (contex) => WebViewPage(
//                     appBarTitle: title, webViewLink: webViewLinkx)));
//       },
//       child: Card(
//         elevation: 10,
//         child: Center(
//             child: Text(title,
//                 style: TextStyle(fontSize: 21, fontWeight: FontWeight.bold))),
//       ),
//     );
//   }
// }
