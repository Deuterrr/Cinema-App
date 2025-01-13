import 'package:flutter/widgets.dart';

class HorizontalMovieCard extends StatelessWidget {
  final String movieTitle;
  final String movieImage;
  final String movieGenre;

  HorizontalMovieCard({
    Key? key,
    required this.movieTitle,
    required this.movieImage,
    required this.movieGenre,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Color(0xFFFFD580), // Flat Orange
        borderRadius: BorderRadius.circular(8),
        boxShadow: const[
          BoxShadow(
            offset: Offset(0.8, 1.8),
            color: Color(0xFF000000),
          )
        ],
      ),
      child: Row(

      )
    );    
  }
}

class VerticalMovieCard extends StatelessWidget {
  final bool bigSize;
  final String movieTitle;
  final String movieImage;
  final String movieGenre;

  VerticalMovieCard({
    Key? key,
    required this.bigSize,
    required this.movieTitle,
    required this.movieImage,
    required this.movieGenre,
  }) : super(key: key);

  double get cardHeight => bigSize ? 352 : 220;
  double get cardWidth => bigSize ? 211 : 124;
  double get cardShadowDX => bigSize ? 2.2 : 1.6;
  double get cardShadowDY => bigSize ? 3 : 2.6;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(6),
      height: cardHeight,
      width: cardWidth,
      decoration: BoxDecoration(
        color: Color(0xFFFFD580), // Flat Orange
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            offset: Offset(cardShadowDX, cardShadowDY),
            color: Color(0xFF0E2522), // Black
          )
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          ClipRRect(
            borderRadius: BorderRadius.circular(6),
            child: Image.asset(
              movieImage,
              fit: BoxFit.cover,
              height: (bigSize) ? 294 : 163,
              width: double.infinity,
            ),
          ),

          Expanded(
            child: Container(
              padding: EdgeInsets.fromLTRB(6, 4, 6, 6),
              child: Column(
                children: [
                  Text(
                    movieTitle,
                    style: TextStyle(
                      fontFamily: 'Montserrat',
                      fontSize: (bigSize) ? 12 : 11,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF0E2522), // Black
                    )
                  ),
                  Text(
                    movieGenre,
                    style: TextStyle(
                      fontFamily: 'Montserrat',
                      fontSize: (bigSize) ? 8 : 7,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF0E2522), // Black
                    )
                  )
                ],
              ),
            )
          )
        ],
      )
    );    
  }
}