part of 'page_bloc.dart';

abstract class PageEvent extends Equatable {
  const PageEvent();
}

class GoToLoginPage extends PageEvent {
  @override
  List<Object> get props => [];
}

class GoToSplashPage extends PageEvent {
  @override
  List<Object> get props => [];
}

class GoToMainPage extends PageEvent {
  @override
  List<Object> get props => [];
}

class GoToSignUpPage extends PageEvent {
  final RegistrationData registrationData;
  GoToSignUpPage(this.registrationData);
  @override
  List<Object> get props => [registrationData];
}

class GoToPreferencePage extends PageEvent {
  final RegistrationData registrationData;
  GoToPreferencePage(this.registrationData);
  @override
  List<Object> get props => [registrationData];
}

class GoToAccountConfirmationPage extends PageEvent {
  final RegistrationData registrationData;
  GoToAccountConfirmationPage(this.registrationData);
  @override
  List<Object> get props => [registrationData];
}

class GoToMovieDetailPage extends PageEvent {
  final Movie movie;
  GoToMovieDetailPage(this.movie);
  @override
  List<Object> get props => [movie];
}

class GoToSelectSchedulePage extends PageEvent {
  final MovieDetail movieDetail;
  GoToSelectSchedulePage(this.movieDetail);
  @override
  List<Object> get props => [movieDetail];
}

class GoToSelectSeatPage extends PageEvent {
  final Ticket ticket;
  GoToSelectSeatPage(this.ticket);
  @override
  List<Object> get props => [ticket];
}

class GoToCheckoutPage extends PageEvent {
  final Ticket ticket;
  GoToCheckoutPage(this.ticket);
  @override
  List<Object> get props => [ticket];
}

class GoToSuccessPage extends PageEvent {
  final Ticket ticket;
  final FlutixTransaction transaction;
  GoToSuccessPage(this.ticket, this.transaction);
  @override
  List<Object> get props => [ticket, transaction];
}

class GoToTicketDetailPage extends PageEvent {
  final Ticket ticket;
  GoToTicketDetailPage(this.ticket);
  @override
  List<Object> get props => [ticket];
}

class GoToProfilePage extends PageEvent {
  @override
  List<Object> get props => [];
}

class GoToTopUpPage extends PageEvent {
  final PageEvent pageEvent;
  GoToTopUpPage(this.pageEvent);
  @override
  List<Object> get props => [pageEvent];
}
