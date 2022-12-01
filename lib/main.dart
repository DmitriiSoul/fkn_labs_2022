import 'package:flutter/material.dart';

import 'package:card_swiper/card_swiper.dart';

void main() => runApp(const MyApp());

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<StatefulWidget> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  List<String> nameList = ["Deadpool", "Iron Man", "Spider Man", "Thor"];
  List<String> imageList = [
    "assets/images/deadpool.jpg",
    "assets/images/iron-man.jpg",
    "assets/images/spider-man.jpg",
    "assets/images/thor.jpg"
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.indigo,
        appBar: AppBar(
            titleSpacing: 35,
            centerTitle: true,
            title:
                Image.asset('assets/images/marvel.png', width: 400, height: 50),
            backgroundColor: Colors.transparent,
            elevation: 0),
        body: Stack(
          children: <Widget>[
            const Padding(
              padding: EdgeInsets.only(left: 85, top: 3),
              child: Text(
                "Choose your hero",
                style: TextStyle(
                  fontSize: 27,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
            Swiper(
              itemCount: imageList.length,
              itemBuilder: (BuildContext context, int index) {
                return GestureDetector(
                  onTap: () =>
                      Navigator.of(context).push(
                          MaterialPageRoute(builder: (context) => HeroCard(),)),
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 45),
                    child: Hero(
                      tag: 'hero-$imageList',
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Image.asset(imageList[index], fit: BoxFit.fill),
                          Container(
                            color: Colors.white10,
                            alignment: Alignment.center,
                            child: Text(
                              nameList[index],
                              style: const TextStyle(
                                  fontSize: 26,
                                  fontFamily: 'Marvel',
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white70),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
              viewportFraction: 0.8,
              scale: 0.9,
            ),
          ],
        ),
      ),
    );
  }
}

class HeroCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(backgroundColor: Colors.transparent,),
    body: Hero(
      tag: 'hero-1',
      child: Image.network(
        'https://linchakin.com/files/word/1000/212/1.jpg'
      ),
    ),
  );
}
