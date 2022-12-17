import 'package:flutter/material.dart';

import 'package:card_swiper/card_swiper.dart';
import 'package:dio/dio.dart';

const publicKey = "7235e328bdb51cf1bb0a2afc60713b17";
const privateKey = "d249ea5e4c31528a3bf1a2c52d8bd221ce710889";
const hash = "624e7e8420870ee25cb3ffb2c4830a42";

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

  Heroes({required this.name, required this.about, required this.img});

  factory Heroes.fromJson(dynamic response) {
    return Heroes(
        name: response['name'] as String,
        about: response['description'] as String,
        img: response['thumbnail']['path'] +
            '.' +
            response['thumbnail']['extension'] as String);
  }
}

class MarvelApi {
  Future<List<int>> getIdHeroes(int count) async {
    List<int> idHeroes = [];
    String url = "https://gateway.marvel.com:443/v1/public/characters?";

    try {
      Response response = await Dio().get(url, queryParameters: {
        "ts": 0,
        "apikey": publicKey,
        "hash": hash,
        "limit": count
      });

      for (var dataHero in response.data["data"]["results"]) {
        idHeroes.add(dataHero["id"]);
      }

      return idHeroes;
    } catch (e) {
      throw Exception("Exception: Could not get List of Heroes");
    }
  }

  Future<Heroes> getInfoHeroes(int id) async {
    String url =
        "https://gateway.marvel.com:443/v1/public/characters/${id.toString()}?";

    try {
      Response response = await Dio().get(url,
          queryParameters: {"ts": 0, "apikey": publicKey, "hash": hash});

      var json = response.data["data"]["results"][0];
      return Heroes.fromJson(json);
    } catch (e) {
      throw Exception("Exception: Could not get Hero");
    }
  }
}

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
            title: Image.network('https://i.imgur.com/IANLc0p.png',
                width: 400, height: 50),
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
            FutureBuilder<List<int>>(
                future: MarvelApi().getIdHeroes(10),
                builder: ((context, list) {
                  if (list.hasData) {
                    return HeroSwiper(list.data!);
                  }
                  if (list.hasError) {
                    return Text(
                      list.error.toString(),
                      style: const TextStyle(
                        fontSize: 27,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    );
                  }
                  return const Center(child: CircularProgressIndicator());
                })),
          ],
        ),
      ),
    );
  }
}

class HeroSwiper extends StatelessWidget {
  List<int> heroList;

  HeroSwiper(this.heroList, {super.key});

  @override
  Widget build(BuildContext context) => (Swiper(
        itemCount: heroList.length,
        itemBuilder: (BuildContext context, int index) {
          return FutureBuilder<Heroes>(
              future: MarvelApi().getInfoHeroes(heroList[index]),
              builder: ((context, hero) {
                if (hero.hasData) {
                  return GestureDetector(
                    onTap: () => Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => HeroCard(hero.data!),
                    )),
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 45),
                      child: Hero(
                        tag: 'hero-${hero.data!.name}',
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Image.network(hero.data!.img, fit: BoxFit.fill),
                            Container(
                              color: Colors.white10,
                              alignment: Alignment.center,
                              child: Text(
                                hero.data!.name,
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
                }
                if (hero.hasError) {
                  return Center(child: Text(hero.error.toString()));
                }
                return const Center(
                  child: CircularProgressIndicator(
                    color: Colors.green,
                  ),
                );
              }));
        },
        viewportFraction: 0.8,
        scale: 0.9,
      ));
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
              Image.network(_heroes.img,
                  fit: BoxFit.cover,
                  height: MediaQuery.of(context).size.height),
              Positioned(
                bottom: 25,
                left: 15,
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 5, left: 15),
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
                        padding: const EdgeInsets.only(bottom: 25, left: 15),
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
                    ]),
              ),
            ],
          ),
        ),
      );
}
