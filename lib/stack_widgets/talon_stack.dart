import 'package:flutter/material.dart';

import 'card_stack.dart';
import 'package:solitaire_flutter/board_info.dart';
import 'package:solitaire_flutter/card.dart';
import 'package:solitaire_flutter/card_widget.dart';

class TalonStackWidget extends StatefulWidget {
  final TalonStack talonStack;
  final int stackUniqueId = getUniqueId();

  TalonStackWidget({Key? key, required this.talonStack}) : super(key: key);

  @override
  _TalonStackWidgetState createState() => _TalonStackWidgetState();
}

class _TalonStackWidgetState extends State<TalonStackWidget> {
  @override
  Widget build(BuildContext context) {
    return widget.talonStack.isEmpty
        ? Padding(
            padding: const EdgeInsets.only(left: 1.0),
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
        : CardWidget(
            card: widget.talonStack[widget.talonStack.length - 1],
            key: UniqueKey(),
            dragAddCards: (cards) {
              // Drag was cancelled. Add the cards back.
              setState(() {
                // well, almost no setState. Just can't get this to update without UniqueKey and setState.
                widget.talonStack.addCard(cards.first.cardValue, true);
              });
            },
            dragCardsToDrag: (card) {
              List<PlayingCard> cardsToDrag = [];
              cardsToDrag.add(card);
              return cardsToDrag;
            },
            dragStarted: (numberOfCardsToPop) {
              //force stack update on drag start to remove dragged card
              widget.talonStack.popCards(1);
            },
            dragCompleted: () {
              // nothing to do
            },
            stackUniqueId: widget.stackUniqueId,
          );
  }
}
