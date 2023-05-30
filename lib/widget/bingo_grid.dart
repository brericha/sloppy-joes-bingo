import 'package:confetti/confetti.dart';
import 'package:fk_bingo/widget/bingo_tile.dart';
import 'package:flutter/material.dart';

class BingoGrid extends StatefulWidget {
  const BingoGrid({required this.items, super.key});

  final List<String> items;

  @override
  State<BingoGrid> createState() => _BingoGridState();
}

class _BingoGridState extends State<BingoGrid> {
  List<bool> _checked = [];

  late ConfettiController _confettiController;

  void _resetCheckedItems() =>
      _checked = widget.items.map((e) => e == 'Free Space').toList();

  @override
  void initState() {
    super.initState();
    _resetCheckedItems();
    _confettiController =
        ConfettiController(duration: const Duration(seconds: 2));
  }

  @override
  void dispose() {
    _confettiController.dispose();
    super.dispose();
  }

  @override
  didUpdateWidget(covariant oldWidget) {
    super.didUpdateWidget(oldWidget);
    _resetCheckedItems();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 5,
          ),
          shrinkWrap: true,
          itemCount: widget.items.length,
          itemBuilder: (context, index) {
            return BingoTile(
              text: widget.items[index],
              isChecked: _checked[index],
              onTapped: () {
                // Don't let the user un-check the free space
                if (index != 12) {
                  setState(() => _checked[index] = !_checked[index]);
                  if (hasWinningRow()) {
                    _confettiController.play();
                  }
                }
              },
            );
          },
        ),
        Padding(
          padding: const EdgeInsets.only(top: 78),
          child: Align(
            child: ConfettiWidget(
              confettiController: _confettiController,
              blastDirectionality: BlastDirectionality.explosive,
              numberOfParticles: 10,
              colors: const [
                Colors.green,
                Colors.blue,
                Colors.red,
                Colors.orange,
                Colors.purple,
                Colors.pink,
                Colors.yellow,
              ],
            ),
          ),
        )
      ],
    );
  }

  bool hasWinningRow() {
    // Horizontal
    if (_checked.sublist(0, 5).every((e) => e == true)) return true;
    if (_checked.sublist(5, 10).every((e) => e == true)) return true;
    if (_checked.sublist(10, 15).every((e) => e == true)) return true;
    if (_checked.sublist(15, 20).every((e) => e == true)) return true;
    if (_checked.sublist(20).every((e) => e == true)) return true;

    // Vertical
    if ([_checked[0], _checked[5], _checked[10], _checked[15], _checked[20]]
        .every((e) => e == true)) return true;
    if ([_checked[1], _checked[6], _checked[11], _checked[16], _checked[21]]
        .every((e) => e == true)) return true;
    if ([_checked[2], _checked[7], _checked[12], _checked[17], _checked[22]]
        .every((e) => e == true)) return true;
    if ([_checked[3], _checked[8], _checked[13], _checked[18], _checked[23]]
        .every((e) => e == true)) return true;
    if ([_checked[4], _checked[9], _checked[14], _checked[19], _checked[24]]
        .every((e) => e == true)) return true;

    // Diagonal
    if ([_checked[0], _checked[6], _checked[12], _checked[18], _checked[24]]
        .every((e) => e == true)) return true;
    if ([_checked[4], _checked[8], _checked[12], _checked[16], _checked[20]]
        .every((e) => e == true)) return true;

    return false;
  }
}
