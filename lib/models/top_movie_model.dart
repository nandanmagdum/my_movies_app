class TopRatedMovieModel {
  final String title;
  final String image_url;
  final int rank;
  final String rating;
  final String year;
  final String imdbid;

  TopRatedMovieModel({required this.title, required this.image_url, required this.rank, required this.rating, required this.year, required this.imdbid});

  factory TopRatedMovieModel.fromJson(Map<String, dynamic> json) {
    return TopRatedMovieModel(
      title: json['title'] as String, 
      image_url: json['image'] as String, 
      rank: json['rank'] as int, 
      rating: json['rating'] as String, 
      year: json['year'].toString(),
      imdbid: json['imdbid'] as String
      );
  }
}