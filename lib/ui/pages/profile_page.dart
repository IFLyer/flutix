part of 'pages.dart';

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
                color: Colors.white,
              ),
            ),
            ListView(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: EdgeInsets.only(
                          top: 20, left: defaultMargin, bottom: 30),
                      child: GestureDetector(
                        child: Icon(Icons.arrow_back),
                        onTap: () {
                          context.bloc<PageBloc>().add(GoToMainPage());
                        },
                      ),
                    ),
                    BlocBuilder<UserBloc, UserState>(builder: (context, state) {
                      return state is UserLoaded
                          ? Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: defaultMargin),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                    width: 120,
                                    height: 120,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      image: DecorationImage(
                                        image: state.user.profilePicture != null
                                            ? NetworkImage(
                                                state.user.profilePicture)
                                            : AssetImage("assets/user_pic.png"),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 10),
                                  Container(
                                    width:
                                        MediaQuery.of(context).size.width - 48,
                                    child: Text(
                                      state.user.name,
                                      style: blackTextFont.copyWith(
                                          fontSize: 18,
                                          fontWeight: mediumFontWeight),
                                      maxLines: 1,
                                      overflow: TextOverflow.clip,
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                  SizedBox(height: 8),
                                  Text(
                                    state.user.email,
                                    style: greyTextFont.copyWith(
                                        fontSize: 16,
                                        fontWeight: lightFontWeight),
                                  ),
                                  SizedBox(height: 30),
                                  Column(
                                    children: [
                                      Row(
                                        children: <Widget>[
                                          SizedBox(
                                              width: 24,
                                              height: 24,
                                              child: Image.asset(
                                                  "assets/edit_profile.png")),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Text(
                                            "Edit Profile",
                                            style: blackTextFont.copyWith(
                                                fontSize: 16),
                                          )
                                        ],
                                      ),
                                      Container(
                                        margin: EdgeInsets.only(
                                            top: 10, bottom: 16),
                                        child: generateDashedDivider(
                                            MediaQuery.of(context).size.width -
                                                2 * defaultMargin),
                                      ),
                                      Row(
                                        children: <Widget>[
                                          SizedBox(
                                              width: 24,
                                              height: 24,
                                              child: Image.asset(
                                                  "assets/my_wallet.png")),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Text(
                                            "My Wallet",
                                            style: blackTextFont.copyWith(
                                                fontSize: 16),
                                          )
                                        ],
                                      ),
                                      Container(
                                        margin: EdgeInsets.only(
                                            top: 10, bottom: 16),
                                        child: generateDashedDivider(
                                            MediaQuery.of(context).size.width -
                                                2 * defaultMargin),
                                      ),
                                      Row(
                                        children: <Widget>[
                                          SizedBox(
                                              width: 24,
                                              height: 24,
                                              child: Image.asset(
                                                  "assets/language.png")),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Text(
                                            "Change Language",
                                            style: blackTextFont.copyWith(
                                                fontSize: 16),
                                          )
                                        ],
                                      ),
                                      Container(
                                        margin: EdgeInsets.only(
                                            top: 10, bottom: 16),
                                        child: generateDashedDivider(
                                            MediaQuery.of(context).size.width -
                                                2 * defaultMargin),
                                      ),
                                      Row(
                                        children: <Widget>[
                                          SizedBox(
                                              width: 24,
                                              height: 24,
                                              child: Image.asset(
                                                  "assets/help_centre.png")),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Text(
                                            "Help Centre",
                                            style: blackTextFont.copyWith(
                                                fontSize: 16),
                                          )
                                        ],
                                      ),
                                      Container(
                                        margin: EdgeInsets.only(
                                            top: 10, bottom: 16),
                                        child: generateDashedDivider(
                                            MediaQuery.of(context).size.width -
                                                2 * defaultMargin),
                                      ),
                                      Row(
                                        children: <Widget>[
                                          SizedBox(
                                              width: 24,
                                              height: 24,
                                              child: Image.asset(
                                                  "assets/rate.png")),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Text(
                                            "Rate Flutix App",
                                            style: blackTextFont.copyWith(
                                                fontSize: 16),
                                          )
                                        ],
                                      ),
                                      Container(
                                        margin: EdgeInsets.only(
                                            top: 10, bottom: 16),
                                        child: generateDashedDivider(
                                            MediaQuery.of(context).size.width -
                                                2 * defaultMargin),
                                      ),
                                      GestureDetector(
                                        onTap: () async {
                                          await AuthServices.signOut();
                                          context
                                              .bloc<UserBloc>()
                                              .add(SignOutUser());
                                        },
                                        child: Row(
                                          children: <Widget>[
                                            SizedBox(
                                                width: 24,
                                                height: 24,
                                                child: Stack(
                                                  children: <Widget>[
                                                    Container(
                                                      margin:
                                                          EdgeInsets.fromLTRB(
                                                              5, 3, 9, 3),
                                                      color: accentColor2,
                                                    ),
                                                    Icon(
                                                      MdiIcons.logout,
                                                      color: mainColor,
                                                      size: 24,
                                                    ),
                                                  ],
                                                )),
                                            SizedBox(
                                              width: 10,
                                            ),
                                            Text(
                                              "Sign Out",
                                              style: blackTextFont.copyWith(
                                                  fontSize: 16),
                                            )
                                          ],
                                        ),
                                      ),
                                      Container(
                                        margin: EdgeInsets.only(
                                            top: 10, bottom: 16),
                                        child: generateDashedDivider(
                                            MediaQuery.of(context).size.width -
                                                2 * defaultMargin),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            )
                          : SpinKitFadingCircle(
                              color: accentColor2,
                              size: 50,
                            );
                    }),
                  ],
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
