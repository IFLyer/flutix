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
                              Container(
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
        )
      ],
    );
  }
}
