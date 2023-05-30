import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

class BingoTile extends StatelessWidget {
  const BingoTile({
    required this.text,
    required this.onTapped,
    this.isChecked = false,
    super.key,
  });

  final String text;
  final bool isChecked;
  final void Function() onTapped;

  @override
  Widget build(BuildContext context) {
    final double spacing;
    if (MediaQuery.of(context).size.width <= 1000) {
      spacing = 2;
    } else {
      spacing = 8;
    }

    return GestureDetector(
      onTap: onTapped,
      child: Container(
        margin: EdgeInsets.all(spacing),
        padding: EdgeInsets.all(spacing),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: isChecked ? Colors.black12 : Colors.white,
          border: Border.all(
            color: Colors.black,
            width: 3,
          ),
          borderRadius: const BorderRadius.all(
            Radius.circular(
              10,
            ),
          ),
        ),
        child: SizedBox(
          height: 140,
          width: 140,
          child: Center(
            child: AutoSizeText(
              text,
              minFontSize: 6,
              maxLines: 5,
              wrapWords: false,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 28,
                fontWeight: isChecked ? FontWeight.bold : FontWeight.normal,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
