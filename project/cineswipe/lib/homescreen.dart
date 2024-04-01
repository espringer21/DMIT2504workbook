import 'package:cineswipe/widgets/movieslider.dart';
import 'package:cineswipe/widgets/trendingmovies.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text('CineSwipe',
        style: TextStyle(
          fontSize: 32,
          color: Colors.amberAccent
        ),
        ),
      ),
      body: const SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Padding(
          padding: EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
             SizedBox(height: 25),
             Text('Trending Movies',style: TextStyle(fontSize: 25),),
               TrendingMovies(),
              SizedBox(height: 32),
              Text('Top Rated Movies',style: TextStyle(fontSize: 25),),
               MovieSlider(),
               SizedBox(height: 32,),
              Text('Upcoming Movies',style: TextStyle(fontSize: 25),),
              MovieSlider(),
            ],
          ),
        ),
      ),
    );
  }
}
