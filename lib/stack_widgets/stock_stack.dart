import 'package:flutter/material.dart';

import '../board_info.dart';
import '../card_widget.dart';
import 'card_stack.dart';

class StockStackWidget extends StatefulWidget {
  final CardStack stockStack;
  final int stackUniqueId = getUniqueId();

  StockStackWidget({Key? key, required this.stockStack}) : super(key: key);

  @override
  _StockStackWidgetState createState() => _StockStackWidgetState();
}

class _StockStackWidgetState extends State<StockStackWidget> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: widget.stockStack.isEmpty
          ? Padding(
              padding: EdgeInsets.only(left: scaled(2)),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.0),
                  border: Border.all(color: Colors.white),
                  color: Colors.transparent,
                ),
                height: cardHeight,
                width: cardWidth,
                child: Center(child: Container()),
              ),
            )
          : Padding(
              padding: EdgeInsets.only(left: scaled(2)),
              child: CardWidget(
                  dragAddCards: null, // can't drag cards from Stock stack
                  dragCardsToDrag: null,
                  dragCompleted: null,
                  stackUniqueId: widget.stackUniqueId,
                  card: widget.stockStack[widget.stockStack.length - 1],
                  dragStarted: null),
            ),
      onTap: () {
        if (widget.stockStack.isEmpty) {
          if (!(widget.stockStack as StockStack).talonStack!.isEmpty) {
            // stock stack is empty. move cards back from talon stack
            widget.stockStack.cards = (widget.stockStack as StockStack)
                .talonStack!
                .cards
                .reversed
                .toList();
            for (var card in widget.stockStack.cards) {
              card.faceUp = false;
            }
            widget.stockStack.popCards(0); // force refresh
            (widget.stockStack as StockStack).talonStack!.removeAllCards();
          }
        } else {
          //move top card to talon stack and flip up
          var card = widget.stockStack.cards.last;
          var cardValue = card.cardValue;
          (widget.stockStack as StockStack)
              .talonStack!
              .addCard(cardValue, true);
          widget.stockStack.popCards(1);
        }
      },
    );
  }
}
