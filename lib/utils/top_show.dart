import 'package:cinestream/constants/themes.dart';
import 'package:cinestream/provider/provider.dart';
import 'package:cinestream/severices/base.dart';
import 'package:cinestream/view/movie_details_page.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart'; // Import the shimmer package

class TopShow extends StatelessWidget {
  TopShow({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(
            left: 15,
            top: 15,
            right: 15,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Top Show',
                style: GoogleFonts.aBeeZee(
                  fontSize: 24,
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                ),
              ),
              Text(
                'See all',
                style: GoogleFonts.aBeeZee(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: AppColors.munatee,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        Expanded(
          child: Consumer<ApiProvider>(
            builder: (context, provider, child) {
              if (provider.isLoading) {
                // Show shimmer effect when loading
                return ListView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemCount: 5, // Number of shimmer items
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Shimmer.fromColors(
                        baseColor: Colors.grey[700]!,
                        highlightColor: Colors.grey[500]!,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(15),
                          child: Container(
                            width:
                                150, // Adjust the width of the shimmer container
                            height:
                                250, // Adjust the height of the shimmer container
                            color: Colors.grey[700],
                          ),
                        ),
                      ),
                    );
                  },
                );
              }
              if (provider.topshow == null ||
                  provider.topshow!.results == null) {
                return Center(
                  child: Text(
                    "No Show Available Now",
                    style:
                        GoogleFonts.aBeeZee(fontSize: 20, color: Colors.white),
                  ),
                );
              }
              return ListView.builder(
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemCount: provider.topshow!.results!.length,
                itemBuilder: (context, index) {
                  var list = provider.topshow!.results!;
                  return Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => MovieDetailsPage(
                              movies: provider.topshow!,
                              index: index,
                              movieId: list[index].id!,
                            ),
                          ),
                        );
                      },
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(15),
                        child: SizedBox(
                          width: 150, // Adjust the width of the movie poster
                          height: 250, // Adjust the height of the movie poster
                          child: Image.network(
                            filterQuality: FilterQuality.high,
                            fit: BoxFit.cover,
                            "${Base.imageurl}${list[index].posterPath}",
                          ),
                        ),
                      ),
                    ),
                  );
                },
              );
            },
          ),
        ),
      ],
    );
  }
}
