part of 'widgets.dart';

class PromoCard extends StatelessWidget {
  final Promo promo;
  PromoCard({@required this.promo});
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
          height: 80,
          padding: EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8), color: mainColor),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    promo.title,
                    style: whiteTextFont.copyWith(
                        fontSize: 14, fontWeight: regularFontWeight),
                  ),
                  SizedBox(height: 4),
                  Text(
                    promo.subtitle,
                    style: whiteTextFont.copyWith(
                        fontSize: 11,
                        fontWeight: lightFontWeight,
                        color: Color(0xFFA99BE3)),
                  ),
                ],
              ),
              Row(
                children: <Widget>[
                  Text(
                    'OFF ',
                    style: yellowNumberFont.copyWith(
                        fontSize: 18, fontWeight: lightFontWeight),
                  ),
                  Text(
                    '${promo.discount}%',
                    style: yellowNumberFont.copyWith(
                        fontSize: 18, fontWeight: FontWeight.w700),
                  ),
                ],
              ),
            ],
          ),
        ),
        ShaderMask(
          shaderCallback: (rectangle) {
            return LinearGradient(
              begin: Alignment.centerRight,
              end: Alignment.centerLeft,
                    colors: [Colors.black.withOpacity(0.1), Colors.transparent])
                .createShader(Rect.fromLTRB(0, 0, 77.5, 80));
          },
          blendMode: BlendMode.dstIn,
          child: SizedBox(
            height: 80,
            width: 77.5,
            child: ClipRRect(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(8), bottomLeft: Radius.circular(8)),
                child: Image.asset("assets/reflection2.png")),
          ),
        ),
        Align(
          alignment: Alignment.topRight,
                  child: ShaderMask(
            shaderCallback: (rectangle) {
              return LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                      colors: [Colors.black.withOpacity(0.1), Colors.transparent])
                  .createShader(Rect.fromLTRB(0, 0, 96, 45));
            },
            blendMode: BlendMode.dstIn,
            child: SizedBox(
              height: 45,
              width: 96,
              child: ClipRRect(
                  borderRadius: BorderRadius.only(
                      bottomRight: Radius.circular(8), topRight: Radius.circular(8)),
                  child: Image.asset("assets/reflection1.png")),
            ),
          ),
        ),
        Align(
          alignment: Alignment.topRight,
                  child: ShaderMask(
            shaderCallback: (rectangle) {
              return LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                      colors: [Colors.black.withOpacity(0.1), Colors.transparent])
                  .createShader(Rect.fromLTRB(0, 0, 53, 25));
            },
            blendMode: BlendMode.dstIn,
            child: SizedBox(
              height: 25,
              width: 53,
              child: ClipRRect(
                  borderRadius: BorderRadius.only(
                      bottomRight: Radius.circular(8), topRight: Radius.circular(8)),
                  child: Image.asset("assets/reflection3.png")),
            ),
          ),
        ),
      ],
    );
  }
}
