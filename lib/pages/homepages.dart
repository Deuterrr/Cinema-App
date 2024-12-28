import 'dart:ui';

// Package
import 'package:cinema_application/pages/auth/auth.dart';
import 'package:cinema_application/pages/bookingflow/detailmoviepages.dart';
import 'package:cinema_application/pages/bookingflow/exploremovies.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

// Model
import 'package:cinema_application/models/listmovie.dart';
import 'package:cinema_application/models/film.dart';

// Widgets
import 'package:cinema_application/widgets/homeappbar.dart';
import 'package:cinema_application/widgets/sectionicon.dart';

class Homepages extends StatefulWidget {
  const Homepages({super.key});

  @override
  State<Homepages> createState() => _HomepagesState();
}

class _HomepagesState extends State<Homepages> {
  late List<MovieList> listmoviefirst;
  late List<AllMovie> allmovie;

  @override
  void initState() {
    super.initState();
    listmoviefirst = MovieList.getList();
    allmovie = AllMovie.getList();
    Future.delayed(Duration.zero, () {
      Provider.of<AuthProvider>(context, listen: false).checkLoginStatus();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 255, 253, 247),
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
                    const SizedBox(height: 5),

                    // displaying vouchers and coupons
                    displayVoucher(),
                    const SizedBox(height: 5),

                    // displaying popular movies in box
                    popularMovie(),
                    const SizedBox(height: 3),
                  ],
                ),
              ),
            ),
          ),

          // Explore Movies Button
          Positioned(
            bottom: 20,
            right: 20,
            child: Container(
              width: 70,
              height: 43,
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 220, 85, 94), //terracota
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
              child: FloatingActionButton(
                onPressed: () {
                  // show panel for Now Showing
                  nowShowingMovies(context);
                },
                backgroundColor: Colors.transparent,
                elevation: 0,
                highlightElevation: 0,
                hoverElevation: 0,
                disabledElevation: 0,
                child:
                    SvgPicture.asset('assets/icon/ticket.svg'),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget displayVoucher() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      margin: EdgeInsets.only(left: 15, right: 15, top: 10),
      decoration: BoxDecoration(
          color: Color(0xffFFFDF7),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Colors.black12),
          boxShadow: [
            BoxShadow(
                color: Colors.black12,
                blurRadius: 4,
                offset: const Offset(0, 2))
          ]),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _buildVoucher('Level', 'Classic', isBold: true),
          _buildDivider(),
          _buildVoucher('Points', '0'),
          _buildDivider(),
          SectionWithIcon(
              title: 'Vouchers',
              value: '0',
              icon: 'assets/icon/coupunicon.svg'),
          _buildDivider(),
          SectionWithIcon(
              title: 'Coupons', value: '0', icon: 'assets/icon/discount.svg')
        ],
      ),
    );
  }

  // build section without an icon
  Widget _buildVoucher(String title, String value, {bool isBold = false}) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          title,
          style: TextStyle(
            fontFamily: "Montserrat-Medium",
            fontSize: 12,
            letterSpacing: 0.12,
            color: Color(0xff6A958C),
          ),
        ),
        SizedBox(height: 4),
        Text(
          value,
          style: TextStyle(
              fontFamily: "Montserrat-SemiBold",
              fontSize: 12,
              letterSpacing: 0.12,
              color: Colors.black),
        )
      ],
    );
  }

  // for divider
  Widget _buildDivider() {
    return Container(
      height: 37,
      width: 1,
      color: Colors.black,
    );
  }

  // image slider box
  Widget adsSlider() {
    return Container(
      decoration: BoxDecoration(
          border: Border(top: BorderSide(color: Colors.black)),
          boxShadow: [
            BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 3,
                offset: const Offset(3, 2))
          ]),
      child: CarouselSlider.builder(
        itemCount: listmoviefirst.length,
        itemBuilder: (context, index, realIndex) {
          final movie = listmoviefirst[index];
          return Stack(
            fit: StackFit.expand,
            children: [
              Image.asset(
                movie.images,
                fit: BoxFit.cover,
              ),
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
              )
            ],
          );
        },
        options: CarouselOptions(
            autoPlay: true,
            enlargeCenterPage: true,
            aspectRatio: 16 / 9,
            viewportFraction: 1.0),
      )
    );
  }

  // list popular movie
  Widget popularMovie() {
    return Container(
      margin: const EdgeInsets.only(top: 10),
      decoration: BoxDecoration(
          border: Border(top: BorderSide(color: Colors.black)),
          boxShadow: [
            BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 3,
                offset: const Offset(3, 2))
          ]),
      child: Container(
        height: 412,
        width: 450,
        color: Color(0xffA7D4CB),
        padding: EdgeInsets.fromLTRB(12, 7, 12, 14),
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
                    "Explore Movies",
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
                          // decoration: TextDecoration.underline,
                          // decorationColor: Colors.white,
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
        width: 200,
        margin: EdgeInsets.only(right: 10, bottom: 10),
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
          // shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          // clipBehavior: Clip.antiAlias,
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
                      height: 220,
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
                      padding: EdgeInsets.all(12),
                      height: 60,
                      width: double.infinity,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            margin: EdgeInsets.fromLTRB(0, 8, 0, 5),
                            child: Text(
                              movie.moviename,
                              style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w700,
                                  fontFamily: "Montserrat",
                                  letterSpacing: 0.12),
                            ),
                          ),
                          SizedBox(height: 4),
                          Text(
                            movie.genre,
                            style: TextStyle(
                              fontSize: 14,
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
              Positioned(
                top: 10,
                right: 10,
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                  decoration: BoxDecoration(
                      color: Color.fromARGB(255, 220, 85, 94),
                      borderRadius: BorderRadius.circular(8)),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.star_border_rounded,
                        color: Colors.white,
                        size: 16,
                      ),
                      SizedBox(width: 4),
                      Text(
                        movie.rate,
                        style: TextStyle(
                            color: Color(0xffFFFDF7),
                            fontFamily: "Montserrat-SemiBold",
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 0.12),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        )
        // ),
        );
  }

 // Now Showing Panel
  void nowShowingMovies(BuildContext context) {
    showGeneralDialog(
      context: context,
      barrierDismissible: true,
      barrierLabel: "BlurredDialog",
      transitionDuration: Duration(milliseconds: 190),
      pageBuilder: (context, anim1, anim2) {
        return Stack(
          children: [
            // Static blur background
            Positioned.fill(
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
                child: Container(
                  color: Color.fromARGB(255, 255, 253, 247).withOpacity(0.58),
                ),
              ),
            ),

            // The Page
            Align(
              alignment: Alignment.bottomCenter,

              // Page as Animation
              child: SlideTransition(
                position: Tween<Offset>(
                  begin: Offset(0, 1), // Start from bottom
                  end: Offset(0, 0), // End at center
                ).animate(CurvedAnimation(
                  parent: anim1,
                  curve: Curves.easeOut, // Smooth animation curve
                )),
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.9,
                  width: MediaQuery.of(context).size.width * 0.95,
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Color(0xffFFFDF7),
                    border: Border.all(
                      color: const Color.fromARGB(255, 14, 37, 34),
                      width: 1.2,
                    ),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(8),
                      topRight: Radius.circular(8),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // The Bar
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          //Title
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              "Choose a Movie",
                              style: TextStyle(
                                fontFamily: "Montserrat",
                                fontSize: 17,
                                fontWeight: FontWeight.w600,
                                color: Colors.black,
                                decorationThickness: 0,
                              ),
                            ),
                          ),
                          // icon
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: IconButton(
                              icon: Icon(Icons.close),
                              onPressed: () => Navigator.of(context).pop(),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 8),
                      Expanded(
                        child: GridView.builder(
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            crossAxisSpacing: 8,
                            mainAxisSpacing: 8,
                            childAspectRatio:
                                0.7, // Set a consistent aspect ratio
                          ),
                          itemCount: allmovie.length,
                          itemBuilder: (context, index) {
                            var movie = allmovie[index];
                            return GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => Moviedetail(
                                            movieTitle:
                                                allmovie[index].moviename,
                                            movieDescription:
                                                allmovie[index].synopsis,
                                            movieImage: allmovie[index].images,
                                            movieRating: allmovie[index].rate,
                                            movieYears: allmovie[index].years,
                                            movieDuration: allmovie[index].time,
                                            movieGenre: allmovie[index].genre,
                                            movieWatchlist:
                                                allmovie[index].watchlist)));
                              },
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(6),
                                child: Container(
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: AssetImage(movie.images),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}