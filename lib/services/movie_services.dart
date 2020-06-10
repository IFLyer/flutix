part of 'services.dart';

class MovieServices {
  static Future<List<Movie>> getMovies(int page, {http.Client client}) async {
    String url =
        "https://api.themoviedb.org/3/discover/movie?api_key=$apikey&language=en-US&sort_by=popularity.desc&include_adult=false&include_video=false&page=$page";
    client ??= http.Client();

    var response = await client.get(url);
    if (response.statusCode != 200) {
      return [];
    }

    var data = json.decode(response.body);
    print(data);
    List result = data['results'];

    return result.map((e) => Movie.fromJson(e)).toList();
  }

  static Future<MovieDetail> getDetails(Movie movie,
      {int movieID, http.Client client}) async {
    String url =
        "https://api.themoviedb.org/3/movie/${movieID ?? movie.id}?api_key=$apikey&language=en-US";
    client ??= http.Client();

    var response = await client.get(url);
    var data = json.decode(response.body);
    Iterable genres = data['genres'];
    String language;

    switch ((data)['original_language'].toString()) {
      case 'ja':
        language = "Japanese";
        break;
      case 'en':
        language = "English";
        break;
      case 'id':
        language = "Indonesian";
        break;
      case 'ko':
        language = "Korean";
        break;
    }
    return movieID != null
        ? MovieDetail(Movie.fromJson(data),
            language: language,
            genres: genres.map((e) => e['name'].toString()).toList())
        : MovieDetail(movie,
            language: language,
            genres: genres.map((e) => e['name'].toString()).toList());
  }

  static Future<List<Credit>> getCredits(int movieId,
      {http.Client client}) async {
    String url =
        "https://api.themoviedb.org/3/movie/$movieId/credits?api_key=$apikey";
    client ??= http.Client();

    var response = await client.get(url);
    var data = json.decode(response.body);

    return (data['cast'] as Iterable)
        .map((e) => Credit(name: e['name'], profilePath: e['profile_path']))
        .take(8)
        .toList();
  }
}
