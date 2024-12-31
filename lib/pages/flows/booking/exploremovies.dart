import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:cinema_application/data/models/listmovie.dart';

import 'package:cinema_application/pages/flows/booking/detailmovie_upcoming.dart';
import 'package:cinema_application/pages/flows/booking/searchfieldpages.dart';
import 'package:cinema_application/pages/flows/booking/detailmoviepages.dart';

import 'package:cinema_application/widgets/customappbar.dart';
import 'package:cinema_application/widgets/custombutton.dart';

class ExploreMovies extends StatefulWidget {
  const ExploreMovies({super.key});

  @override
  State<ExploreMovies> createState() => _ExploreMoviesState();
}

class _ExploreMoviesState extends State<ExploreMovies> {
  bool isVoucherClicked = false;
  late List<AllMovie> nowMovies;
  late List<AllMovie> upcomingMovies;

  @override
  void initState() {
    super.initState();
    nowMovies = AllMovie.getList();
    upcomingMovies = AllMovie.getUpcoming();
  }

  void _toggleButton() {
    setState(() {
      isVoucherClicked = !isVoucherClicked;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 253, 247),
      appBar: CustomAppBar(
        title: "Movies",
        showBottomBorder: false,
        trailingButton: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Location button
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 13.5),
              padding: const EdgeInsets.symmetric(horizontal: 8),
              height: 36,
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 255, 196, 64),
                border: Border.all(
                  color: const Color.fromARGB(255, 14, 37, 34),
                  width: 1.2,
                ),
                borderRadius: BorderRadius.circular(8),
                boxShadow: [
                  BoxShadow(
                    offset: const Offset(1, 2),
                    color: Colors.black.withOpacity(1),
                  ),
                ],
              ),
              child: GestureDetector(
                onTap: () {},
                child: const Center(
                  child: Text(
                    "Location",
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      fontFamily: "Montserrat",
                      color: Color.fromARGB(255, 14, 37, 34),
                    ),
                  ),
                ),
              ),
            ),

            // Search button
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 0, vertical: 13.5),
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 255, 196, 64),
                border: Border.all(
                  color: const Color.fromARGB(255, 14, 37, 34),
                  width: 1.2,
                ),
                borderRadius: BorderRadius.circular(8),
                boxShadow: [
                  BoxShadow(
                    offset: const Offset(1, 2),
                    color: Colors.black.withOpacity(1),
                  ),
                ],
              ),
              child: IconButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Searchfieldpages()),
                  );
                },
                icon: const Icon(
                  Icons.search_rounded,
                  color: Color.fromARGB(255, 14, 37, 34),
                  size: 20,
                ),
              ),
            ),
          ],
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.fromLTRB(14, 0, 14, 12),
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: Color.fromARGB(255, 14, 37, 34),
                    width: 1.2,
                  ),
                ),
              ),
              child: 
              Row(
                // mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomButton(
                    text: 'Now',
                    isClicked: !isVoucherClicked,
                    onPressed: _toggleButton,
                  ),
                  const SizedBox(width: 5),
                  CustomButton(
                    text: 'Upcoming',
                    isClicked: isVoucherClicked,
                    onPressed: _toggleButton,
                  ),
                ],
              ),
          ),

          // Movie List Display
          Expanded(
            child: Container(
              margin: const EdgeInsets.fromLTRB(0, 4, 0, 28),
              child: ListView.builder(
                itemCount:
                    isVoucherClicked ? upcomingMovies.length : nowMovies.length,
                itemBuilder: (context, index) {
                  final movie = isVoucherClicked
                      ? upcomingMovies[index]
                      : nowMovies[index];
                  return GestureDetector(
                    onTap: () {
                      if (!isVoucherClicked) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Moviedetail(
                              movieTitle: movie.moviename,
                              movieDescription: movie.synopsis,
                              movieImage: movie.images,
                              movieRating: movie.rate,
                              movieYears: movie.years,
                              movieDuration: movie.time,
                              movieGenre: movie.genre,
                              movieWatchlist: movie.watchlist,
                            ),
                          ),
                        );
                      } else {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => UpcomingDetail(
                                    movieTitle: movie.moviename,
                                    movieDescription: movie.synopsis,
                                    movieImage: movie.images,
                                    movieGenre: movie.genre,
                                    movieYear: movie.years,
                                    movieDuration: movie.time,
                                    movieRating: movie.rate,
                                    movieWatchlist: movie.watchlist)));
                      }
                    },
                    child: _movieCard(movie),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _movieCard(AllMovie movie) {
    return Container(
      margin: const EdgeInsets.fromLTRB(16, 8, 16, 4),
      padding: const EdgeInsets.fromLTRB(4, 4, 8, 4),
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 255, 196, 64),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.black),
        boxShadow: [
          BoxShadow(
            offset: const Offset(1.6, 2.8),
            color: Colors.black.withOpacity(1),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.asset(
              movie.images,
              height: 140,
              width: 100,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    SvgPicture.asset('assets/icon/film.svg',
                        height: 16, width: 16),
                    const SizedBox(width: 6),
                    Expanded(
                      child: Text(
                        movie.genre,
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Colors.black54,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    if (!isVoucherClicked) ...[
                      const Spacer(),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 5, horizontal: 10),
                        decoration: BoxDecoration(
                          color: const Color(0xffDC555E),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            SvgPicture.asset('assets/icon/star.svg'),
                            const SizedBox(width: 4),
                            Text(
                              movie.rate,
                              style: const TextStyle(
                                color: Color(0xffFFFDF7),
                                fontFamily: "Montserrat",
                                fontSize: 14,
                                fontWeight: FontWeight.w700,
                                letterSpacing: 0.12,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  movie.moviename,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 8),
                if (!isVoucherClicked) ...[
                  Row(
                    children: [
                      SvgPicture.asset('assets/icon/clock.svg'),
                      const SizedBox(width: 4),
                      Text(
                        "${movie.time} Min",
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.normal,
                          color: Colors.black87,
                        ),
                      ),
                      const SizedBox(width: 40),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: Colors.black),
                        ),
                        child: Text(
                          movie.rating,
                          style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: Colors.black54,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}
