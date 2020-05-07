part of 'widgets.dart';

class ComingSoonCard extends StatelessWidget {
  final Movie movie;
  ComingSoonCard({this.movie});
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      height: 140,
      decoration: BoxDecoration(
        image: DecorationImage(
            image: NetworkImage(imageBaseUrl + "w500" + movie.posterPath),
            fit: BoxFit.cover),
        borderRadius: BorderRadius.circular(8),
      ),
      
    );
  }
}