import 'package:flutter/material.dart';

import 'package:card_swiper/card_swiper.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Marvel App',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: MyHomePage(title: 'Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Swiper(
        itemBuilder: (BuildContext context, int index) {
          return Image.network(
            "https://via.placeholder.com/288x188",
            fit: BoxFit.fill,
          );
        },
        itemCount: 5,
        viewportFraction: 0.8,
        scale: 0.9,

      ),
    );
  }
}