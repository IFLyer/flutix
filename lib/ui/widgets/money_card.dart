part of 'widgets.dart';

class MoneyCard extends StatelessWidget {
  final bool isSelected;
  final double width;
  final double height;
  final Function onTap;
  final int amount;
  MoneyCard(this.amount,
      {this.isSelected = false, this.width = 90, this.height = 60, this.onTap});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (onTap != null) {
          onTap();
        }
      },
      child: Container(
          width: width,
          height: height,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(6),
            color: isSelected ? accentColor2 : Colors.transparent,
            border: Border.all(
              color: isSelected ? Colors.transparent : Color(0xFFE4E4E4),
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Rp",
                style: greyTextFont.copyWith(
                    fontSize: 16, fontWeight: regularFontWeight),
              ),
              SizedBox(height: 6),
              Text(
                NumberFormat.currency(
                        locale: "id_ID", symbol: "", decimalDigits: 0)
                    .format(amount),
                style: blackNumberFont.copyWith(
                    fontSize: 16, fontWeight: regularFontWeight),
              ),
            ],
          )),
    );
  }
}
