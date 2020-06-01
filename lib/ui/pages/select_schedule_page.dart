part of 'pages.dart';

class SelectSchedulePage extends StatefulWidget {
  final MovieDetail movieDetail;
  SelectSchedulePage(this.movieDetail);
  @override
  _SelectSchedulePageState createState() => _SelectSchedulePageState();
}

class _SelectSchedulePageState extends State<SelectSchedulePage> {
  List<DateTime> dates;
  DateTime selectedDate;
  int selectedTime;
  Theater selectedTheater;
  bool isValid;
  List<ScrollController> controllers = [];

  @override
  void initState() {
    super.initState();
    dates =
        List.generate(7, (index) => DateTime.now().add(Duration(days: index)));
    selectedDate = dates[0];
    isValid = false;
    for (var theater in dummyTheaters) {
      controllers.add(new ScrollController());
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        context.bloc<PageBloc>().add(GoToMovieDetailPage(widget.movieDetail));
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
                      margin: EdgeInsets.only(top: 20, left: defaultMargin),
                      padding: EdgeInsets.all(1),
                      child: GestureDetector(
                        onTap: () {
                          context
                              .bloc<PageBloc>()
                              .add(GoToMovieDetailPage(widget.movieDetail));
                        },
                        child: Icon(
                          Icons.arrow_back,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(
                          defaultMargin, 20, defaultMargin, 16),
                      child: Text(
                        "Choose Date",
                        style: blackTextFont.copyWith(
                            fontWeight: mediumFontWeight, fontSize: 20),
                      ),
                    ),
                    SizedBox(
                      height: 90,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: dates.length,
                        itemBuilder: (_, index) => Padding(
                          padding: EdgeInsets.only(
                              left: index == 0 ? defaultMargin : 0,
                              right: index == dates.length - 1 ? 24 : 16),
                          child: DateCard(
                            dates[index],
                            isSelected: dates[index] == selectedDate,
                            onTap: () {
                              setState(() {
                                if (selectedDate != dates[index]) {
                                  selectedDate = dates[index];
                                  selectedTime = null;
                                  selectedTheater = null;
                                  for (int i = 0; i < controllers.length; i++) {
                                    controllers[i].jumpTo(0);
                                  }
                                  checkValidation();
                                }
                              });
                            },
                          ),
                        ),
                      ),
                    ),
                    generateTimeTable(),
                    Center(
                      child: Container(
                        width: 50,
                        height: 50,
                        margin: EdgeInsets.only(top: 30, bottom: 40),
                        child: FloatingActionButton(
                            elevation: 0,
                            backgroundColor:
                                isValid ? mainColor : Color(0xffe4e4e4),
                            child: Icon(
                              Icons.arrow_forward,
                              color: isValid ? Colors.white : Color(0xffBEBEBE),
                            ),
                            onPressed: isValid
                                ? () async {
                                    // context.bloc<PageBloc>().add(GoToPreferencePage(widget.registrationData));
                                  }
                                : null),
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

  Column generateTimeTable() {
    List<int> schedule = List.generate(7, (index) => 10 + index * 2);
    List<Widget> widgets = [];

    for (int i = 0; i < dummyTheaters.length; i++) {
      widgets.add(
        Padding(
          padding:
              const EdgeInsets.fromLTRB(defaultMargin, 20, defaultMargin, 16),
          child: Text(
            dummyTheaters[i].name,
            style: blackTextFont.copyWith(
                fontWeight: mediumFontWeight, fontSize: 20),
          ),
        ),
      );
      widgets.add(
        SizedBox(
          height: 50,
          child: ListView.builder(
            controller: controllers[i],
            scrollDirection: Axis.horizontal,
            itemCount: schedule.length,
            itemBuilder: (_, index) => Padding(
              padding: EdgeInsets.only(
                  left: index == 0 ? defaultMargin : 0,
                  right: index == schedule.length - 1 ? 24 : 16),
              child: SelectableBox(
                schedule[index].toString() + ":00",
                isSelected: schedule[index] == selectedTime &&
                    selectedTheater == dummyTheaters[i],
                onTap: () {
                  setState(() {
                    selectedTheater = dummyTheaters[i];
                    selectedTime = schedule[index];
                    checkValidation();
                  });
                },
                isEnabled: schedule[index] > DateTime.now().hour ||
                    selectedDate.day != DateTime.now().day,
                height: 50,
                width: 90,
              ),
            ),
          ),
        ),
      );
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: widgets,
    );
  }

  void checkValidation() {
    isValid = selectedTheater != null && selectedTime != null;
  }
}
