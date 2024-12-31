import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class UpcomingDetail extends StatefulWidget {
  final String movieTitle;
  final String movieDescription;
  final String movieImage;
  final String movieYear;
  final String movieGenre;
  final String movieRating;
  final String movieWatchlist;
  final String movieDuration;

  const UpcomingDetail(
      {super.key,
      required this.movieTitle,
      required this.movieDescription,
      required this.movieImage,
      required this.movieGenre,
      required this.movieYear,
      required this.movieDuration,
      required this.movieRating,
      required this.movieWatchlist});

  @override
  State<UpcomingDetail> createState() => _UpcomingDetailState();
}

class _UpcomingDetailState extends State<UpcomingDetail> {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBodyBehindAppBar: true,
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
            child: Column(
          children: <Widget>[
            Stack(
              children: [
                Container(
                  width: double.infinity,
                  height: 220,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(
                          widget.movieImage), // Use NetworkImage for URLs
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Positioned(
                  top: 20,
                  left: 16,
                  child: Container(
                    margin: const EdgeInsets.symmetric(
                        horizontal: 0, vertical: 13.5),
                    width: 36,
                    height: 40,
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
                        Navigator.pop(context);
                      },
                      icon: const Icon(
                        Icons.arrow_back_ios_new_rounded,
                        color: Color.fromARGB(255, 14, 37, 34),
                        size: 18,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            // Movie Details
            Padding(
              padding: const EdgeInsets.all(0.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // container title, rate, and wishlist
                  Container(
                    padding: const EdgeInsets.fromLTRB(16, 18, 16, 6),
                    child: Row(
                      children: [
                        // Movie Poster
                        Container(
                          width: 100,
                          height: 150,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            image: DecorationImage(
                              image: AssetImage(widget.movieImage),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        const SizedBox(width: 16),
                        // Movie Info
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                widget.movieTitle,
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: 8),
                              Row(
                                children: [
                                  // For calendar
                                  buildIconTextRow(
                                      iconPath: 'assets/icon/calendar.svg',
                                      text: widget.movieYear),
                                  SizedBox(width: 5),
                                  Text(' | '),
                                  SizedBox(width: 5),
                                  buildIconTextRow(
                                      iconPath: 'assets/icon/clock.svg',
                                      text: '${widget.movieDuration} Min'),
                                  SizedBox(width: 5),
                                  Text(' | '),
                                  SizedBox(width: 5),
                                  buildIconTextRow(
                                      iconPath: 'assets/icon/film.svg',
                                      text: widget.movieGenre),
                                ],
                              ),
                              SizedBox(height: 16),
                              Container(
                                width: 335,
                                height: 45,
                                decoration: BoxDecoration(
                                  color:
                                      const Color.fromARGB(255, 245, 240, 224),
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
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left:
                                              12.0), // Add padding for spacing
                                      child: buildSectionWithAnIcon(
                                        'Rating',
                                        widget.movieRating,
                                        'assets/icon/star2.svg',
                                      ),
                                    ),
                                    buildDivider(),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          right:
                                              12.0), // Add padding for spacing
                                      child: buildSectionWithAnIcon(
                                        'Watchlist',
                                        widget.movieWatchlist,
                                        'assets/icon/heart.svg',
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  Container(
                    padding: const EdgeInsets.fromLTRB(16, 14, 16, 16),
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      color: Color(0xffA7D4CB),
                      border: Border(
                        top: BorderSide(color: Colors.black),
                        bottom: BorderSide(color: Colors.black),
                      ),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Synopsis",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                          textAlign: TextAlign.start,
                        ),
                        AnimatedSize(
                          duration: Duration(milliseconds: 300),
                          curve: Curves.easeInOut,
                          child: Text(
                            widget.movieDescription,
                            maxLines:
                                isExpanded ? null : 5, // Show 5 lines initially
                            overflow: TextOverflow.fade,
                            style: TextStyle(
                                fontSize: 14, fontWeight: FontWeight.w500),
                            textAlign: TextAlign.justify,
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            setState(() {
                              isExpanded = !isExpanded;
                            });
                          },
                          child: Text(
                            isExpanded ? "Read Less" : "Read More",
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ],
        )));
  }

  Widget buildIconTextRow({required String iconPath, required String text}) {
    return Row(
      children: [
        SvgPicture.asset(iconPath),
        SizedBox(width: 4),
        Text(text),
      ],
    );
  }

  Widget buildSectionWithAnIcon(String title, String value, String icon) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.only(right: 8),
          child: SvgPicture.asset(
            icon,
            width: 30,
            height: 28,
            fit: BoxFit.contain,
          ),
        ),
        SizedBox(
          height: 4,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              title,
              style: TextStyle(
                  fontFamily: "Montserrat-Medium",
                  fontSize: 12,
                  letterSpacing: 0.12,
                  color: Colors.black),
            ),
            Text(
              value,
              style: TextStyle(
                  fontFamily: "Montserrat-SemiBold",
                  color: Color.fromARGB(255, 0, 0, 0),
                  letterSpacing: 0.12,
                  fontWeight: FontWeight.bold,
                  fontSize: 14),
            )
          ],
        )
      ],
    );
  }

  Widget buildDivider() {
    return Container(
      height: 37,
      width: 1,
      color: Colors.black,
    );
  }
}
