import 'dart:ui';

import 'package:cinestream/constants/themes.dart';
import 'package:cinestream/model/movie_model.dart';
import 'package:cinestream/provider/provider.dart';
import 'package:cinestream/severices/base.dart';
import 'package:cinestream/utils/recommendation_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart';
import 'package:provider/provider.dart';

class MovieDetailsPage extends StatefulWidget {
  final MovieModel movies;
  final int movieId;
  final index;
  const MovieDetailsPage(
      {super.key,
      required this.movies,
      required this.index,
      required this.movieId});

  @override
  State<MovieDetailsPage> createState() => _MovieDetailsPageState();
}

class _MovieDetailsPageState extends State<MovieDetailsPage> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    var movie = widget.movies.results![widget.index];
    return Scaffold(
      body: Stack(
        children: [
          Container(
              height: size.height, width: size.width, color: AppColors.bgcolor),
          Container(
            height: size.height * .6,
            width: size.width,
            child: Hero(
                tag: 'movie-hero-${movie.id}',
                child: Container(
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          fit: BoxFit.cover,
                          image: NetworkImage(
                              '${Base.imageurl}${movie.posterPath}'))),
                  child: Container(
                    decoration: BoxDecoration(
                      gradient:
                          LinearGradient(begin: Alignment.bottomRight, colors: [
                        AppColors.bgcolor,
                        AppColors.bgcolor.withOpacity(.8),
                        AppColors.bgcolor.withOpacity(.1),
                      ]),
                    ),
                  ),
                )),
          ),
          Positioned(
            top: 250,
            child: Column(
              children: [
                Container(
                  height: 80,
                  width: size.width,
                  child: Center(
                      child: ClipRRect(
                    borderRadius: BorderRadius.circular(50.0),
                    child: BackdropFilter(
                      filter: ImageFilter.blur(
                        sigmaX: 10.0,
                        sigmaY: 10.0,
                      ),
                      child: Container(
                          padding: const EdgeInsets.all(15),
                          color: Colors.white.withOpacity(0.3),
                          child: const Icon(Icons.play_arrow_rounded,
                              color: Colors.white, size: 45)),
                    ),
                  )),
                ),
                const SizedBox(height: 20.0),
                Text(
                  '${movie.originalTitle ?? movie.originalName}',
                  style: GoogleFonts.poppins(
                    color: Colors.white,
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 15.0),
                Padding(
                  padding: const EdgeInsets.only(left: 15),
                  child: Row(
                    children: [
                      Text(
                        '${movie.voteAverage!.toStringAsFixed(1)}',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const Padding(
                        padding: EdgeInsets.all(5.0),
                        child:
                            Icon(Icons.star_rate_rounded, color: Colors.amber),
                      ),
                    ],
                  ),
                ),
                Text(
                  ' ${movie.releaseDate ?? movie.firstAirDate} | 2h 30m ',
                  style: const TextStyle(color: Colors.white70),
                ),
                const SizedBox(height: 20.0),
                Text(
                  'Genres: ${movie.getGenresAsString()}',
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.white70,
                  ),
                ),
                const SizedBox(height: 25.0),
                Padding(
                  padding: const EdgeInsets.only(right: 240),
                  child: Text(
                    'Storyline',
                    style: GoogleFonts.poppins(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 25),
                    textAlign: TextAlign.start,
                  ),
                ),
                const SizedBox(height: 10.0),
                Container(
                  width: size.width * .9,
                  child: Wrap(
                    children: [
                      Text('${movie.overview}',
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            color: Colors.white,
                          ),
                          maxLines: 6,
                          textAlign: TextAlign.justify)
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 150, top: 10),
                  child: Text(
                    'Recommendations',
                    style: GoogleFonts.poppins(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 20),
                    textAlign: TextAlign.start,
                  ),
                ),
                //  SizedBox(height: 10.0),
                // Recommendation Movies base on current Movie id...
                RecommendationList(movieId: widget.movieId),
                const SizedBox(height: 5.0),
              ],
            ),
          ),
          // Back Button to go to previous page..
          Positioned(
              top: 20,
              right: 10,
              child: InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Container(
                  height: size.height * 0.040,
                  width: size.height * 0.040,
                  decoration: BoxDecoration(
                      color: Colors.white70,
                      borderRadius: BorderRadius.circular(50)),
                  child: const Center(
                    child: Icon(
                      Icons.close,
                      color: Colors.black,
                    ),
                  ),
                ),
              )),
        ],
      ),
    );
  }
}
