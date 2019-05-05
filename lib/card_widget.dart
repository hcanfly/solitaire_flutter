import 'package:flutter/material.dart';
import 'board_info.dart';
import 'card.dart';
import 'card_utils.dart';

class CardWidget extends StatefulWidget {
  final PlayingCard card;
  final OnDragPopCardsCallback
      dragStarted; // info needed to interact with Stack while dragging
  final OnDragAddCardsCallback
      dragAddCards; // cards are deleted from stack on drag start. this adds them back to the stack if the drag is cancelled.
  final OnDragCardsToDragCallback
      dragCardsToDrag; // gets List of cards to be dragged from Stack
  final OnDragCompleted dragCompleted; // tell the Stack that the drag is done
  final int
      stackUniqueId; // Stack Id to prevent dragging onto stack that started the drag

  List<PlayingCard> cardsBeingDragged = List();

  CardWidget(
      {@required this.card,
      @required this.dragStarted,
      @required this.dragAddCards,
      @required this.dragCardsToDrag,
      @required this.dragCompleted,
      @required this.stackUniqueId});

  @override
  _CardWidgetState createState() => _CardWidgetState();
}

class _CardWidgetState extends State<CardWidget> {
  @override
  Widget build(BuildContext context) {
    return widget.card.faceUp
        ? Draggable<Map>(
            child: Material(
              color: Colors.transparent,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(6.0),
                  color: Colors.white,
                  border: Border.all(color: Colors.black),
                ),
                height: cardHeight,
                width: cardWidth,
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Align(
                        alignment: Alignment.topRight,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                              getDisplayValueForRank(widget.card.rank),
                              style: TextStyle(
                                fontSize: scaled(14),
                                fontFamily: gameFontFamily,
                                color: (widget.card.suit == Suit.club ||
                                        widget.card.suit == Suit.spade)
                                    ? Colors.black
                                    : Colors.red,
                              ),
                            ),
                            Container(
                              height: scaled(14),
                              child: _imageAssetForSuit(widget.card),
                            )
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 10.0,
                      height: scaled(6),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: <Widget>[
                        Container(
                            height: scaled(38),
                            child: imageAssetForCardValue(widget.card)),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            onDragCompleted: () {
              widget.dragCompleted();
            },
            onDraggableCanceled: (velocity, offset) {
              //restore card(s) to their stack
              widget.dragAddCards(widget.cardsBeingDragged);
            },
            data: {
              "cards": _getCardsBeingDragged(),
              "stack": widget.stackUniqueId
            },
            onDragStarted: () {
              widget.dragStarted(_getCardsBeingDragged()
                  .length); // tell the stack to pop card(s) and redraw
            },
            //childWhenDragging: Container(),
            //  don't use this because will often be dragging more than one card
            feedback: _getDragStack(
                _getCardsBeingDragged()), //_getDraggableCard(widget.card),
          )
        : Container(
            height: cardHeight,
            width: cardWidth,
            child: SizedBox.expand(
              child: Image.asset(
                'images/PlayingCard-back.png',
                fit: BoxFit.fill,
              ),
            ));
  }

  List<PlayingCard> _getCardsBeingDragged() {
    widget.cardsBeingDragged = widget.dragCardsToDrag(widget.card);

    return widget.cardsBeingDragged;
  }
}

// Stack that will be shown during drag
Widget _getDragStack(List<PlayingCard> cards) {
  return Container(
    width: cardWidth,
    height: cardHeight + (14.0 * scaled(cards.length - 1)),
    color: const Color(0xFF004D2C),
    child: Stack(
      children: cards.map((card) {
        int index = cards.indexOf(card);
        return Positioned(
          top: 16.0 * scaled(index),
          child: _getDraggableCard(card),
        );
      }).toList(),
    ),
  );
}

// Card that will be shown in DragStack
Widget _getDraggableCard(PlayingCard card) {
  return Material(
    color: Colors.transparent,
    child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6.0),
          color: Colors.white,
          border: Border.all(color: Colors.black),
        ),
        height: cardHeight,
        width: cardWidth,
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: Align(
                alignment: Alignment.topRight,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      getDisplayValueForRank(card.rank),
                      style: TextStyle(
                        fontSize: scaled(14),
                        fontFamily: gameFontFamily,
                        color:
                            (card.suit == Suit.club || card.suit == Suit.spade)
                                ? Colors.black
                                : Colors.red,
                      ),
                    ),
                    Container(
                      height: scaled(12),
                      child: _imageAssetForSuit(card),
                    )
                  ],
                ),
              ),
            ),
            SizedBox(
              width: 10.0,
              height: 6.0 * itemScale,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                Container(
                    height: scaled(38), child: imageAssetForCardValue(card)),
              ],
            ),
          ],
        )),
  );
}

Widget _imageAssetForSuit(PlayingCard card) {
  var name = suitName(card.suit);

  return Image.asset("images/" + name + ".png");
}
