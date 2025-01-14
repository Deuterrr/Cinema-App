import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';

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
  final String? movieImage;
  final String movieGenre;

  VerticalMovieCard({
    Key? key,
    required this.bigSize,
    required this.movieTitle,
    required this.movieImage,
    required this.movieGenre,
  }) : super(key: key);

  double get cardHeight => bigSize ? 342 : 227;
  double get imageHeight => bigSize ? 284 : 184;
  double get cardWidth => bigSize ? 211 : 144;
  double get imageWidth => bigSize ? 197 : 134;
  double get cardShadowDX => bigSize ? 3.4 : 2.8;
  double get cardShadowDY => bigSize ? 4.2 : 3.6;
  double get rightMargin => bigSize ? 12 : 6;
  double get borderWight => bigSize ? 2 : 1.6;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(8, 0, 0, 14),
      child: Container(
        padding: EdgeInsets.all((bigSize) ? 4 : 3.6),
        margin: EdgeInsets.only(right: rightMargin),
        height: cardHeight,
        width: cardWidth,
        decoration: BoxDecoration(
          color: Color(0xFFFFCD67), // Flat Orange
          borderRadius: BorderRadius.circular((bigSize) ? 8 : 6),
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
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Color(0xFF0E2522), // Black
                    width: borderWight,
                  ),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: (movieImage != null && movieImage!.isNotEmpty)
                    ? Image.network(
                        movieImage!,
                        fit: BoxFit.cover,
                        height: imageHeight,
                        width: imageWidth,
                      )
                    : SvgPicture.asset(
                        'assets/icon/not_found.svg',
                        fit: BoxFit.cover,
                        height: imageHeight,
                        width: imageWidth,
                      ),
              ),
            ),

            Container(
              padding: EdgeInsets.fromLTRB(6, 4, 6, 6),
              child: Column(
                children: [
                  Center(
                    child: 
                    Text(
                      movieTitle,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: 'Montserrat',
                        fontSize: (bigSize) ? 16 : 12,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF0E2522), // Black
                      ),
                      overflow: TextOverflow.ellipsis, // Adds the ellipsis
                      maxLines: 1, // Limits the text to one line
                    )
                  ),
                  SizedBox(height: (bigSize) ? 5 : 3),
                  Center(
                    child: Text(
                      movieGenre,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: 'Montserrat',
                        fontSize: (bigSize) ? 12 : 10,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF0E2522), // Black
                      )
                    )
                  )
                ],
              )
            )
          ],
        )
      )    
    );
  }
}