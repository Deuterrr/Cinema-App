import 'package:cinema_application/widgets/searchfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:cinema_application/data/models/listmovie.dart';
import 'package:cinema_application/pages/flows/booking/detailmoviepages.dart';
import 'package:cinema_application/widgets/customappbar.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => SearchPageState();
}

class SearchPageState extends State<SearchPage> {
  final TextEditingController _controller = TextEditingController();
  bool _isEmptyText = true;
  List<AllMovie> allmovie = [];
  List<AllMovie> filteredMovie = [];

  @override
  void initState() {
    super.initState();

    // list of movies (masih development, pakai dari app bukan db)
    try {
      allmovie = AllMovie.getList();
    } catch (e) {
      allmovie = [];
    }

    _controller.addListener(() {
      final query = _controller.text.toLowerCase();
      final isQueryEmpty = query.isEmpty;

      if (isQueryEmpty != _isEmptyText) {
        setState(() {
          _isEmptyText = isQueryEmpty;
        });
      }

      setState(() {
        if (!isQueryEmpty) {
          filteredMovie = allmovie.where((movie) {
            return movie.moviename.toLowerCase().startsWith(query);
          }).toList();
        } else {
          filteredMovie = [];
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFFFFFF), // White
      appBar: CustomAppBar(showBottomBorder: false),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
        children: [
          SizedBox(height: 6),
          SearchField(
            controller: _controller,
            isEmptyText: _isEmptyText,
            suffixIcon: _isEmptyText,
          ),
          SizedBox(height: 22),
          Expanded(
            child: _movieList(), // Tampilkan daftar film yang difilter
          ),
        ],
      ),
      )
    );
  }

  Widget _movieCard(AllMovie movie) {
    return Container(
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xffF7C14D), // Match the yellow background
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.black),
        boxShadow: [
          BoxShadow(
            offset: const Offset(3, 5),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start, // Align items to the top
        children: [
          // Movie Poster
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.asset(
              movie.images,
              height: 140,
              width: 100,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(width: 16), // Adjust spacing
          // Movie Details
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Genre Row (Top, beside the poster)
                Row(
                  children: [
                    SvgPicture.asset(
                      'assets/icon/film.svg',
                      height: 16,
                      width: 16,
                    ),
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
                    const Spacer(),
                    Container(
                      padding:
                          EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                      decoration: BoxDecoration(
                          color: Color(0xffDC555E),
                          borderRadius: BorderRadius.circular(8)),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          SvgPicture.asset('assets/icon/star.svg'),
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
                  ],
                ),
                const SizedBox(height: 8), // Space below the genre row
                // Movie Name
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
                // Additional Details (Duration, Rating, etc.)
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
                          color: Colors.transparent,
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: Colors.black)),
                      child: Text(
                        movie.rating, // Example: "PG-13"
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: Colors.black54,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                // Rating
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _movieList() {
    if (_isEmptyText) {
      return Center();
    }

    if (filteredMovie.isEmpty) {
      // If no movies match the search query, show "not found" message
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              'assets/icon/not_found.svg',
              height: 120,
            ),
            const SizedBox(height: 16),
            Text(
              "We Are Sorry, We Can Not Find '${_controller.text}' :(",
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              "Double check your search word spelling, or try another word",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey,
              ),
            ),
          ],
        ),
      );
    }

    // If movies are found, display the list
    return ListView.builder(
      itemCount: filteredMovie.length,
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => Moviedetail(
                  movieTitle: filteredMovie[index].moviename,
                  movieDescription: filteredMovie[index].synopsis,
                  movieImage: filteredMovie[index].images,
                  movieRating: filteredMovie[index].rate,
                  movieYears: filteredMovie[index].years,
                  movieDuration: filteredMovie[index].time,
                  movieGenre: filteredMovie[index].genre,
                  movieWatchlist: filteredMovie[index].watchlist,
                ),
              ),
            );
          },
          child: _movieCard(filteredMovie[index]),
        );
      },
    );
  }
}
