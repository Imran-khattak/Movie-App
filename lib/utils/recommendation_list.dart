import 'package:cinestream/constants/themes.dart';
import 'package:cinestream/provider/provider.dart';
import 'package:cinestream/severices/base.dart';
import 'package:cinestream/view/movie_details_page.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class RecommendationList extends StatefulWidget {
  final int movieId;
  const RecommendationList({super.key, required this.movieId});

  @override
  State<RecommendationList> createState() => _RecommendationListState();
}

class _RecommendationListState extends State<RecommendationList> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<ApiProvider>(context, listen: false)
          .Recomended(widget.movieId);
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      height: 140,
      width: size.width,
      child: Consumer<ApiProvider>(
        builder: (context, apiProvider, child) {
          if (apiProvider.isLoading) {
            return Center(
              child: CircularProgressIndicator(
                color: Colors.teal,
              ),
            );
          }
          if (apiProvider.recomended == null ||
              apiProvider.recomended!.results == null) {
            return Center(
              child: Text(
                "No Recommnedation Movie Available Now",
                style: GoogleFonts.aBeeZee(fontSize: 16, color: Colors.white),
              ),
            );
          }
          return ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: apiProvider.recomended!.results!.length,
            itemBuilder: (context, index) {
              final recommendedMovie = apiProvider.recomended!.results![index];
              return Container(
                width: 100,
                margin: EdgeInsets.symmetric(horizontal: 8.0),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Image.asset(
                      'assets/story-circle.png',
                      height: 125,
                    ),
                    Image.asset(
                      'assets/story-circle.png',
                      height: 120,
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => MovieDetailsPage(
                                    movies: apiProvider.recomended!,
                                    index: index,
                                    movieId: recommendedMovie.id!)));
                      },
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(50.0),
                        child: Container(
                          color: AppColors.bgcolor,
                          child: Image.network(
                            '${Base.imageurl}${recommendedMovie.posterPath}',
                            fit: BoxFit.cover,
                            height: 90,
                            width: 90,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}
