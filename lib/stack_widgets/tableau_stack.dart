import 'package:flutter/material.dart';

import '../board_info.dart';
import '../card.dart';
import '../card_widget.dart';
import 'card_stack.dart';

class TableauStackWidget extends StatefulWidget {
  final CardStack tableauStack;
  final int stackUniqueId = getUniqueId();

  TableauStackWidget({Key? key, required this.tableauStack}) : super(key: key);

  @override
  _TableauStackWidgetState createState() => _TableauStackWidgetState();
}

class _TableauStackWidgetState extends State<TableauStackWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: cardWidth,
      height: (17.0 * scaled(17.0)) + 10.0,
      color: const Color(0xFF004D2C),
      child: DragTarget<Map>(
        builder: (context, candidateData, rejectedData) {
          return Align(
            alignment: Alignment.topCenter,
            child: Stack(
              children: widget.tableauStack.cards.map((card) {
                int index = widget.tableauStack.cards.indexOf(card);
                return Positioned(
                  top: 17.0 * scaled(index),
                  child: CardWidget(
                    card: card,
                    dragAddCards: (cards) {
                      // Drag was cancelled. Add the cards back.
                      for (var card in cards) {
                        widget.tableauStack.addCard(card.cardValue, true);
                      }
                    },
                    dragCardsToDrag: (card) {
                      List<PlayingCard> cardsToDrag = [];
                      cardsToDrag.add(card);
                      int index = widget.tableauStack.cards.indexOf(card);
                      if (index != widget.tableauStack.cards.length - 1) {
                        for (int x = index + 1;
                            x < widget.tableauStack.cards.length;
                            x++) {
                          cardsToDrag.add(widget.tableauStack.cards[x]);
                        }
                      }
                      return cardsToDrag;
                    },
                    dragStarted: (numberOfCardsToPop) {
                      widget.tableauStack.popCards(numberOfCardsToPop);
                    },
                    dragCompleted: () {
                      // Cards were successfully dropped on another stack. Turn top card face up.
                      if (widget.tableauStack.cards.isNotEmpty) {
                        PlayingCard topCard = widget.tableauStack.cards.last;
                        topCard.faceUp = true;
                        widget.tableauStack.popCards(0);
                      }
                    },
                    stackUniqueId: widget.stackUniqueId,
                  ),
                );
              }).toList(),
            ),
          );
        },
        onWillAccept: (data) {
          int stack = data!["stack"];
          if (stack == widget.stackUniqueId) {
            return false;
          }

          List<PlayingCard> draggedCards = data["cards"];
          PlayingCard droppedCard = draggedCards.first;

          if (widget.tableauStack.cards.isEmpty) {
            // if the stack is empty can only drop a King on it
            if (droppedCard.rank == 12) {
              return true;
            } else {
              return false;
            }
          }

          PlayingCard topCard = widget.tableauStack.cards.last;
          return ((topCard.cardColor != droppedCard.cardColor) &&
              (droppedCard.rank == (topCard.rank - 1)));
        },
        onAccept: (data) {
          List<PlayingCard> draggedCards = data["cards"];
          for (var card in draggedCards) {
            widget.tableauStack.addCard(card.cardValue, true);
          }
        },
      ),
    );
  }
}
