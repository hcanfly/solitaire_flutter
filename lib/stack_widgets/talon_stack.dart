import 'package:flutter/material.dart';

import '../board_info.dart';
import '../card.dart';
import '../card_widget.dart';

class TalonStackWidget extends StatefulWidget {
  final ValueChanged<int> parentRefresh;
  final int stackUniqueId = getUniqueId();

  TalonStackWidget({Key key, this.parentRefresh});

  @override
  _TalonStackWidgetState createState() => _TalonStackWidgetState();
}

class _TalonStackWidgetState extends State<TalonStackWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
        width: cardWidth,
        height: cardHeight,
        color: const Color(0xFF004D2C),
        child: talonStack.length == 0
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
            : IndexedStack(
                index: talonStack.cards.length - 1,
                children: talonStack.cards.map((card) {
                  return Positioned(
                    top: 0.0,
                    child: CardWidget(
                      card: card,
                      dragAddCards: (cards) {
                        setState(() {
                          // Drag was cancelled. Add the cards back.
                          cards.forEach((card) =>
                              talonStack.addCard(card.cardValue, true));
                        });
                      },
                      dragCardsToDrag: (card) {
                        List<PlayingCard> cardsToDrag = List();
                        cardsToDrag.add(card);
                        return cardsToDrag;
                      },
                      dragStarted: (numberOfCardsToPop) {
                        setState(() {
                          //force stack update on drag start to remove dragged card
                          talonStack.popCards(numberOfCardsToPop);
                        });
                      },
                      dragCompleted: () {
                        setState(() {
                          // Cards were successfully dropped on another stack. Turn top card face up.
                          if (talonStack.cards.length > 0) {
                            PlayingCard topCard = talonStack.cards.last;
                            topCard.faceUp = true;
                          }
                        });
                      },
                      stackUniqueId: widget.stackUniqueId,
                    ),
                  );
                }).toList(),
              ));
  }
}
