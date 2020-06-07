part of 'pages.dart';

class CheckoutPage extends StatefulWidget {
  final Ticket ticket;
  CheckoutPage(this.ticket);
  @override
  _CheckoutPageState createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  bool isCheckingOut = false;
  @override
  Widget build(BuildContext context) {
    int total = 27500 * widget.ticket.seats.length;
    return WillPopScope(
        onWillPop: () async {
          context.bloc<PageBloc>().add(GoToSelectSeatPage(widget.ticket));
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
                  Stack(
                    children: [
                      Container(
                        margin: EdgeInsets.only(top: 20, left: defaultMargin),
                        padding: EdgeInsets.all(1),
                        child: GestureDetector(
                          onTap: () {
                            context
                                .bloc<PageBloc>()
                                .add(GoToSelectSeatPage(widget.ticket));
                          },
                          child: Icon(
                            Icons.arrow_back,
                            color: Colors.black,
                          ),
                        ),
                      ),
                      BlocBuilder<UserBloc, UserState>(
                        builder: (_, state) {
                          User user = (state as UserLoaded).user;
                          return Padding(
                            padding:
                                EdgeInsets.symmetric(horizontal: defaultMargin),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                SizedBox(height: 20),
                                Text(
                                  "Checkout\nMovie",
                                  style: blackTextFont.copyWith(
                                    fontSize: 20,
                                    fontWeight: mediumFontWeight,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                                Padding(
                                  padding: EdgeInsets.symmetric(vertical: 20),
                                  child: Row(
                                    children: [
                                      Container(
                                        height: 90,
                                        width: 70,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(8),
                                          image: DecorationImage(
                                              image: NetworkImage(imageBaseUrl +
                                                  "w1280" +
                                                  widget.ticket.movieDetail
                                                      .posterPath),
                                              fit: BoxFit.cover),
                                        ),
                                      ),
                                      SizedBox(width: 20),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width -
                                                48 -
                                                20 -
                                                70,
                                            child: Text(
                                              widget.ticket.movieDetail.title,
                                              style: blackTextFont.copyWith(
                                                  fontWeight: mediumFontWeight,
                                                  fontSize: 18),
                                              overflow: TextOverflow.clip,
                                              maxLines: 2,
                                            ),
                                          ),
                                          SizedBox(height: 6),
                                          Text(
                                            widget.ticket.movieDetail
                                                .genresAndLanguage,
                                            style: greyTextFont.copyWith(
                                                fontWeight: regularFontWeight,
                                                fontSize: 12),
                                          ),
                                          SizedBox(height: 6),
                                          RatingStars(
                                            voteAverage: widget
                                                .ticket.movieDetail.voteAverage,
                                            color: accentColor3,
                                          )
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                                Divider(
                                  color: accentColor3,
                                  thickness: 1,
                                ),
                                SizedBox(height: 20),
                                Padding(
                                  padding: EdgeInsets.only(bottom: 8),
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
                                        widget.ticket.bookingCode,
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
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.50,
                                        child: Text(
                                          widget.ticket.theater.name,
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
                                        widget.ticket.time.dateAndTime,
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
                                        widget.ticket.seatInString,
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
                                        "Price",
                                        style: greyTextFont.copyWith(
                                            fontWeight: regularFontWeight,
                                            fontSize: 16),
                                      ),
                                      Text(
                                        "Rp 25.000 x ${widget.ticket.seats.length}",
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
                                        "Fee",
                                        style: greyTextFont.copyWith(
                                            fontWeight: regularFontWeight,
                                            fontSize: 16),
                                      ),
                                      Text(
                                        "Rp 2.500 x ${widget.ticket.seats.length}",
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
                                        "Total",
                                        style: greyTextFont.copyWith(
                                            fontWeight: regularFontWeight,
                                            fontSize: 16),
                                      ),
                                      Text(
                                        NumberFormat.currency(
                                                locale: 'id_ID',
                                                decimalDigits: 0,
                                                symbol: 'Rp ')
                                            .format(total),
                                        style: blackNumberFont.copyWith(
                                            fontWeight: FontWeight.w600,
                                            fontSize: 16),
                                      ),
                                    ],
                                  ),
                                ),
                                Divider(
                                  color: accentColor3,
                                  thickness: 1,
                                ),
                                SizedBox(height: 20),
                                Padding(
                                  padding: EdgeInsets.only(bottom: 78),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "Your Wallet",
                                        style: greyTextFont.copyWith(
                                            fontWeight: regularFontWeight,
                                            fontSize: 16),
                                      ),
                                      Text(
                                        NumberFormat.currency(
                                                locale: 'id_ID',
                                                decimalDigits: 0,
                                                symbol: 'Rp ')
                                            .format(user.balance),
                                        style: blackNumberFont.copyWith(
                                            fontWeight: FontWeight.w600,
                                            fontSize: 16,
                                            color: user.balance >= total
                                                ? Color(0xFF3E9D9D)
                                                : Color(0xFFFF5C83)),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  width: 250,
                                  height: 45,
                                  margin: EdgeInsets.only(bottom: 70),
                                  child: isCheckingOut
                                      ? SpinKitFadingCircle(
                                          color: Color(0xFF3E9D9D),
                                          size: 45,
                                        )
                                      : RaisedButton(
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadiusDirectional
                                                      .circular(8)),
                                          child: Text(
                                            user.balance >= total
                                                ? "Checkout Now"
                                                : "Top Up My Wallet",
                                            style: whiteTextFont.copyWith(
                                                fontSize: 16),
                                          ),
                                          color: user.balance >= total
                                              ? Color(0xFF3E9D9D)
                                              : Color(0xFF503E9D),
                                          onPressed: () async {
                                            if (user.balance < total) {
                                              Flushbar(
                                                duration: Duration(seconds: 4),
                                                flushbarPosition:
                                                    FlushbarPosition.TOP,
                                                backgroundColor:
                                                    Color(0xffff5c83),
                                                messageText: Text(
                                                  "You need to top up your wallet first",
                                                  style: whiteTextFont.copyWith(
                                                      fontSize: 12,
                                                      fontWeight:
                                                          regularFontWeight),
                                                  textAlign: TextAlign.center,
                                                ),
                                              )..show(context);
                                            } else {
                                              FlutixTransaction transaction =
                                                  FlutixTransaction(
                                                      userID: user.id,
                                                      title: widget.ticket
                                                          .movieDetail.title,
                                                      subtitle: widget
                                                          .ticket.theater.name,
                                                      time: DateTime.now(),
                                                      amount: -total,
                                                      picture: widget
                                                          .ticket
                                                          .movieDetail
                                                          .posterPath);
                                              context.bloc<PageBloc>().add(
                                                  GoToSuccessPage(
                                                      widget.ticket.copyWith(
                                                          totalPrice: total),
                                                      transaction));
                                            }
                                          },
                                        ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ],
              )
            ],
          ),
        ));
  }
}
