part of 'pages.dart';

class MoviePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        Container(
          decoration: BoxDecoration(
            color: accentColor1,
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20)),
          ),
          padding: EdgeInsets.fromLTRB(defaultMargin, 20, defaultMargin, 30),
          child: BlocBuilder<UserBloc, UserState>(
            builder: (context, state) {
              if (state is UserLoaded) {
                if (imageFileToUpload != null) {
                  uploadImage(imageFileToUpload).then((value) {
                    imageFileToUpload = null;
                    context
                        .bloc<UserBloc>()
                        .add(UpdateDataUser(profileImage: value));
                  });
                }
              }
              return state is UserLoaded
                  ? Row(
                      children: <Widget>[
                        Container(
                          padding: EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(color: Color(0xff5F558B)),
                          ),
                          child: Stack(
                            children: <Widget>[
                              SpinKitFadingCircle(
                                color: accentColor2,
                                size: 50,
                              ),
                              GestureDetector(
                                onTap: () {
                                  context
                                      .bloc<PageBloc>()
                                      .add(GoToProfilePage());
                                },
                                child: Container(
                                  width: 50,
                                  height: 50,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    image: DecorationImage(
                                        image: state.user.profilePicture == ""
                                            ? AssetImage("assets/user_pic.png")
                                            : NetworkImage(
                                                state.user.profilePicture),
                                        fit: BoxFit.cover),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                        SizedBox(
                          width: 16,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            SizedBox(
                              width: MediaQuery.of(context).size.width - 2 * 78,
                              child: Text(
                                state.user.name,
                                style: whiteTextFont.copyWith(fontSize: 18),
                                maxLines: 1,
                                overflow: TextOverflow.clip,
                              ),
                            ),
                            Text(
                              NumberFormat.currency(
                                      locale: "id_ID",
                                      decimalDigits: 0,
                                      symbol: "IDR ")
                                  .format(state.user.balance),
                              style: yellowNumberFont.copyWith(
                                  fontSize: 14, fontWeight: regularFontWeight),
                            )
                          ],
                        )
                      ],
                    )
                  : SpinKitFadingCircle(
                      color: accentColor2,
                      size: 50,
                    );
            },
          ),
        ),
        Container(
          padding: EdgeInsets.fromLTRB(defaultMargin, 30, defaultMargin, 12),
          child: Text(
            "Now Playing",
            style: blackTextFont.copyWith(fontSize: 16),
          ),
        ),
        SizedBox(
          height: 140,
          child: BlocBuilder<MovieBloc, MovieState>(
            builder: (context, state) {
              if (state is MovieLoaded) {
                List<Movie> movies = state.movies.sublist(0, 10);
                return ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: movies.length,
                  itemBuilder: (_, index) => Padding(
                    padding: EdgeInsets.only(
                        left: (index == 0) ? defaultMargin : 0,
                        right:
                            (index == movies.length - 1) ? defaultMargin : 16),
                    child: MovieBanner(
                      movies[index],
                      onTap: () {
                        context
                            .bloc<PageBloc>()
                            .add(GoToMovieDetailPage(movies[index]));
                      },
                    ),
                  ),
                );
              }
              return SpinKitFadingCircle(
                color: mainColor,
                size: 50,
              );
            },
          ),
        ),
        Container(
          padding: EdgeInsets.fromLTRB(defaultMargin, 30, defaultMargin, 12),
          child: Text(
            "Browse Movie",
            style: blackTextFont.copyWith(fontSize: 16),
          ),
        ),
        BlocBuilder<UserBloc, UserState>(
          builder: (context, state) {
            if (state is UserLoaded) {
              return Container(
                padding: EdgeInsets.symmetric(horizontal: defaultMargin),
                height: 68,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: state.user.selectedGenres
                      .map((e) => BrowseButton(name: e))
                      .toList(),
                ),
              );
            }
            return SpinKitFadingCircle(
              color: mainColor,
              size: 50,
            );
          },
        ),
        Container(
          padding: EdgeInsets.fromLTRB(defaultMargin, 30, defaultMargin, 12),
          child: Text(
            "Coming Soon",
            style: blackTextFont.copyWith(fontSize: 16),
          ),
        ),
        SizedBox(
          height: 140,
          child: BlocBuilder<MovieBloc, MovieState>(
            builder: (context, state) {
              if (state is MovieLoaded) {
                List<Movie> movies = state.movies.sublist(10);
                return ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: movies.length,
                  itemBuilder: (_, index) => Padding(
                    padding: EdgeInsets.only(
                        left: (index == 0) ? defaultMargin : 0,
                        right:
                            (index == movies.length - 1) ? defaultMargin : 16),
                    child: ComingSoonCard(
                      movie: movies[index],
                    ),
                  ),
                );
              }
              return SpinKitFadingCircle(
                color: mainColor,
                size: 50,
              );
            },
          ),
        ),
        Container(
          padding: EdgeInsets.fromLTRB(defaultMargin, 30, defaultMargin, 12),
          child: Text(
            "Get Lucky Day",
            style: blackTextFont.copyWith(fontSize: 16),
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: defaultMargin),
          child: Column(
            children: promoDummies
                .map((e) => Padding(
                      padding: EdgeInsets.only(bottom: 16),
                      child: PromoCard(promo: e),
                    ))
                .toList(),
          ),
        ),
        SizedBox(height: 88)
      ],
    );
  }
}
