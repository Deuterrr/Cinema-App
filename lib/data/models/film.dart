class MovieList {
  String images;
  String nameMovie;

  MovieList({
    required this.images,
    required this.nameMovie,
  });

  // data
  static List<MovieList> getList() {
    List<MovieList> firstlist = [];

    firstlist.add(MovieList(
      images: 'assets/images/blackpanther.jpeg',
      nameMovie: 'Black Panther : \nWakanda Forever',
    ));

    firstlist.add(MovieList(
      images: 'assets/images/spiderman.jpg',
      nameMovie: 'Spider-Man No Way Home',
    ));

    firstlist.add(MovieList(
      images: 'assets/images/agaklaen.jpg',
      nameMovie: 'Agak Laen',
    ));

    firstlist.add(MovieList(
        images: 'assets/images/13bomdijakarta.webp',
        nameMovie: "13 Bom \ndi Jakarta"));

    return firstlist;
  }
}
