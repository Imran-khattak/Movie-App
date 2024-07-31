import 'dart:ui';
import 'package:cinestream/utils/upcomming.dart';
import 'package:cinestream/view/movie_details_page.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cinestream/constants/themes.dart';
import 'package:cinestream/provider/provider.dart';
import 'package:cinestream/severices/base.dart';
import 'package:cinestream/utils/class_container.dart';
import 'package:cinestream/utils/top_show.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<ApiProvider>(context, listen: false).getTrendingList();
      Provider.of<ApiProvider>(context, listen: false).getTopShow();
      Provider.of<ApiProvider>(context, listen: false).getUpcomming();
    });
  }

  //MovieModel? movies;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.bgcolor,
        appBar: AppBar(
          toolbarHeight: 80,
          backgroundColor: Colors.transparent,
          centerTitle: true,
          title: Padding(
            padding: const EdgeInsets.only(top: 20, bottom: 10),
            child: Row(
              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const CircleAvatar(
                  radius: 28,
                  backgroundColor: AppColors.munatee,
                  child: CircleAvatar(
                    radius: 24,
                    backgroundImage: AssetImage('assets/profile.png'),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(left: 9.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Hello,',
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                            color: AppColors.gray),
                      ),
                      Text('Imran',
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                              color: Colors.white)),
                    ],
                  ),
                ),
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const SizedBox(),
                      Stack(
                        clipBehavior: Clip.none,
                        children: [
                          GlassContainer(
                            height: 55,
                            widht: 55,
                            image: Image.asset(
                              'assets/nofi.png',
                              height: 25,
                            ),
                          ),
                          const Positioned(
                              top: -23,
                              bottom: 5,
                              right: 13,
                              child: CircleAvatar(
                                backgroundColor: AppColors.neongreen,
                                radius: 4,
                              ))
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 20, bottom: 20, left: 15),
                child: Text(
                  "For You",
                  style: GoogleFonts.aBeeZee(
                      fontSize: 24,
                      fontWeight: FontWeight.w500,
                      color: Colors.white),
                ),
              ),
              SizedBox(
                child:
                    Consumer<ApiProvider>(builder: (context, provider, child) {
                  if (provider.isLoading) {
                    // Show shimmer effect when loading
                    return CarouselSlider.builder(
                      itemCount: 3, // Dummy items for shimmer
                      options: CarouselOptions(
                        height: 300,
                        autoPlay: true,
                        viewportFraction: 0.55,
                        enlargeCenterPage: true,
                        pageSnapping: true,
                        autoPlayCurve: Curves.fastOutSlowIn,
                        autoPlayAnimationDuration: const Duration(seconds: 1),
                      ),
                      itemBuilder: (context, index, pageIndx) {
                        return Shimmer.fromColors(
                          baseColor: Colors.grey[700]!,
                          highlightColor: Colors.grey[500]!,
                          child: Container(
                            width: 200,
                            height: 350,
                            decoration: BoxDecoration(
                              color: Colors.grey[700],
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                        );
                      },
                    );
                  }
                  // if trending movies coming null
                  if (provider.trendingmovies == null ||
                      provider.trendingmovies!.results == null) {
                    return Center(
                      child: Text(
                        "No Movie Available Now",
                        style: GoogleFonts.aBeeZee(
                            fontSize: 20, color: Colors.white),
                      ),
                    );
                  }
                  // load trening movies in carouselSlider
                  return CarouselSlider.builder(
                    itemCount: provider.trendingmovies!.results!.length,
                    options: CarouselOptions(
                      height: 300,
                      autoPlay: true,
                      viewportFraction: 0.55,
                      enlargeCenterPage: true,
                      pageSnapping: true,
                      autoPlayCurve: Curves.fastOutSlowIn,
                      autoPlayAnimationDuration: const Duration(seconds: 1),
                    ),
                    itemBuilder: (context, index, pageIndx) {
                      var list = provider.trendingmovies!.results!;

                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => MovieDetailsPage(
                                        movies: provider.trendingmovies!,
                                        index: index,
                                        movieId: list[index].id!,
                                      )));
                        },
                        child: Stack(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(12),
                              child: SizedBox(
                                height: 350,
                                width: 200,
                                child: Image.network(
                                  filterQuality: FilterQuality.high,
                                  fit: BoxFit.cover,
                                  "${Base.imageurl}${list[index].posterPath}",
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 200,
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
                                      child: const Icon(
                                          Icons.play_arrow_rounded,
                                          color: Colors.white,
                                          size: 45)),
                                ),
                              )),
                            ),
                          ],
                        ),
                      );
                    },
                  );
                }),
              ),
              // display Topshow..
              SizedBox(height: 270, child: TopShow()),
              // display Upcomming Movies..
              SizedBox(height: 270, child: UpcomingMovieCard()),
            ],
          ),
        ),
      ),
    );
  }
}
