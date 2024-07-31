import 'package:cached_network_image/cached_network_image.dart';
import 'package:cinestream/constants/themes.dart';
import 'package:cinestream/model/movie_model.dart';
import 'package:cinestream/provider/provider.dart';
import 'package:cinestream/severices/base.dart';
import 'package:cinestream/view/movie_details_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart'; // Import shimmer package

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  TextEditingController queryController = TextEditingController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<ApiProvider>(context, listen: false).Popularmovies();
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.bgcolor,
        appBar: AppBar(
          toolbarHeight: 70,
          automaticallyImplyLeading: false,
          backgroundColor: AppColors.bgcolor,
          title: Padding(
            padding: const EdgeInsets.only(left: 20, right: 20, top: 10),
            child: Container(
              height: 60,
              decoration: BoxDecoration(
                color: Colors.white12,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                child: TextFormField(
                  controller: queryController,
                  cursorColor: Colors.white,
                  style: const TextStyle(color: Colors.white),
                  decoration: const InputDecoration(
                    hintText: 'Search',
                    hintStyle: TextStyle(
                      fontSize: 18,
                      color: AppColors.silver,
                    ),
                    prefixIcon: Icon(
                      Icons.search,
                      size: 28,
                      color: AppColors.silver,
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide.none,
                    ),
                    enabledBorder:
                        OutlineInputBorder(borderSide: BorderSide.none),
                  ),
                  onChanged: (query) {
                    // if the search is empty hit by default movie list..
                    if (query.isNotEmpty) {
                      Provider.of<ApiProvider>(context, listen: false)
                          .SearchMovie(query);
                    } else {
                      //  if some query is search then get that movies and related movies list..
                      Provider.of<ApiProvider>(context, listen: false)
                          .Popularmovies();
                    }
                  },
                ),
              ),
            ),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(15),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Consumer<ApiProvider>(builder: (context, provider, child) {
                  if (provider.isLoading) {
                    // Shimmer effect when loading
                    return GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 6,
                        mainAxisSpacing: 6,
                        childAspectRatio: 0.6,
                      ),
                      itemCount: 6, // Number of shimmer items to display
                      itemBuilder: (context, index) {
                        return Shimmer.fromColors(
                          baseColor: Colors.grey[700]!,
                          highlightColor: Colors.grey[500]!,
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.grey[700],
                              borderRadius: BorderRadius.circular(15),
                            ),
                            margin: const EdgeInsets.all(8),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  height: size.height * 0.23,
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    color: Colors.grey[700],
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                ),
                                SizedBox(height: size.height * 0.010),
                                Container(
                                  height: 20,
                                  width: size.width * 0.5,
                                  color: Colors.grey[700],
                                  margin: const EdgeInsets.only(left: 15),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 14,
                                    vertical: 10,
                                  ),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                        height: 20,
                                        width: 50,
                                        color: Colors.grey[700],
                                      ),
                                      Container(
                                        height: 20,
                                        width: 20,
                                        color: Colors.grey[700],
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  }

                  MovieModel? movieList;
                  String noMoviesMessage = "";
                  if (queryController.text.isEmpty) {
                    movieList = provider.popular;
                    noMoviesMessage = "No Popular Movies Available Now";
                  } else {
                    movieList = provider.searchlist;
                    noMoviesMessage = "No Movies Found";
                  }

                  if (movieList == null || movieList.results == null) {
                    return SizedBox(
                      height: size.height - 70 - 30,
                      child: Center(
                        child: Text(
                          noMoviesMessage,
                          style: GoogleFonts.aBeeZee(
                            fontSize: 20,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    );
                  }

                  return GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 6,
                      mainAxisSpacing: 6,
                      childAspectRatio: 0.6,
                    ),
                    itemCount: movieList.results!.length,
                    itemBuilder: (context, index) {
                      final movie = movieList!.results![index];
                      return Padding(
                        padding: const EdgeInsets.all(8),
                        child: Container(
                          decoration: BoxDecoration(
                            color: AppColors.bgcolor,
                            borderRadius: BorderRadius.circular(15),
                            boxShadow: const [
                              BoxShadow(
                                color: Colors.black26,
                                blurRadius: 15,
                                spreadRadius: 1,
                                offset: Offset(4.0, 4.0),
                              ),
                              BoxShadow(
                                color: Colors.black26,
                                blurRadius: 15,
                                spreadRadius: 1,
                                offset: Offset(-4.0, -4.0),
                              ),
                            ],
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(
                                  left: 12,
                                  right: 12,
                                  top: 15,
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(15),
                                  child: GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              MovieDetailsPage(
                                            movies: movieList!,
                                            index: index,
                                            movieId: movie.id!,
                                          ),
                                        ),
                                      );
                                    },
                                    child: CachedNetworkImage(
                                      imageUrl:
                                          '${Base.imageurl}${movie.posterPath}',
                                      height: size.height * 0.23,
                                      width: double.infinity,
                                      fit: BoxFit.cover,
                                      placeholder: (context, url) => spinkit,
                                      errorWidget: (context, url, error) =>
                                          Image.asset('assets/placeholder.PNG'),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(height: size.height * 0.010),
                              Padding(
                                padding: const EdgeInsets.only(left: 15),
                                child: Text(
                                  '${movie.originalName ?? movie.originalTitle}',
                                  style: GoogleFonts.poppins(
                                    fontSize: size.width * 0.030,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w500,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 14,
                                  vertical: 10,
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      '${movie.voteAverage!.toStringAsFixed(1)}',
                                      style: GoogleFonts.poppins(
                                        fontSize: 18,
                                        color: AppColors.silver,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    const Icon(
                                      Icons.star,
                                      color: Colors.amber,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// spin kit for delaying image
const spinkit = SpinKitFadingCircle(
  color: Colors.teal,
  size: 30.0,
);
