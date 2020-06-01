part of 'widgets.dart';

class MovieBanner extends StatelessWidget {
  final Movie movie;
  final Function onTap;
  MovieBanner(this.movie, {this.onTap});
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        if(onTap != null){
          onTap();
        }
      },
          child: Container(
        width: 210,
        height: 140,
        decoration: BoxDecoration(
          image: DecorationImage(
              image: NetworkImage(imageBaseUrl + "w500" + movie.backdropPath),
              fit: BoxFit.cover),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Container(
          height: 140,
          width: 210,
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            gradient: LinearGradient(
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter,
              colors: [
                Colors.black.withOpacity(0.61),
                Colors.black.withOpacity(0)
              ],
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                movie.title,
                style: whiteTextFont.copyWith(fontSize: 14),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              RatingStars(voteAverage: movie.voteAverage)
            ],
          ),
        ),
      ),
    );
  }
}
