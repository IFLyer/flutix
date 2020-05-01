import 'package:flutix/bloc/blocs.dart';
import 'package:flutix/services/services.dart';
import 'package:flutix/ui/pages/pages.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return StreamProvider.value(
        value: AuthServices.userStream,
        child: MultiBlocProvider(
          providers: [
            BlocProvider(create: (context) => PageBloc()),
            BlocProvider(create: (context) => UserBloc())
          ],
          child: MaterialApp(
              debugShowCheckedModeBanner: false,
              title: 'Flutter Demo',
              theme: ThemeData(),
              home: Wrapper()),
        ));
  }
}
