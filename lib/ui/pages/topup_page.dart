part of 'pages.dart';

class TopUpPage extends StatefulWidget {
  final PageEvent pageEvent;
  TopUpPage(this.pageEvent);
  @override
  _TopUpPageState createState() => _TopUpPageState();
}

class _TopUpPageState extends State<TopUpPage> {
  TextEditingController amountController = TextEditingController(text: 'Rp 0');
  int selectedAmount = 0;

  @override
  Widget build(BuildContext context) {
    context.bloc<ThemeBloc>().add(
        ChangeTheme(ThemeData().copyWith(primaryColor: Color(0xFFE4E4E4))));

    double cardWidth =
        (MediaQuery.of(context).size.width - 2 * defaultMargin - 2 * 20) / 3;

    MoneyCard makeMoneyCard(int amount) {
      return MoneyCard(
        amount,
        width: cardWidth,
        isSelected: amount == selectedAmount,
        onTap: () {
          setState(() {
            selectedAmount = amount;
            amountController.text = NumberFormat.currency(
                    locale: 'id_ID', symbol: 'Rp ', decimalDigits: 0)
                .format(selectedAmount);
            amountController.selection = TextSelection.fromPosition(
                TextPosition(offset: amountController.text.length));
          });
        },
      );
    }

    return WillPopScope(
      onWillPop: () async {
        context.bloc<PageBloc>().add(widget.pageEvent);
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
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: defaultMargin),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: EdgeInsets.only(top: 20, bottom: 30),
                        height: 25,
                        child: Stack(
                          children: [
                            Align(
                              alignment: Alignment.centerLeft,
                              child: GestureDetector(
                                child: Icon(Icons.arrow_back),
                                onTap: () {
                                  context
                                      .bloc<PageBloc>()
                                      .add(widget.pageEvent);
                                },
                              ),
                            ),
                            Center(
                              child: Text(
                                "Top Up",
                                style: blackTextFont.copyWith(fontSize: 20),
                                textAlign: TextAlign.center,
                              ),
                            )
                          ],
                        ),
                      ),
                      TextField(
                        onChanged: (text) {
                          String temp = '';
                          for (int i = 0; i < text.length; i++) {
                            if (text.isDigit(i)) {
                              temp += text[i];
                            }
                          }
                          setState(() {
                            selectedAmount = int.tryParse(temp) ?? 0;
                          });
                          amountController.text = NumberFormat.currency(
                                  locale: 'id_ID',
                                  symbol: 'Rp ',
                                  decimalDigits: 0)
                              .format(selectedAmount);
                          amountController.selection =
                              TextSelection.fromPosition(TextPosition(
                                  offset: amountController.text.length));
                        },
                        controller: amountController,
                        decoration: InputDecoration(
                            labelStyle: greyTextFont,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            labelText: "Amount"),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 20, bottom: 14),
                        child: Text(
                          "Choose by Template",
                          style: blackTextFont.copyWith(
                              fontSize: 14, fontWeight: mediumFontWeight),
                        ),
                      ),
                      Wrap(
                        spacing: 20,
                        runSpacing: 14,
                        children: [
                          50000,
                          100000,
                          150000,
                          200000,
                          250000,
                          500000,
                          1000000,
                          2500000,
                          5000000
                        ].map((e) => makeMoneyCard(e)).toList(),
                      ),
                      SizedBox(height: 100),
                      Center(
                        child: SizedBox(
                          width: 250,
                          height: 46,
                          child: BlocBuilder<UserBloc, UserState>(
                            builder: (_, state) => RaisedButton(
                              elevation: 0,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8)),
                              child: Text(
                                "Top Up Now",
                                style: whiteTextFont.copyWith(
                                  fontSize: 16,
                                  fontWeight: mediumFontWeight,
                                  color: selectedAmount > 0
                                      ? Colors.white
                                      : Color(0xFFBEBEBE),
                                ),
                              ),
                              color: Color(0xFF3E9D9D),
                              disabledColor: Color(0xFFE4E4E4),
                              onPressed: selectedAmount > 0
                                  ? () {
                                      User user = (state as UserLoaded).user;
                                      FlutixTransaction transaction =
                                          FlutixTransaction(
                                              userID: user.id,
                                              title: "Top Up Wallet",
                                              subtitle:
                                                  DateFormat("EEEE, dd MMMM y")
                                                      .format(DateTime.now()),
                                              time: DateTime.now(),
                                              amount: selectedAmount);
                                      context.bloc<PageBloc>().add(
                                          GoToSuccessPage(null, transaction));
                                    }
                                  : null,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
