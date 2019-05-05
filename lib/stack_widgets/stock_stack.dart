import 'package:flutter/material.dart';

import '../board_info.dart';
import '../card_widget.dart';

class StockStackWidget extends StatefulWidget {
  final ValueChanged<int> parentRefresh;
  final int stackUniqueId = getUniqueId();

  StockStackWidget({Key key, this.parentRefresh});

  @override
  _StockStackWidgetState createState() => _StockStackWidgetState();
}

class _StockStackWidgetState extends State<StockStackWidget> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: stockStack.length == 0
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
                  card: stockStack[stockStack.length - 1],
                  dragStarted: null),
            ),
      onTap: () {
        setState(() {
          if (stockStack.length == 0) {
            if (talonStack.length > 0) {
              // copy cards back from talon stack
              stockStack.cards = talonStack.cards.reversed.toList();
              stockStack.cards.forEach((card) => card.faceUp = false);
              talonStack.cards.clear();
              widget.parentRefresh(0);
            }
          } else {
            //move top card to talon stack and flip up
            var card = stockStack.cards.last;
            var cardValue = card.cardValue;
            talonStack.addCard(cardValue, true);
            stockStack.popCards(1);
            widget.parentRefresh(0);
          }
        });
      },
    );
  }
}
