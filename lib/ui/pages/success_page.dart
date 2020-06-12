part of 'pages.dart';

class SuccessPage extends StatelessWidget {
  final Ticket ticket;
  final FlutixTransaction transaction;

  SuccessPage(this.ticket, this.transaction);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return;
      },
      child: Scaffold(
        body: FutureBuilder(
          future: ticket != null
              ? processingTicketOrder(context)
              : processingTopUp(context),
          builder: (_, snapshot) => snapshot.connectionState ==
                  ConnectionState.done
              ? Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 150,
                      width: 150,
                      child: Image.asset(ticket != null
                          ? "assets/ticket_done.png"
                          : "assets/top_up_done.png"),
                    ),
                    SizedBox(height: 70),
                    Text(
                      ticket != null ? "Happy Watching!" : "Emmm Yummy!",
                      style: blackTextFont.copyWith(
                          fontSize: 20, fontWeight: mediumFontWeight),
                    ),
                    SizedBox(height: 16),
                    Text(
                      ticket != null
                          ? "You have successfully\nbought the ticket"
                          : "You have successfully\ntop up the wallet",
                      style: greyTextFont.copyWith(
                          fontSize: 16, fontWeight: lightFontWeight),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 70),
                    SizedBox(
                      height: 45,
                      width: 250,
                      child: RaisedButton(
                          color: mainColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadiusDirectional.circular(8),
                          ),
                          child: Text(
                            ticket != null ? "My Tickets" : "My Wallet",
                            style: whiteTextFont.copyWith(
                                fontSize: 16, fontWeight: mediumFontWeight),
                          ),
                          onPressed: () {
                            if (ticket != null) {
                              context.bloc<PageBloc>().add(GoToMainPage(bottomNavBarIndex: 1));
                            } else {
                              context.bloc<PageBloc>().add(GoToMainPage());
                            }
                          }),
                    ),
                    SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Discover new movie? ",
                          style: greyTextFont.copyWith(
                              fontWeight: regularFontWeight, fontSize: 14),
                        ),
                        GestureDetector(
                          onTap: () {
                            context.bloc<PageBloc>().add(GoToMainPage());
                          },
                          child: Text(
                            "Back to Home",
                            style: greyTextFont.copyWith(
                                fontWeight: regularFontWeight,
                                fontSize: 14,
                                color: mainColor),
                          ),
                        )
                      ],
                    )
                  ],
                )
              : Center(
                  child: SpinKitFadingCircle(
                    size: 50,
                    color: mainColor,
                  ),
                ),
        ),
      ),
    );
  }

  Future<void> processingTicketOrder(BuildContext context) async {
    context.bloc<UserBloc>().add(Purchase(ticket.totalPrice));
    context.bloc<TicketBloc>().add(BuyTicket(ticket, transaction.userID));
    await FlutixTransactionServices.saveTransaction(transaction);
  }

  Future<void> processingTopUp(BuildContext context) async {
    context.bloc<UserBloc>().add(TopUp(transaction.amount));
    await FlutixTransactionServices.saveTransaction(transaction);
  }
}
