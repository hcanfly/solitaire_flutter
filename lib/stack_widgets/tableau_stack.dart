import 'package:flutter/material.dart';

import '../board_info.dart';
import '../card.dart';
import '../card_widget.dart';

class TableauStackWidget extends StatefulWidget {
  final int stackIndex;
  final int stackUniqueId = getUniqueId();

  TableauStackWidget({@required this.stackIndex});

  @override
  _TableauStackWidgetState createState() => _TableauStackWidgetState();
}

class _TableauStackWidgetState extends State<TableauStackWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: cardWidth,
      height: cardHeight +
          (scaled(17.0) *
              scaled(tableauStacks[widget.stackIndex].cards.length -
                  1)), // (14.0 * scaled(tableauStacks[widget.stackIndex].cards.length - 1))    // cardHeight * 4.0
      color: const Color(0xFF004D2C),
      child: DragTarget<Map>(
        builder: (context, candidateData, rejectedData) {
          return Align(
            alignment: Alignment.topCenter,
            child: Stack(
              children: tableauStacks[widget.stackIndex].cards.map((card) {
                int index =
                    tableauStacks[widget.stackIndex].cards.indexOf(card);
                return Positioned(
                  top: 17.0 * scaled(index),
                  child: CardWidget(
                    card: card,
                    dragAddCards: (cards) {
                      setState(() {
                        // Drag was cancelled. Add the cards back.
                        cards.forEach((card) => tableauStacks[widget.stackIndex]
                            .addCard(card.cardValue, true));
                      });
                    },
                    dragCardsToDrag: (card) {
                      List<PlayingCard> cardsToDrag = List();
                      cardsToDrag.add(card);
                      int index =
                          tableauStacks[widget.stackIndex].cards.indexOf(card);
                      if (index !=
                          tableauStacks[widget.stackIndex].cards.length - 1) {
                        for (int x = index + 1;
                            x < tableauStacks[widget.stackIndex].cards.length;
                            x++) {
                          cardsToDrag
                              .add(tableauStacks[widget.stackIndex].cards[x]);
                        }
                      }
                      return cardsToDrag;
                    },
                    dragStarted: (numberOfCardsToPop) {
                      setState(() {
                        //force stack update on drag start to remove dragged cards
                        tableauStacks[widget.stackIndex]
                            .popCards(numberOfCardsToPop);
                      });
                    },
                    dragCompleted: () {
                      setState(() {
                        // Cards were successfully dropped on another stack. Turn top card face up.
                        if (tableauStacks[widget.stackIndex].cards.length > 0) {
                          PlayingCard topCard =
                              tableauStacks[widget.stackIndex].cards.last;
                          topCard.faceUp = true;
                        }
                      });
                    },
                    stackUniqueId: widget.stackUniqueId,
                  ),
                );
              }).toList(),
            ),
          );
        },
        onWillAccept: (data) {
          int stack = data["stack"];
          if (stack == widget.stackUniqueId) {
            return false;
          }

          List<PlayingCard> draggedCards = data["cards"];
          PlayingCard droppedCard = draggedCards.first;

          if (tableauStacks[widget.stackIndex].cards.isEmpty) {
            // if the stack is empty can only drop a King on it
            if (droppedCard.rank == 12) {
              return true;
            } else {
              return false;
            }
          }

          PlayingCard topCard = tableauStacks[widget.stackIndex].cards.last;
          return ((topCard.cardColor != droppedCard.cardColor) &&
              (droppedCard.rank == (topCard.rank - 1)));
        },
        onAccept: (data) {
          setState(() {
            //force stack update to show new cards
            List<PlayingCard> draggedCards = data["cards"];
            draggedCards.forEach((card) =>
                tableauStacks[widget.stackIndex].addCard(card.cardValue, true));
          });
        },
      ),
    );
  }
}
