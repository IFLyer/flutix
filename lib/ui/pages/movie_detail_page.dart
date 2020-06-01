part of 'pages.dart';

class MovieDetailPage extends StatelessWidget {
  final Movie movie;
  MovieDetailPage(this.movie);
  @override
  Widget build(BuildContext context) {
    MovieDetail movieDetail;
    List<Credit> credits;

    return WillPopScope(
      onWillPop: () async {
        context.bloc<PageBloc>().add(GoToMainPage());
        return;
      },
      child: Scaffold(
        body: Stack(
          children: [
            Container(
              color: accentColor1,
            ),
            SafeArea(
              child: Container(
                color: Color(0xFFF6F7F9),
              ),
            ),
            FutureBuilder(
                future: MovieServices.getDetails(movie),
                builder: (_, snapshot) {
                  if (snapshot.hasData) {
                    movieDetail = snapshot.data;
                    return ListView(
                      children: [
                        Column(
                          children: [
                            Stack(
                              children: [
                                Container(
                                  height: 270,
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                        image: NetworkImage(imageBaseUrl +
                                                "w1280" +
                                                movie.backdropPath ??
                                            movie.posterPath),
                                        fit: BoxFit.cover),
                                  ),
                                ),
                                Container(
                                  height: 271,
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      begin: Alignment(0, 1),
                                      end: Alignment(0, 0.06),
                                      colors: [
                                        Colors.white,
                                        Colors.white.withOpacity(0)
                                      ],
                                    ),
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(
                                      top: 20, left: defaultMargin),
                                  padding: EdgeInsets.all(1),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                      color: Colors.black.withOpacity(0.04)),
                                  child: GestureDetector(
                                    onTap: () {
                                      context
                                          .bloc<PageBloc>()
                                          .add(GoToMainPage());
                                    },
                                    child: Icon(
                                      Icons.arrow_back,
                                      color: Colors.white,
                                    ),
                                  ),
                                )
                              ],
                            ),
                            SizedBox(height: 16),
                            Text(
                              movieDetail.title,
                              style: blackTextFont.copyWith(
                                  fontWeight: mediumFontWeight, fontSize: 24),
                            ),
                            SizedBox(height: 6),
                            Text(
                              movieDetail.genresAndLanguage,
                              style: greyTextFont.copyWith(
                                  fontSize: 12, fontWeight: regularFontWeight),
                            ),
                            SizedBox(height: 6),
                            RatingStars(
                              mainAxisAlignment: MainAxisAlignment.center,
                              voteAverage: movieDetail.voteAverage,
                              color: accentColor3,
                            ),
                            SizedBox(height: 24),
                            Align(
                              alignment: Alignment.topLeft,
                              child: Padding(
                                padding: EdgeInsets.only(
                                    left: defaultMargin, bottom: 12),
                                child: Text(
                                  "Cast & Crew",
                                  style: blackTextFont.copyWith(
                                      fontWeight: mediumFontWeight,
                                      fontSize: 14),
                                ),
                              ),
                            ),
                            FutureBuilder(
                              future: MovieServices.getCredits(movie.id),
                              builder: (_, snap) {
                                if (snap.hasData) {
                                  credits = snap.data;
                                  return SizedBox(
                                    height: 110,
                                    child: ListView.builder(
                                      scrollDirection: Axis.horizontal,
                                      itemCount: credits.length,
                                      itemBuilder: (_, index) => Padding(
                                        padding: EdgeInsets.only(
                                            left:
                                                index == 0 ? defaultMargin : 0,
                                            right: index == credits.length - 1
                                                ? 24
                                                : 12),
                                        child: CastCard(credits[index]),
                                      ),
                                    ),
                                  );
                                } else {
                                  return SizedBox(height: 110);
                                }
                              },
                            ),
                            SizedBox(height: 24),
                            Align(
                              alignment: Alignment.topLeft,
                              child: Padding(
                                padding: EdgeInsets.only(
                                    left: defaultMargin, bottom: 12),
                                child: Text(
                                  "Storyline",
                                  style: blackTextFont.copyWith(
                                      fontWeight: mediumFontWeight,
                                      fontSize: 14),
                                ),
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.fromLTRB(
                                  defaultMargin, 8, defaultMargin, 30),
                              child: Text(
                                movieDetail.overview,
                                textAlign: TextAlign.justify,
                                style: greyTextFont.copyWith(
                                    fontWeight: regularFontWeight,
                                    fontSize: 14,
                                    height: 1.4),
                              ),
                            ),
                            Container(
                              width: 250,
                              height: 45,
                              child: RaisedButton(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  color: mainColor,
                                  child: Text(
                                    "Continue to Book",
                                    style: whiteTextFont.copyWith(
                                        fontWeight: mediumFontWeight,
                                        fontSize: 16),
                                  ),
                                  onPressed: () {}),
                            ),
                            SizedBox(height: defaultMargin)
                          ],
                        )
                      ],
                    );
                  } else {
                    return SizedBox();
                  }
                }),
          ],
        ),
      ),
    );
  }
}
