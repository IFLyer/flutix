part of 'pages.dart';

class TicketPage extends StatefulWidget {
  @override
  _TicketPageState createState() => _TicketPageState();
}

class _TicketPageState extends State<TicketPage> {
  bool isExpiredTicket = false;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        BlocBuilder<TicketBloc, TicketState>(
          builder: (context, state) {
            return Container(
              margin: EdgeInsets.symmetric(horizontal: defaultMargin),
              child: TicketViewer(
                isExpiredTicket
                    ? state.tickets
                        .where(
                            (element) => element.time.isBefore(DateTime.now()))
                        .toList()
                    : state.tickets
                        .where(
                            (element) => !element.time.isBefore(DateTime.now()))
                        .toList(),
              ),
            );
          },
        ),
        SafeArea(
          child: ClipPath(
            clipper: HeaderClipper(),
            child: Container(
              height: 113,
              color: accentColor1,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: defaultMargin, bottom: 20),
                    child: Text(
                      "My Tickets",
                      style: whiteTextFont.copyWith(
                          fontSize: 20, fontWeight: mediumFontWeight),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            isExpiredTicket = false;
                          });
                        },
                        child: Column(
                          children: [
                            Text(
                              "Newest",
                              style: whiteTextFont.copyWith(
                                  fontSize: 16,
                                  fontWeight: mediumFontWeight,
                                  color: !isExpiredTicket
                                      ? Colors.white
                                      : Color(0xFF6F678E)),
                            ),
                            SizedBox(height: 15),
                            Container(
                              height: 4,
                              width: MediaQuery.of(context).size.width * 0.5,
                              color: !isExpiredTicket
                                  ? accentColor2
                                  : Colors.transparent,
                            )
                          ],
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            isExpiredTicket = true;
                          });
                        },
                        child: Column(
                          children: [
                            Text(
                              "Oldest",
                              style: whiteTextFont.copyWith(
                                  fontSize: 16,
                                  fontWeight: mediumFontWeight,
                                  color: isExpiredTicket
                                      ? Colors.white
                                      : Color(0xFF6F678E)),
                            ),
                            SizedBox(height: 15),
                            Container(
                              height: 4,
                              width:
                                  MediaQuery.of(context).size.width * 0.5 - 8,
                              color: isExpiredTicket
                                  ? accentColor2
                                  : Colors.transparent,
                            )
                          ],
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        )
      ],
    );
  }
}

class HeaderClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();

    path.lineTo(0, size.height - 20);
    path.quadraticBezierTo(0, size.height, 20, size.height);
    path.lineTo(size.width - 20, size.height);
    path.quadraticBezierTo(
        size.width, size.height, size.width, size.height - 20);
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}

class TicketViewer extends StatelessWidget {
  final List<Ticket> tickets;
  TicketViewer(this.tickets);
  @override
  Widget build(BuildContext context) {
    var sortedTickets = tickets;
    sortedTickets
        .sort((ticket1, ticket2) => ticket1.time.compareTo(ticket2.time));
    return ListView.builder(
      itemCount: tickets.length,
      itemBuilder: (_, index) => GestureDetector(
        onTap: () {
          context
              .bloc<PageBloc>()
              .add(GoToTicketDetailPage(sortedTickets[index]));
        },
        child: Container(
          margin: EdgeInsets.only(top: index == 0 ? 133 : 20),
          child: Row(
            children: [
              Container(
                width: 70,
                height: 90,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  image: DecorationImage(
                      image: NetworkImage(imageBaseUrl +
                          "w500" +
                          sortedTickets[index].movieDetail.posterPath),
                      fit: BoxFit.cover),
                ),
              ),
              SizedBox(width: 16),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    sortedTickets[index].movieDetail.title,
                    style: blackTextFont.copyWith(
                      fontSize: 18,
                      fontWeight: mediumFontWeight,
                    ),
                  ),
                  SizedBox(height: 6),
                  Container(
                    width: MediaQuery.of(context).size.width - 48 - 86,
                    child: Text(
                      sortedTickets[index].movieDetail.genresAndLanguage,
                      style: greyTextFont.copyWith(
                        fontSize: 12,
                        fontWeight: regularFontWeight,
                      ),
                      overflow: TextOverflow.clip,
                      maxLines: 1,
                    ),
                  ),
                  SizedBox(height: 6),
                  Text(
                    sortedTickets[index].theater.name,
                    style: greyTextFont.copyWith(
                      fontSize: 12,
                      fontWeight: regularFontWeight,
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
