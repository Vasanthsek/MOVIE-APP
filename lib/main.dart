import 'dart:io';

import 'package:flutter/material.dart';
import 'package:movie_app/utils/text.dart';
import 'package:movie_app/widgets/toprated.dart';
import 'package:movie_app/widgets/trending.dart';
import 'package:movie_app/widgets/tv.dart';
import 'package:tmdb_api/tmdb_api.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  HttpOverrides.global = MyHttpOverrides();
  runApp(const MyApp());
}

class MyHttpOverrides extends HttpOverrides{
  @override
  HttpClient createHttpClient(SecurityContext? context){
    return super.createHttpClient(context)..badCertificateCallback = (X509Certificate cert,String host,int port) => true;
  }
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        brightness: Brightness.dark,
        primarySwatch: Colors.green,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List trendingMovies = [];
  List topratedMovies = [];
  List tv = [];
  final String apiKey = "ff7706189bf9009b416231deb7bb98dd";
  final String readAccessToken = "eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJmZjc3MDYxODliZjkwMDliNDE2MjMxZGViN2JiOThkZCIsInN1YiI6IjYzNGY5NWMzYTU3ZDQzMDA3ZDRlZDhkMyIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.SMq2gnRYu2xPBKu7H5Xpz30Q7fNryMnWupCv8fU5FnI";
  
  @override
  void initState() {
    loadmovies();
    super.initState();
    
  }
  loadmovies()async{
   TMDB tmdbwithcustomLogs = TMDB(ApiKeys(apiKey, readAccessToken),logConfig: const ConfigLogger(showLogs: true,showErrorLogs: true));
  Map trendingResult = await tmdbwithcustomLogs.v3.trending.getTrending();
  Map topratedResult = await tmdbwithcustomLogs.v3.movies.getTopRated();
  Map tvResult = await tmdbwithcustomLogs.v3.tv.getTopRated();
  setState(() {
    trendingMovies = trendingResult["results"];
    topratedMovies = topratedResult["results"];
    tv = tvResult["results"];
  });
  // print(trendingMovies);
  // print(topratedMovies);
  //  print(tv);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.transparent,
        title: const ModifiedText(text: "Movie App",color: Colors.white,size: 30,)),
        body: ListView(
          children: [
            Tvv(tv: tv),
            TopRated(toprated:topratedMovies ),
            TrendingMovies(trending:trendingMovies )
          ],
        ),
    );
  }
}

