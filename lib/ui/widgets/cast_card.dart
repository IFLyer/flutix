part of 'widgets.dart';

class CastCard extends StatelessWidget {
  final Credit credit;
  CastCard(this.credit);
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 80,
          width: 70,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            image: DecorationImage(
                image: NetworkImage(imageBaseUrl + "w185" + credit.profilePath),
                fit: BoxFit.cover),
          ),
        ),
        SizedBox(height: 6),
        Container(
          width: 70,
          child: Text(
            credit.name,
            textAlign: TextAlign.center,
            maxLines: 2,
            overflow: TextOverflow.clip,
            style: blackTextFont.copyWith(
                fontWeight: regularFontWeight, fontSize: 10),
          ),
        )
      ],
    );
  }
}
