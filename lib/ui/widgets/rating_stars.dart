part of 'widgets.dart';

class RatingStars extends StatelessWidget {
  final double voteAverage;
  final double starSize;
  final double fontSize;
  final MainAxisAlignment mainAxisAlignment;
  final Color color;
  RatingStars(
      {this.voteAverage = 0,
      this.starSize = 20,
      this.fontSize = 12,
      this.mainAxisAlignment = MainAxisAlignment.start,
      this.color = Colors.white});
  @override
  Widget build(BuildContext context) {
    int n = (voteAverage / 2).round();
    List<Widget> widgets = List.generate(
      5,
      (index) => Icon(
        index < n ? MdiIcons.star : MdiIcons.starOutline,
        color: accentColor2,
        size: starSize,
      ),
    );

    widgets.add(SizedBox(width: 3));
    widgets.add(
      Text(
        "$voteAverage/10",
        style: whiteNumberFont.copyWith(
            fontSize: 12, fontWeight: lightFontWeight, color: color),
      ),
    );
    return Row(
      children: widgets,
      mainAxisAlignment: mainAxisAlignment,
    );
  }
}
