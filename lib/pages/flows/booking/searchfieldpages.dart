import 'package:cinema_application/data/models/listmovie.dart';
import 'package:cinema_application/pages/flows/booking/detailmoviepages.dart';
import 'package:cinema_application/widgets/customappbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Searchfieldpages extends StatefulWidget {
  const Searchfieldpages({super.key});

  @override
  State<Searchfieldpages> createState() => _SearhfieldpagesState();
}

class _SearhfieldpagesState extends State<Searchfieldpages> {
  final TextEditingController _controller = TextEditingController();
  bool _isEmptyText = true;
  List<AllMovie> allmovie = [];
  List<AllMovie> filteredMovie = [];

  @override
  void initState() {
    super.initState();

    // Inisialisasi daftar film
    try {
      allmovie = AllMovie.getList();
    } catch (e) {
      allmovie = [];
    }

    // Tambahkan listener pada controller untuk menangani input pencarian
    _controller.addListener(() {
      final query = _controller.text.toLowerCase(); // Ambil teks input
      final isEmptyNow = query.isEmpty;

      // Perbarui status _isEmptyText
      if (isEmptyNow != _isEmptyText) {
        setState(() {
          _isEmptyText = isEmptyNow;
        });
      }

      // Filter daftar film
      setState(() {
        if (!isEmptyNow) {
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
      backgroundColor: Color.fromARGB(255, 255, 253, 247),
      appBar: CustomAppBar(title: 'Search'),
      body: Column(
        children: [
          _searchField(),
          Expanded(
            child: _movieList(), // Tampilkan daftar film yang difilter
          ),
        ],
      ),
    );
  }

  Widget _searchField() {
    return Container(
      margin: const EdgeInsets.only(top: 30, left: 20, right: 20, bottom: 20),
      decoration: BoxDecoration(
        color: Color.fromARGB(255, 255, 253, 247),
      ),
      child: Row(
        children: [
          Flexible(
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              width: _isEmptyText ? 500 : 500,
              child: TextField(
                controller: _controller,
                decoration: InputDecoration(
                  hintText: "Search",
                  hintStyle: const TextStyle(fontSize: 14),
                  filled: true,
                  fillColor: const Color.fromRGBO(236, 185, 75, 1),
                  contentPadding: const EdgeInsets.all(14),
                  suffixIcon: _isEmptyText
                      ? Padding(
                          padding: const EdgeInsets.only(right: 10),
                          child: SvgPicture.asset(
                            'assets/icon/Search.svg',
                            width: 15,
                            height: 15,
                          ),
                        )
                      : Padding(
                          padding: const EdgeInsets.only(right: 10),
                          child: GestureDetector(
                            onTap: () {
                              _controller.clear();
                            },
                            child: const Icon(Icons.cancel),
                          )),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: const BorderSide(
                      color: Color.fromARGB(255, 6, 6, 6),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
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
            // color: Colors.black.withOpacity(0.1),
            //blurRadius: 10,
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
