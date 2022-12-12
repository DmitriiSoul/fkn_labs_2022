import 'package:flutter/material.dart';

import 'package:card_swiper/card_swiper.dart';

void main() => runApp(const MyApp());

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<StatefulWidget> createState() => _MyAppState();
}

class Heroes {
  String name;
  String about;
  String img;

  Heroes(this.name, this.about, this.img);
}

List<Heroes> heroList = [
  Heroes("Deadpool", "I'm Deadpool", "https://i.imgur.com/N2NvPl3.jpg"),
  Heroes("Iron Man", "I'm Iron Man", "https://i.imgur.com/bjU4Obk.jpg"),
  Heroes("Spider Man", "I'm Spider Man", "https://i.imgur.com/K8kvoce.jpg"),
  Heroes("Thor", "I'm Thor", "https://i.imgur.com/OAungCW.jpg"),
];

class _MyAppState extends State<MyApp> {

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
                Image.network('https://i.imgur.com/IANLc0p.png', width: 400, height: 50),
            backgroundColor: Colors.transparent,
            elevation: 0),
        body: Stack(
          children: const <Widget>[
            Padding(
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
            HeroSwiper(),
          ],
        ),
      ),
    );
  }
}

class HeroSwiper extends StatelessWidget {
  const HeroSwiper({super.key});

  @override
  Widget build(BuildContext context) => (
        Swiper(
          itemCount: heroList.length,
          itemBuilder: (BuildContext context, int index) {
            return GestureDetector(
              onTap: () =>
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => HeroCard(heroList[index]),)),
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 45),
                child: Hero(
                  tag: 'hero-${heroList[index].name}',
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Image.network("${heroList[index].img}", fit: BoxFit.fill),
                      Container(
                        color: Colors.white10,
                        alignment: Alignment.center,
                        child: Text(
                          heroList[index].name,
                          style: const TextStyle(
                              fontSize: 26,
                              fontStyle: FontStyle.italic,
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
        )
  );
}

class HeroCard extends StatelessWidget {
  final Heroes _heroes;
  const HeroCard(this._heroes, {super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
    extendBodyBehindAppBar: true,
    appBar: AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
    ),
    body: Hero(
      tag: 'hero-${_heroes.name}',
      child: Stack(
          children: <Widget>[
            Image.network(
                _heroes.img,
                fit: BoxFit.cover,
                height: MediaQuery.of(context).size.height
            ),
            Padding(
              padding: const EdgeInsets.only(top: 600, left: 20),
              child: Text(
                _heroes.name,
                style: const TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 655, left: 21),
              child: Text(
                _heroes.about,
                style: const TextStyle(
                  fontSize: 27,
                  fontFamily: 'Marvel',
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
    ),
  );
}
