import 'package:cinestream/constants/themes.dart';

import 'package:cinestream/provider/provider.dart';
import 'package:cinestream/severices/base.dart';
import 'package:cinestream/view/movie_details_page.dart';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

class ExplorePage extends StatefulWidget {
  const ExplorePage({super.key});

  @override
  State<ExplorePage> createState() => _ExplorePageState();
}

class _ExplorePageState extends State<ExplorePage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<ApiProvider>(context, listen: false).getTopShow();
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
            padding:
                const EdgeInsets.only(left: 8, right: 8, top: 18, bottom: 10),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Top Rated',
                style: GoogleFonts.aBeeZee(
                    color: Colors.white,
                    fontSize: size.width * 0.050,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 0.5),
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
                  // if the topshow list is comming null
                  if (provider.topshow == null ||
                      provider.topshow!.results == null) {
                    return Center(
                      child: Text(
                        "No Show Available Now",
                        style: GoogleFonts.aBeeZee(
                            fontSize: 20, color: Colors.white),
                      ),
                    );
                  }
                  // load topshow in listview builder...
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
                    itemCount: provider.topshow!.results!.length,
                    itemBuilder: (contex, index) {
                      final movie = provider.topshow!.results![index];
                      return Padding(
                        padding: const EdgeInsets.all(8),
                        child: Container(
                            // height: size.height * 0.70,
                            // width: size.width * 0.55,
                            decoration: BoxDecoration(
                                color: AppColors.bgcolor,
                                borderRadius: BorderRadius.circular(15),
                                boxShadow: const [
                                  BoxShadow(
                                      color: Colors.black26,
                                      blurRadius: 15,
                                      spreadRadius: 1,
                                      offset: Offset(4.0, 4.0)),
                                  BoxShadow(
                                      color: Colors.black26,
                                      blurRadius: 15,
                                      spreadRadius: 1,
                                      offset: Offset(-4.0, -4.0))
                                ]),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 12, right: 12, top: 15),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(15),
                                    child: GestureDetector(
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    MovieDetailsPage(
                                                        movies:
                                                            provider.topshow!,
                                                        index: index,
                                                        movieId: movie.id!)));
                                      },
                                      child: Image.network(
                                        '${Base.imageurl}${movie.posterPath}',
                                        height: size.height * 0.23,
                                        width: double.infinity,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: size.height * 0.010,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 15),
                                  child: Text(
                                    '${movie.originalName ?? movie.originalTitle}',
                                    style: GoogleFonts.poppins(
                                        fontSize: size.width * 0.030,
                                        color: Colors.white,
                                        fontWeight: FontWeight.w500),
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 1,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 14, vertical: 10),
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
                                )
                              ],
                            )),
                      );
                    },
                  );
                })
              ],
            ),
          ),
        ),
      ),
    );
  }
}
