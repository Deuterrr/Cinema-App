import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
// import 'package:provider/provider.dart';
// import 'package:flutter_svg/flutter_svg.dart';

import 'package:cinema_application/pages/flows/booking/detailmoviepages.dart';
import 'package:cinema_application/pages/flows/booking/exploremovies.dart';

import 'package:cinema_application/data/models/listmovie.dart';
import 'package:cinema_application/data/models/film.dart';

import 'package:cinema_application/widgets/homebar.dart';
import 'package:cinema_application/widgets/sectionicon.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late List<MovieList> listmoviefirst;
  late List<AllMovie> allmovie;
  late List<AllMovie> upcomingMovies;

  @override
  void initState() {
    super.initState();
    listmoviefirst = MovieList.getList();
    allmovie = AllMovie.getList();
    upcomingMovies = AllMovie.getUpcoming();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFFFFFF), // White
      appBar: HomeBarButton(
        title: '',
      ),
      body: Stack(
        children: [
          SafeArea(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              scrollDirection: Axis.vertical,
              child: SizedBox(
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    // displaying ads
                    adsSlider(),

                    // sementara ngga dipakai dulu
                    // displaying vouchers and coupons
                    // displayVoucher(),

                    // displaying now showing movies in box
                    nowPlayingMovie(),

                    // displaying upcoming movies in box
                    upcomingMovie(),
                    contoh(),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // image slider box
  Widget adsSlider() {
  return LayoutBuilder(
    builder: (context, constraints) {
      // calculate aspect ratio by max height
      double maxHeight = 180;
      double aspectRatio = constraints.maxWidth / maxHeight;

      return Container(
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: Colors.black,
              width: 1.2,
            ),
          ),
        ),
        child: CarouselSlider.builder(
          itemCount: listmoviefirst.length,
          itemBuilder: (context, index, realIndex) {
            final movie = listmoviefirst[index];
            return Stack(
              fit: StackFit.expand,
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: Colors.purple
                  ),
                ),
                // Image.asset(
                //   movie.images,
                //   fit: BoxFit.cover,
                // ),
                Positioned(
                  bottom: 5,
                  left: 0,
                  right: 5,
                  child: Text(
                    movie.nameMovie,
                    textAlign: TextAlign.end,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            );
          },
          options: CarouselOptions(
            autoPlay: true,
            enlargeCenterPage: true,
            aspectRatio: aspectRatio, // Dynamic aspect ratio
            viewportFraction: 1.0,
          ),
        ),
      );
    },
  );
}

  // display users voucher
  Widget displayVoucher() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Container(
        padding: const EdgeInsets.fromLTRB(12, 8, 12, 9),
        decoration: BoxDecoration(
          color: Color.fromARGB(255, 220, 85, 94),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SectionWithIcon(
                title: 'Level',
                value: ' Classic',
                haveIcon: false,),
            SectionWithIcon(
                title: 'Points',
                value: ' 0',
                haveIcon: false,),
            SectionWithIcon(
                title: 'Vouchers',
                value: ' 0',
                haveIcon: true,
                icon: 'assets/icon/coupunicon.svg'),
            SectionWithIcon(
                title: 'Coupons',
                value: ' 0',
                haveIcon: true,
                icon: 'assets/icon/discount.svg')
          ],
        ),
      )
    );
  }

  // list popular movie
  Widget nowPlayingMovie() {
    return Container(
      padding: EdgeInsets.fromLTRB(16, 14, 16, 14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          // Header
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "Now Playing",
                  style: TextStyle(
                    fontSize: 17,
                    color: Color(0xFF0E2522), // Black
                    fontWeight: FontWeight.w700,
                    fontFamily: "Montserrat",
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ExploreMovies()));
                  },
                  child: Text(
                    "See All",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      fontFamily: "Montserrat",
                      color: Color(0xFF4A6761) // Dark Tosca
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 4),

          Container(
            width: 210,
            height: 352,
            decoration: BoxDecoration(
              color: Color(0xFFFFD580) // Flat Orange
            ),
          )
        ],
      ),
    );
  }

  // list upcoming movie
  Widget upcomingMovie() {
    return Container(
      padding: EdgeInsets.fromLTRB(16, 14, 16, 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          // Header
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "Upcoming",
                  style: TextStyle(
                    fontSize: 17,
                    color: Color(0xFF0E2522), // Black
                    fontWeight: FontWeight.w700,
                    fontFamily: "Montserrat",
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ExploreMovies()));
                  },
                  child: Text(
                    "See All",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      fontFamily: "Montserrat",
                      color: Color(0xFF4A6761) // Dark Tosca
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 4),

          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                Container(
                  margin: const EdgeInsets.fromLTRB(0, 0, 12, 0),
                  width: 124,
                  height: 220,
                  decoration: BoxDecoration(
                    color: Color(0xFFFFD580) // Flat Orange
                  ),
                ),
                Container(
                  margin: const EdgeInsets.fromLTRB(0, 0, 12, 0),
                  width: 124,
                  height: 220,
                  decoration: BoxDecoration(
                    color: Color(0xFFFFD580) // Flat Orange
                  ),
                ),
                Container(
                  margin: const EdgeInsets.fromLTRB(0, 0, 12, 0),
                  width: 124,
                  height: 220,
                  decoration: BoxDecoration(
                    color: Color(0xFFFFD580) // Flat Orange
                  ),
                ),
                Container(
                  margin: const EdgeInsets.fromLTRB(0, 0, 12, 0),
                  width: 124,
                  height: 220,
                  decoration: BoxDecoration(
                    color: Color(0xFFFFD580) // Flat Orange
                  ),
                ),
              ],
            )
          )
        ],
      ),
    );
  }

  Widget contoh() {
    return Container(
      decoration: BoxDecoration(
        border: Border.symmetric(
          horizontal: BorderSide(
            color: Colors.black,
            width: 1.2
          ),
        )
      ),
      child: Container(
        height: 280,
        width: 450,
        color: Color(0xffA7D4CB),
        padding: EdgeInsets.fromLTRB(12, 7, 12, 18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header Row
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "Upcoming",
                    style: TextStyle(
                      fontSize: 17,
                      color: Color.fromARGB(255, 14, 37, 34), //blak
                      fontWeight: FontWeight.w700,
                      fontFamily: "Montserrat",
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ExploreMovies()));
                    },
                    child: Text(
                      "See All",
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        fontFamily: "Montserrat",
                        color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 10),

            // Movie ListView
            Expanded(
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: allmovie.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Moviedetail(
                            movieTitle: allmovie[index].moviename,
                            movieDescription: allmovie[index].synopsis,
                            movieImage: allmovie[index].images,
                            movieRating: allmovie[index].rate,
                            movieYears: allmovie[index].years,
                            movieDuration: allmovie[index].time,
                            movieGenre: allmovie[index].genre,
                            movieWatchlist: allmovie[index].watchlist,
                          ),
                        ),
                      );
                    },
                    child: movieCard(allmovie[index]),
                  );
                },
              ),
            ),
          ],
        ),
      )
    );
  }

  // Movie Card Widget
  Widget movieCard(AllMovie movie) {
    for (int i = 0; i < allmovie.length; i++) {}
    return Container(
      width: 120,
      margin: EdgeInsets.only(right: 10, bottom: 3),
      child: Container(
        decoration: BoxDecoration(
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
        child: Stack(
          alignment: Alignment.topRight,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(
                        8), // Adjust the radius value as needed
                    topRight: Radius.circular(8),
                  ),
                  child: Image.asset(
                    movie.images,
                    fit: BoxFit.cover,
                    height: 140,
                    width: double.infinity,
                  ),
                ),

                // Movie Title and Genre
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Color.fromARGB(255, 255, 196, 64),
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(8),
                        bottomRight: Radius.circular(8)),
                      boxShadow: [
                        BoxShadow(
                          offset: const Offset(1, 2),
                          color: Colors.black.withOpacity(1),
                        ),
                      ],
                    ),
                    padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                    width: double.infinity,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: EdgeInsets.fromLTRB(0, 8, 0, 5),
                          child: Text(
                            movie.moviename,
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w700,
                              fontFamily: "Montserrat",
                              letterSpacing: 0.12),
                          ),
                        ),
                        Text(
                          movie.genre,
                          style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w400,
                            color: Color.fromARGB(255, 14, 37, 34),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      )
    );
  }

}