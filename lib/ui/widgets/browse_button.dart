part of 'widgets.dart';

class BrowseButton extends StatelessWidget {
  final String name;
  BrowseButton({this.name});
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 68,
      width: 50,
      child: Column(
        children: <Widget>[
          Container(
            height: 50,
            width: 50,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8), color: Color(0xFFEBEFF6)),
            child: Container(
              margin: EdgeInsets.all(7),
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(
                    "assets/ic_" + name.toLowerCase()+".png",
                  ),
                ),
              ),
            ),
          ),
          SizedBox(height: 4),
          Text(
            name,
            style: blackTextFont.copyWith(
              fontSize: 12,
              fontWeight: regularFontWeight,
            ),
          )
        ],
      ),
    );
  }
}
