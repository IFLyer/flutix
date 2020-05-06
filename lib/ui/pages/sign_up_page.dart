part of 'pages.dart';

class SignUpPage extends StatefulWidget {
  final RegistrationData registrationData;
  SignUpPage(this.registrationData);
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController retypePasswordController = TextEditingController();

  bool isEmailValid;
  bool isNamaValid;
  bool isPasswordValid;
  bool isConfirmPasswordValid;
  @override
  void initState() {
    super.initState();

    nameController.text = widget.registrationData.name;
    emailController.text = widget.registrationData.email;

    isEmailValid = widget.registrationData.email != "";
    isNamaValid = widget.registrationData.name != "";
    isPasswordValid = false;
    isConfirmPasswordValid = false;
  }

  @override
  Widget build(BuildContext context) {
    context
        .bloc<ThemeBloc>()
        .add(ChangeTheme(ThemeData().copyWith(primaryColor: accentColor2)));
    return WillPopScope(
      onWillPop: () async {
        context.bloc<PageBloc>().add(GoToSplashPage());
        return;
      },
      child: Scaffold(
        body: Container(
          padding: EdgeInsets.symmetric(horizontal: defaultMargin),
          color: Colors.white,
          child: ListView(
            children: <Widget>[
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(top: 20, bottom: 22),
                    height: 56,
                    child: Stack(
                      children: <Widget>[
                        Align(
                          alignment: Alignment.centerLeft,
                          child: GestureDetector(
                            child: Icon(Icons.arrow_back),
                            onTap: () {
                              context.bloc<PageBloc>().add(GoToSplashPage());
                            },
                          ),
                        ),
                        Center(
                          child: Text(
                            "Create New\nYour Account",
                            style: blackTextFont.copyWith(fontSize: 20),
                            textAlign: TextAlign.center,
                          ),
                        )
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(bottom: 35),
                    height: 104,
                    width: 90,
                    child: Stack(
                      children: <Widget>[
                        Container(
                          width: 90,
                          height: 90,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                              image: widget.registrationData.profilePicture ==
                                      null
                                  ? AssetImage("assets/user_pic.png")
                                  : FileImage(
                                      widget.registrationData.profilePicture),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Align(
                          alignment: Alignment.bottomCenter,
                          child: GestureDetector(
                            onTap: () async {
                              if (widget.registrationData.profilePicture ==
                                  null) {
                                widget.registrationData.profilePicture =
                                    await getImage();
                              } else {
                                widget.registrationData.profilePicture = null;
                              }
                              setState(() {});
                            },
                            child: Container(
                              height: 28,
                              width: 28,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                image: DecorationImage(
                                  image: widget.registrationData
                                              .profilePicture ==
                                          null
                                      ? AssetImage("assets/btn_add_photo.png")
                                      : AssetImage("assets/btn_del_photo.png"),
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  TextField(
                    onChanged: (text) {
                      setState(() {
                        isNamaValid = text.length >= 6;
                      });
                    },
                    controller: nameController,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)),
                        labelText: "Full Name",
                        hintText: "Full Name"),
                  ),
                  SizedBox(height: 16),
                  TextField(
                    onChanged: (text) {
                      setState(() {
                        isEmailValid = EmailValidator.validate(text);
                      });
                    },
                    controller: emailController,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)),
                        labelText: "Email Address",
                        hintText: "Email Address"),
                  ),
                  SizedBox(height: 16),
                  TextField(
                    onChanged: (text) {
                      setState(() {
                        isPasswordValid = text.length >= 6;
                      });
                    },
                    controller: passwordController,
                    obscureText: true,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)),
                        labelText: "Password",
                        hintText: "Password"),
                  ),
                  SizedBox(height: 16),
                  TextField(
                    onChanged: (text) {
                      setState(() {
                        isConfirmPasswordValid =
                            text == passwordController.text;
                      });
                    },
                    controller: retypePasswordController,
                    obscureText: true,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)),
                        labelText: "Confirm Password",
                        hintText: "Confirm Password"),
                  ),
                  Center(
                    child: Container(
                      width: 50,
                      height: 50,
                      margin: EdgeInsets.only(top: 30, bottom: 40),
                      child: FloatingActionButton(
                          elevation: 0,
                          backgroundColor: isNamaValid &&
                                  isEmailValid &&
                                  isPasswordValid &&
                                  isConfirmPasswordValid
                              ? mainColor
                              : Color(0xffe4e4e4),
                          child: Icon(
                            Icons.arrow_forward,
                            color: isNamaValid &&
                                    isEmailValid &&
                                    isPasswordValid &&
                                    isConfirmPasswordValid
                                ? Colors.white
                                : Color(0xffBEBEBE),
                          ),
                          onPressed: isNamaValid &&
                                  isEmailValid &&
                                  isPasswordValid &&
                                  isConfirmPasswordValid
                              ? () async {
                                widget.registrationData.name = nameController.text;
                                widget.registrationData.email = emailController.text;
                                widget.registrationData.password = passwordController.text;

                                context.bloc<PageBloc>().add(GoToPreferencePage(widget.registrationData));
                              }
                              : null),
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
