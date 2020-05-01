part of 'pages.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Main Page"),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            BlocBuilder<UserBloc, UserState>(
              builder: (context, state) => state is UserLoaded
                  ? Text(state.user.name)
                  : Text("belum login"),
            ),
            RaisedButton(
              child: Text("Sign Out"),
              onPressed: () async {
                await AuthServices.signOut();
              },
            ),
          ],
        ),
      ),
    );
  }
}