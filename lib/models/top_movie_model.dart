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
      title: json['title'] ?? "", 
      image_url: json['image'] ?? "", 
      rank: json['rank'] ?? 0, 
      rating: json['rating'] ?? "", 
      year: json['year'].toString(),
      imdbid: json['imdbid'] ?? ""
      );
  }
}