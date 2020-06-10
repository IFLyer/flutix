part of 'pages.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    FirebaseUser firebaseUser = Provider.of<FirebaseUser>(context);
    if (firebaseUser == null) {
      if (!(prevPageEvent is GoToSplashPage)) {
        prevPageEvent = GoToSplashPage();
        context.bloc<PageBloc>().add(GoToSplashPage());
      }
    } else {
      if (!(prevPageEvent is GoToMainPage)) {
        context.bloc<UserBloc>().add(LoadUser(firebaseUser.uid));
        context.bloc<TicketBloc>().add(GetTickets(firebaseUser.uid));
        prevPageEvent = GoToMainPage();
        context.bloc<PageBloc>().add(GoToMainPage());
      }
    }

    return BlocBuilder<PageBloc, PageState>(
        builder: (context, state) => state is OnSplashPage
            ? SplashPage()
            : state is OnLoginPage
                ? SignInPage()
                : state is OnSignUpPage
                    ? SignUpPage(state.registrationData)
                    : state is OnPreferencePage
                        ? PreferencePage(state.registrationData)
                        : state is OnAccountConfirmationPage
                            ? AccountConfirmationPage(state.registrationData)
                            : state is OnMovieDetailPage
                                ? MovieDetailPage(state.movie)
                                : state is OnSelectSchedulePage
                                    ? SelectSchedulePage(state.movieDetail)
                                    : state is OnSelectSeatPage
                                        ? SelectSeatPage(state.ticket)
                                        : state is OnCheckoutPage
                                            ? CheckoutPage(state.ticket)
                                            : state is OnSuccessPage
                                                ? SuccessPage(state.ticket,
                                                    state.transaction)
                                                : state is OnTicketDetailPage
                                                    ? TicketDetailPage(
                                                        state.ticket)
                                                    : state is OnProfilePage
                                                        ? ProfilePage()
                                                        : state is OnTopUpPage
                                                            ? TopUpPage(
                                                                state.pageEvent)
                                                            : MainPage());
  }
}
