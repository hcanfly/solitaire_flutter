import 'package:flutter/material.dart';

import '../board_info.dart';
import '../card.dart';
import '../card_widget.dart';

class FoundationStackWidget extends StatefulWidget {
  final int stackIndex;
  final int stackUniqueId = getUniqueId();

  FoundationStackWidget({@required this.stackIndex});

  @override
  _FoundationStackWidgetState createState() => _FoundationStackWidgetState();
}

class _FoundationStackWidgetState extends State<FoundationStackWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: cardWidth,
      height: cardHeight,
      color: const Color(0xFF004D2C),
      child: foundationStacks[widget.stackIndex].length == 0
          ? DragTarget<Map>(
              builder: (context, candidateData, rejectedData) {
                return Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.0),
                    border: Border.all(color: Colors.white),
                    color: Colors.transparent,
                  ),
                  height: cardHeight,
                  width: cardWidth,
                  child: Center(
                    child: Text(
                      "A",
                      style: TextStyle(
                        fontSize: scaled(40),
                        fontFamily: gameFontFamily,
                        color: Colors.white,
                      ),
                    ),
                  ),
                );
              },
              onWillAccept: (data) {
                List<PlayingCard> draggedCards = data["cards"];
                PlayingCard droppedCard = draggedCards.first;

                return (draggedCards.length == 1 && droppedCard.rank == 0);
              },
              onAccept: (data) {
                setState(() {
                  // Add and show dropped cards
                  List<PlayingCard> draggedCards = data["cards"];
                  foundationStacks[widget.stackIndex]
                      .addCard(draggedCards[0].cardValue, true);
                });
              },
            )
          : DragTarget<Map>(
              builder: (context, candidateData, rejectedData) {
                return IndexedStack(
                  index: foundationStacks[widget.stackIndex].cards.length - 1,
                  children:
                      foundationStacks[widget.stackIndex].cards.map((card) {
                    return Positioned(
                      top: 0.0,
                      child: CardWidget(
                        card: card,
                        dragAddCards: (cards) {
                          setState(() {
                            // Drag was cancelled. Add the cards back.
                            cards.forEach((card) =>
                                foundationStacks[widget.stackIndex]
                                    .addCard(card.cardValue, true));
                          });
                        },
                        dragCardsToDrag: (card) {
                          List<PlayingCard> cardsToDrag = List();
                          cardsToDrag.add(card);
                          return cardsToDrag;
                        },
                        dragStarted: (numberOfCardsToPop) {
                          setState(() {
                            //force stack update on drag start to remove dragged cards
                            foundationStacks[widget.stackIndex]
                                .popCards(numberOfCardsToPop);
                          });
                        },
                        dragCompleted: () {
                          // any cleanup after successfully dropping cards elsewhere.
                        },
                        stackUniqueId: widget.stackUniqueId,
                      ),
                    );
                  }).toList(),
                );
              },
              onWillAccept: (data) {
                int stack = data["stack"];
                List<PlayingCard> draggedCards = data["cards"];
                if (stack == widget.stackUniqueId || draggedCards.length > 1) {
                  return false;
                }

                PlayingCard droppedCard = draggedCards.first;
                PlayingCard topCard =
                    foundationStacks[widget.stackIndex].cards.last;
                return (topCard == null && droppedCard.rank == 0) ||
                    ((topCard.suit == droppedCard.suit) &&
                        (droppedCard.rank == (topCard.rank + 1)));
              },
              onAccept: (data) {
                setState(() {
                  // Add and show dropped cards
                  List<PlayingCard> draggedCards = data["cards"];
                  foundationStacks[widget.stackIndex]
                      .addCard(draggedCards[0].cardValue, true);
                });
              },
            ),
    );
  }
}
