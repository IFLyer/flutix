part of 'pages.dart';

class PreferencePage extends StatefulWidget {
  final RegistrationData registrationData;
  PreferencePage(this.registrationData);
  @override
  _PreferencePageState createState() => _PreferencePageState();
}

class _PreferencePageState extends State<PreferencePage> {
  final List<String> genre = [
    "Horror",
    "Music",
    "Action",
    "Drama",
    "War",
    "Crime"
  ];
  final List<String> languages = ["Bahasa", "English", "Japanese", "Korean"];
  List<String> selectedGenre;
  String selectedLanguage;
  
  @override
  void initState(){
    super.initState();
    selectedGenre = widget.registrationData.selectedGenres??new List<String>();
    selectedLanguage = widget.registrationData.selectedLanguage;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        context.bloc<PageBloc>().add(GoToSignUpPage(widget.registrationData));
        return;
      },
      child: Scaffold(
        body: Container(
          color: Colors.white,
          padding: EdgeInsets.symmetric(horizontal: defaultMargin),
          child: ListView(
            children: <Widget>[
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(top: 20, bottom: 4),
                    height: 56,
                    child: GestureDetector(
                      child: Icon(Icons.arrow_back),
                      onTap: () {
                        context
                            .bloc<PageBloc>()
                            .add(GoToSignUpPage(widget.registrationData));
                      },
                    ),
                  ),
                  Text(
                    "Select Your\nFavorite Genre",
                    style: blackTextFont.copyWith(fontSize: 20),
                    textAlign: TextAlign.left,
                  ),
                  SizedBox(height: 16),
                  Wrap(
                    spacing: 24,
                    runSpacing: 24,
                    children: generateGenreWidgets(context),
                  ),
                  SizedBox(height: 24),
                  Text(
                    "Movie Language\nYou Prefer?",
                    style: blackTextFont.copyWith(fontSize: 20),
                    textAlign: TextAlign.left,
                  ),
                  SizedBox(height: 16),
                  Wrap(
                    spacing: 24,
                    runSpacing: 24,
                    children: generateLanguageWidgets(context),
                  ),
                  Center(
                    child: Container(
                      width: 50,
                      height: 50,
                      margin: EdgeInsets.only(top: 30, bottom: 50),
                      child: FloatingActionButton(
                          elevation: 0,
                          backgroundColor: mainColor,
                          child: Icon(
                            Icons.arrow_forward,
                            color: Colors.white,
                          ),
                          onPressed: () {
                            if (selectedGenre.length != 4) {
                              Flushbar(
                                duration: Duration(milliseconds: 1500),
                                flushbarPosition: FlushbarPosition.TOP,
                                backgroundColor: Color(0xffff5c83),
                                message: "Please select 4 genres",
                              )..show(context);
                            } else {
                              widget.registrationData.selectedLanguage =
                                  selectedLanguage;
                              widget.registrationData.selectedGenres =
                                  selectedGenre;
                              context.bloc<PageBloc>().add(
                                  GoToAccountConfirmationPage(
                                      widget.registrationData));
                            }
                          }),
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

  List<Widget> generateGenreWidgets(BuildContext context) {
    double width =
        (MediaQuery.of(context).size.width - 2 * defaultMargin - 24) / 2;
    return genre
        .map((e) => SelectableBox(
              e,
              width: width,
              isSelected: selectedGenre.contains(e),
              onTap: () {
                setState(() {
                  if (selectedGenre.contains(e)) {
                    selectedGenre.remove(e);
                  } else if (selectedGenre.length < 4) {
                    selectedGenre.add(e);
                  }
                });
              },
            ))
        .toList();
  }

  List<Widget> generateLanguageWidgets(BuildContext context) {
    double width =
        (MediaQuery.of(context).size.width - 2 * defaultMargin - 24) / 2;
    return languages
        .map((e) => SelectableBox(
              e,
              width: width,
              isSelected: selectedLanguage == e,
              onTap: () {
                if (selectedLanguage != e) {
                  setState(() {
                    selectedLanguage = e;
                  });
                }
              },
            ))
        .toList();
  }
}
