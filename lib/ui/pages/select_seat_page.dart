part of 'pages.dart';

class SelectSeatPage extends StatefulWidget {
  final Ticket ticket;
  SelectSeatPage(this.ticket);
  @override
  _SelectSeatPageState createState() => _SelectSeatPageState();
}

class _SelectSeatPageState extends State<SelectSeatPage> {
  List<String> selectedSeats = [];

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        context
            .bloc<PageBloc>()
            .add(GoToSelectSchedulePage(widget.ticket.movieDetail));
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
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          margin: EdgeInsets.only(top: 20, left: defaultMargin),
                          padding: EdgeInsets.all(1),
                          child: GestureDetector(
                            onTap: () {
                              context.bloc<PageBloc>().add(
                                  GoToSelectSchedulePage(
                                      widget.ticket.movieDetail));
                            },
                            child: Icon(
                              Icons.arrow_back,
                              color: Colors.black,
                            ),
                          ),
                        ),
                        Padding(
                          padding:
                              EdgeInsets.only(top: 20, right: defaultMargin),
                          child: Row(
                            children: [
                              Container(
                                width: MediaQuery.of(context).size.width / 2,
                                child: Text(
                                  widget.ticket.movieDetail.title,
                                  style: blackTextFont.copyWith(
                                      fontWeight: mediumFontWeight,
                                      fontSize: 20),
                                  maxLines: 2,
                                  overflow: TextOverflow.clip,
                                  textAlign: TextAlign.end,
                                ),
                              ),
                              SizedBox(width: 16),
                              Container(
                                width: 60,
                                height: 60,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  image: DecorationImage(
                                      image: NetworkImage(imageBaseUrl +
                                          "w185" +
                                          widget.ticket.movieDetail.posterPath),
                                      fit: BoxFit.cover),
                                ),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                    SizedBox(height: 30),
                    Container(
                      width: 277,
                      height: 84,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage("assets/screen.png"))),
                    ),
                    generateSeats(),
                    Center(
                      child: Container(
                        width: 50,
                        height: 50,
                        margin: EdgeInsets.only(top: 30, bottom: 40),
                        child: BlocBuilder<UserBloc, UserState>(
                          builder: (_, userstate) => FloatingActionButton(
                              elevation: 0,
                              backgroundColor: selectedSeats.length > 0
                                  ? mainColor
                                  : Color(0xffe4e4e4),
                              child: Icon(
                                Icons.arrow_forward,
                                color: selectedSeats.length > 0
                                    ? Colors.white
                                    : Color(0xffBEBEBE),
                              ),
                              onPressed: selectedSeats.length > 0
                                  ? () async {
                                      context
                                          .bloc<PageBloc>()
                                          .add(GoToCheckoutPage(widget.ticket.copyWith(seats: selectedSeats)));
                                    }
                                  : null),
                        ),
                      ),
                    ),
                  ],
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  Column generateSeats() {
    List<int> numberOfSeats = [3, 5, 5, 5, 5];
    List<Widget> widgets = [];
    for (int i = 0; i < numberOfSeats.length; i++) {
      widgets.add(
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(
              numberOfSeats[i],
              (index) => Padding(
                    padding: EdgeInsets.only(
                        right: index < numberOfSeats[i] - 1 ? 16 : 0,
                        bottom: 16),
                    child: SelectableBox(
                      "${String.fromCharCode(i + 65)}${index + 1}",
                      width: 40,
                      height: 40,
                      textStyle: blackNumberFont,
                      isSelected: selectedSeats.contains(
                          "${String.fromCharCode(i + 65)}${index + 1}"),
                      isEnabled: index != 0,
                      onTap: () {
                        setState(() {
                          if (selectedSeats.contains(
                              "${String.fromCharCode(i + 65)}${index + 1}")) {
                            selectedSeats.remove(
                                "${String.fromCharCode(i + 65)}${index + 1}");
                          } else {
                            selectedSeats.add(
                                "${String.fromCharCode(i + 65)}${index + 1}");
                          }
                        });
                      },
                    ),
                  )).toList(),
        ),
      );
    }
    return Column(children: widgets);
  }
}
