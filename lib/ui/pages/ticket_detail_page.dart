part of 'pages.dart';

class TicketDetailPage extends StatelessWidget {
  final Ticket ticket;
  TicketDetailPage(this.ticket);
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        context.bloc<PageBloc>().add(GoToMainPage(
            bottomNavBarIndex: 1,
            isExpired: ticket.time.isBefore(DateTime.now())));
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
                color: Color(0xFFE5E5E5),
              ),
            ),
            ListView(
              children: [
                Stack(
                  children: [
                    Container(
                      margin: EdgeInsets.only(top: 20, left: defaultMargin),
                      padding: EdgeInsets.all(1),
                      child: GestureDetector(
                        onTap: () {
                          context.bloc<PageBloc>().add(GoToMainPage(
                              bottomNavBarIndex: 1,
                              isExpired: ticket.time.isBefore(DateTime.now())));
                        },
                        child: Icon(
                          Icons.arrow_back,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: defaultMargin),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(height: 20),
                          Text(
                            "Ticket Details",
                            style: blackTextFont.copyWith(
                              fontSize: 20,
                              fontWeight: mediumFontWeight,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(height: 20),
                          Container(
                            height: 170,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(8),
                                topRight: Radius.circular(8),
                              ),
                              image: DecorationImage(
                                  image: NetworkImage(imageBaseUrl +
                                      "w1280" +
                                      ticket.movieDetail.backdropPath),
                                  fit: BoxFit.cover),
                            ),
                          ),
                          ClipPath(
                            clipper: TicketTopClipper(),
                            child: Container(
                              color: Colors.white,
                              padding: EdgeInsets.fromLTRB(20, 16, 20, 0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    width:
                                        MediaQuery.of(context).size.width - 48,
                                    child: Text(
                                      ticket.movieDetail.title,
                                      style: blackTextFont.copyWith(
                                          fontWeight: mediumFontWeight,
                                          fontSize: 18),
                                      overflow: TextOverflow.clip,
                                      maxLines: 2,
                                    ),
                                  ),
                                  SizedBox(height: 6),
                                  Text(
                                    ticket.movieDetail.genresAndLanguage,
                                    style: greyTextFont.copyWith(
                                        fontWeight: regularFontWeight,
                                        fontSize: 12),
                                  ),
                                  SizedBox(height: 6),
                                  RatingStars(
                                    voteAverage: ticket.movieDetail.voteAverage,
                                    color: accentColor3,
                                  ),
                                  SizedBox(height: 16),
                                  Padding(
                                    padding: EdgeInsets.only(bottom: 8),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Cinema",
                                          style: greyTextFont.copyWith(
                                              fontWeight: regularFontWeight,
                                              fontSize: 16),
                                        ),
                                        SizedBox(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.50,
                                          child: Text(
                                            ticket.theater.name,
                                            style: blackNumberFont.copyWith(
                                                fontWeight: regularFontWeight,
                                                fontSize: 16),
                                            textAlign: TextAlign.end,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(bottom: 8),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "Date & Time",
                                          style: greyTextFont.copyWith(
                                              fontWeight: regularFontWeight,
                                              fontSize: 16),
                                        ),
                                        Text(
                                          ticket.time.dateAndTime,
                                          style: blackNumberFont.copyWith(
                                              fontWeight: regularFontWeight,
                                              fontSize: 16),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(bottom: 8),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "Seat Number",
                                          style: greyTextFont.copyWith(
                                              fontWeight: regularFontWeight,
                                              fontSize: 16),
                                        ),
                                        Text(
                                          ticket.seatInString,
                                          style: blackNumberFont.copyWith(
                                              fontWeight: regularFontWeight,
                                              fontSize: 16),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(bottom: 20),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "ID order",
                                          style: greyTextFont.copyWith(
                                              fontWeight: regularFontWeight,
                                              fontSize: 16),
                                        ),
                                        Text(
                                          ticket.bookingCode,
                                          style: blackNumberFont.copyWith(
                                              fontWeight: regularFontWeight,
                                              fontSize: 16),
                                        ),
                                      ],
                                    ),
                                  ),
                                  generateDashedDivider(
                                      MediaQuery.of(context).size.width -
                                          2 * defaultMargin -
                                          40),
                                ],
                              ),
                            ),
                          ),
                          ClipPath(
                            clipper: TicketBottomClipper(),
                            child: Container(
                              width: double.infinity,
                              padding: EdgeInsets.fromLTRB(20, 16, 20, 16),
                              color: Colors.white,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text(
                                        "Name: ",
                                        style: greyTextFont.copyWith(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w400),
                                      ),
                                      Text(
                                        ticket.name,
                                        style: whiteNumberFont.copyWith(
                                            color: Colors.black,
                                            fontSize: 16,
                                            fontWeight: FontWeight.w400),
                                      ),
                                      SizedBox(
                                        height: 8,
                                      ),
                                      Text(
                                        "Paid: ",
                                        style: greyTextFont.copyWith(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w400),
                                      ),
                                      Text(
                                        NumberFormat.currency(
                                                locale: "id_ID",
                                                decimalDigits: 0,
                                                symbol: "IDR ")
                                            .format(ticket.totalPrice),
                                        style: whiteNumberFont.copyWith(
                                            color: Colors.black,
                                            fontSize: 16,
                                            fontWeight: FontWeight.w400),
                                      ),
                                    ],
                                  ),
                                  QrImage(
                                    version: 6,
                                    foregroundColor: Colors.black,
                                    errorCorrectionLevel: QrErrorCorrectLevel.M,
                                    padding: EdgeInsets.all(0),
                                    size: 100,
                                    data: ticket.bookingCode,
                                  )
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
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

class TicketTopClipper extends CustomClipper<Path> {
  double radius = 15;

  @override
  Path getClip(Size size) {
    Path path = Path();
    path.lineTo(0, size.height - radius);
    path.quadraticBezierTo(radius, size.height - radius, radius, size.height);
    path.lineTo(size.width - radius, size.height);
    path.quadraticBezierTo(size.width - radius, size.height - radius,
        size.width, size.height - radius);
    path.lineTo(size.width, 0);

    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}

class TicketBottomClipper extends CustomClipper<Path> {
  double radius = 15;
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.moveTo(0, size.height);
    path.lineTo(size.width, size.height);
    path.lineTo(size.width, radius);
    path.quadraticBezierTo(size.width - radius, radius, size.width - radius, 0);
    path.lineTo(radius, 0);
    path.quadraticBezierTo(radius, radius, 0, radius);

    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
