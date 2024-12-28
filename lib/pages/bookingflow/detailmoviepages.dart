import 'package:cinema_application/pages/bookingflow/bookingseats.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Moviedetail extends StatefulWidget {
  final String movieTitle;
  final String movieDescription;
  final String movieImage;
  final String movieRating;
  final String movieYears;
  final String movieDuration;
  final String movieGenre;
  final String movieWatchlist;

  const Moviedetail(
      {super.key,
      required this.movieTitle,
      required this.movieDescription,
      required this.movieImage,
      required this.movieRating,
      required this.movieYears,
      required this.movieDuration,
      required this.movieGenre,
      required this.movieWatchlist});

  @override
  State<Moviedetail> createState() => _MoviedetailState();
}

class _MoviedetailState extends State<Moviedetail> {
  bool isExpanded = false;
  int? selectedIndex;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[

            // Movie Banner Image
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
                    child: 
                    Row(
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
                                      text: widget.movieYears),
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
                                  color: const Color.fromARGB(255, 245, 240, 224),
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
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 12.0), // Add padding for spacing
                                      child: buildSectionWithAnIcon(
                                        'Rating',
                                        widget.movieRating,
                                        'assets/icon/star2.svg',
                                      ),
                                    ),
                                    buildDivider(),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          right: 12.0), // Add padding for spacing
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
                      color: Color.fromARGB(255, 167, 212, 203),
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
                            style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
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
            const SizedBox(height: 13),

            // Schedule Section
            Container(
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(color: Colors.black),
                ),
              ),
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Title
                  Text(
                    "Show",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.start,
                  ),
                  SizedBox(height: 12),

                  // Date Selector Row
                  Container(
                    decoration: BoxDecoration(
                      color: Color(0xffF5F0E0),
                      borderRadius: BorderRadius.circular(8),
                      border: Border(
                          top: BorderSide(color: Colors.black),
                          left: BorderSide(color: Colors.black),
                          bottom: BorderSide(color: Colors.black),
                          right: BorderSide(color: Colors.black)),
                    ),
                    padding:
                        const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: List.generate(7, (index) {
                        final DateTime today = DateTime.now();
                        final DateTime date = today.add(Duration(days: index));
                        final isSelected = selectedIndex == index;

                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              selectedIndex =
                                  index; // Update the selected index
                            });
                          },
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Container(
                                padding: const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  color: isSelected
                                      ? const Color.fromARGB(255, 253, 253, 253)
                                      : Colors.transparent,
                                  borderRadius: isSelected
                                      ? BorderRadius.circular(8)
                                      : null,
                                  border: isSelected
                                      ? Border(
                                          top: BorderSide(color: Colors.black),
                                          left: BorderSide(color: Colors.black),
                                          right:
                                              BorderSide(color: Colors.black),
                                          bottom:
                                              BorderSide(color: Colors.black),
                                        )
                                      : Border(
                                          left: BorderSide(color: Colors.black),
                                          right:
                                              BorderSide(color: Colors.black),
                                          top: BorderSide
                                              .none, // or any other default border
                                          bottom: BorderSide
                                              .none, // or any other default border
                                        ),
                                ),
                                child: Column(
                                  children: [
                                    Text(
                                      date.day.toString(),
                                      style: TextStyle(
                                        color: isSelected
                                            ? const Color.fromARGB(
                                                255, 255, 0, 0)
                                            : Colors.black,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                      ),
                                    ),
                                    Text(
                                      [
                                        "Mon",
                                        "Tue",
                                        "Wed",
                                        "Thu",
                                        "Fri",
                                        "Sat",
                                        "Sun"
                                      ][date.weekday - 1],
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: isSelected
                                            ? const Color.fromARGB(
                                                255, 255, 6, 6)
                                            : Colors.black54,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(height: 4),
                            ],
                          ),
                        );
                      }),
                    ),
                  ),
                  SizedBox(height: 16),

                  // Theater and Showtimes Section
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Theater Name
                      Container(
                        width: double.infinity, // Full-width container
                        padding: EdgeInsets.all(16), // Inner padding
                        decoration: BoxDecoration(
                          color: Color(0xffF5F0E0), // Light background color
                          borderRadius:
                              BorderRadius.circular(8), // Rounded corners
                          border: Border(
                              top: BorderSide(color: Colors.black),
                              left: BorderSide(color: Colors.black),
                              bottom: BorderSide(color: Colors.black),
                              right: BorderSide(color: Colors.black)),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black12,
                              blurRadius: 4,
                              offset: Offset(2, 2), // Shadow offset
                            ),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Theater Name
                            Text(
                              "Aeon Mall JGC",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 8),

                            // Ticket Type and Price
                            Row(
                              children: [
                                Text(
                                  "REGULER",
                                  style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold),
                                ),
                                SizedBox(
                                  width: 4,
                                ),
                                Text(
                                  "From Rp. 55.000",
                                  style: TextStyle(
                                      color: Colors.black54, fontSize: 12),
                                )
                              ],
                            ),
                            SizedBox(height: 16),

                            // Showtimes
                            Wrap(
                              spacing: 8,
                              runSpacing: 8,
                              children: List.generate(4, (index) {
                                return GestureDetector(
                                  onTap: () {
                                    Navigator.push(context, MaterialPageRoute(builder: (context) => BookingSeats()));
                                  },
                                  child: Container(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 16, vertical: 8),
                                    decoration: BoxDecoration(
                                        color:
                                            Color(0xFFFFD54F), // Button color
                                        borderRadius: BorderRadius.circular(
                                            8), // Rounded corners
                                        border:
                                            Border.all(color: Colors.black87),
                                        boxShadow: [
                                          BoxShadow(offset: Offset(1, 2))
                                        ]),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "16:20 - 18:28",
                                          style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black,
                                          ),
                                        ),
                                        SizedBox(height: 4),
                                        Text(
                                          "178/178 Seat",
                                          style: TextStyle(
                                            fontSize: 12,
                                            color: Colors.black54,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              }),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  // for an icon below the Title
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
