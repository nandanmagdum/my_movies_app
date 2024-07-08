class MovieDetailsModel {
  final String Title;
  final String Year;
  final String Rated;
  final String Released;
  final String Runtime;
  final String Genre;
  final String Director;
  final String Writer;
  final String Actors;
  final String Plot;
  final String Language;
  final String Country;
  final String Awards;
  final String Poster;
  final String Metascore;
  final String imdbRating;
  final String imdbVotes;
  final String imdbID;
  final String Type;
  final String DVD;
  final String BoxOffice;
  final String Production;
  final String Website;
  final String Response;

  MovieDetailsModel(
      {required this.Title,
      required this.Year,
      required this.Rated,
      required this.Released,
      required this.Runtime,
      required this.Genre,
      required this.Director,
      required this.Writer,
      required this.Actors,
      required this.Plot,
      required this.Language,
      required this.Country,
      required this.Awards,
      required this.Poster,
      required this.Metascore,
      required this.imdbRating,
      required this.imdbVotes,
      required this.imdbID,
      required this.Type,
      required this.DVD,
      required this.BoxOffice,
      required this.Production,
      required this.Website,
      required this.Response});

  factory MovieDetailsModel.fromJson(Map<String, dynamic> json) {
    return MovieDetailsModel(
        Title: json['Title'],
        Year: json['Year'],
        Rated: json['Rated'],
        Released: json['Released'],
        Runtime: json['Runtime'],
        Genre: json['Genre'],
        Director: json['Director'],
        Writer: json['Writer'],
        Actors: json['Actors'],
        Plot: json['Plot'],
        Language: json['Language'],
        Country: json['Country'],
        Awards: json['Awards'],
        Poster: json['Poster'],
        Metascore: json['Metascore'],
        imdbRating: json['imdbRating'],
        imdbVotes: json['imdbVotes'],
        imdbID: json['imdbID'],
        Type: json['Type'],
        DVD: json['DVD'],
        BoxOffice: json['BoxOffice'],
        Production: json['Production'],
        Website: json['Website'],
        Response: json['Response']);
  }
}
