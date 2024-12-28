class AllMovie {
  String moviename;
  String images;
  String rate;
  String genre;
  String time;
  String rating;
  String synopsis;
  String years;
  String watchlist;

  AllMovie(
      {required this.moviename,
      required this.images,
      required this.rate,
      required this.genre,
      required this.time,
      required this.rating,
      required this.synopsis,
      required this.years,
      required this.watchlist});

  static List<AllMovie> getList() {
    List<AllMovie> listing = [];

    listing.add(AllMovie(
        moviename: 'Black Panther : \nWakanda Forever',
        images: 'assets/images/blackpanther.jpeg',
        rate: '5.0',
        genre: 'Action',
        time: '161',
        rating: 'PG-13',
        synopsis:
            "As the new King of Wakanda, T’Challa (Chadwick Boseman) is still grappling with his feelings about the death of his father, T’Chaka. (John Kani). However, he then decided to continue his father's struggle. When Wakanda is threatened by two dangerous enemies that could jeopardize the safety of the nation, Black Panther strives to prove himself as the true king of Wakanda. He must use his new suit and strength to defend Wakanda and other nations.",
        years: '2022',
        watchlist: '16.09k'));

    listing.add(AllMovie(
        moviename: 'Spiderman : \nNo Way Home',
        images: 'assets/images/spidermanposter.jpg',
        rate: '4.0',
        genre: 'Action',
        time: '119',
        rating: 'PG-13',
        synopsis:
            "For the first time in Spider-Man's cinematic history, the true identity of this friendly neighborhood hero is revealed, causing his responsibilities as a super-powered individual to clash with his normal life, and putting all his closest loved ones in the most threatened position.",
        years: '2021',
        watchlist: '919k'));

    listing.add(AllMovie(
        moviename: '13 Bom \ndi Jakarta',
        images: 'assets/images/13bomdijakarta.webp',
        rate: '4.0',
        genre: 'Action',
        time: '143',
        rating: 'PG-13',
        synopsis:
            "A group of terrorists attempted to wreak havoc in Jakarta, the capital of Indonesia, with bomb attacks at thirteen different locations. The security forces, who were aware of the plan, tried to act quickly to prevent any casualties.",
        years: '2023',
        watchlist: '20.19k'));

    listing.add(AllMovie(
        moviename: 'Minions',
        images: 'assets/images/minionsposter.jpg',
        rate: '4.9',
        genre: 'Animation',
        time: '88',
        rating: 'PG-13',
        synopsis:
            "Otto managed to save Gru, who used the stone to turn the Vicious 6 into mice. The Vicious 6 were captured, including Knuckles, who was taken to the hospital and died from his injuries. At Knuckles' funeral, Gru delivered a heartfelt tribute speech, but it was revealed that Knuckles had faked his death.",
        years: '2024',
        watchlist: '31.35k'));

    listing.add(AllMovie(
        moviename: 'Home Sweet Loan',
        images: 'assets/images/homesweetloan.jpeg',
        rate: '5.0',
        genre: 'Drama',
        time: '155',
        rating: 'SU',
        synopsis:
            "Kaluna herself dreams of having her own house even though her salary is just enough to get by. However, Kaluna's salary has never reached two digits, making her feel that the desire to buy a house is just a dream. Nevertheless, Kaluna remains undeterred.",
        years: '2024',
        watchlist: '43.99k'));

    listing.add(AllMovie(
        moviename: 'Shaun the Sheep : \nFarmageddon',
        images: 'assets/images/shaunthesheep.jpg',
        rate: '4.3',
        genre: 'Animation',
        time: '87',
        rating: 'SU',
        synopsis:
            "Shaun the Sheep is back. This time, his adventure will take him to outer space. When a spaceship appears on the farm, Shaun meets an alien named Lu-La.",
        years: '2019',
        watchlist: '21.39k'));

    return listing;
  }

  static List<AllMovie> getUpcoming() {
    List<AllMovie> listing = [];

    listing.add(AllMovie(
        moviename: 'Superman',
        images: 'assets/images/supermanlegacy.jpg',
        rate: '-',
        genre: 'Action',
        time: '-',
        rating: '-',
        synopsis:
            "Superman, a cub reporter in Metropolis, struggles to balance his Kryptonian heritage with his human upbringing. He embodies truth, justice, and the American way, guided by human kindness in a world that sees kindness as old-fashioned. ",
        years: '2025',
        watchlist: '-'));

    listing.add(AllMovie(
        moviename: '2nd Miracle in Cell \nNo. 07',
        images: 'assets/images/2ndmiracle.jpeg',
        rate: '-',
        genre: 'Drama',
        time: '-',
        rating: '-',
        synopsis:
            "2nd Miracle in Cell No. 7 will continue the story of Kartika (Graciella Abigail) after losing her father, Dodo (Vino G. Bastian), who was sentenced to death. Two years have passed since the tragic event, and Kartika now lives with Hendro (Denny Sumargo) and Linda. (Agla Artalidia). The drama will center around Kartika's story, who continues to be smuggled into the cell to meet the inmates who are Dodo's friends. All parties agreed to hide the fact that Dodo had died in order to protect Kartika's feelings.",
        years: '2025',
        watchlist: "-"));

    return listing;
  }
}
