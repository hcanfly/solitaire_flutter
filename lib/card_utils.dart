import 'package:flutter/material.dart';
import 'card.dart';

var pathRoot = "images/";

Widget imageAssetForCardValue(PlayingCard card) {
  var name = suitName(card.suit);
  if (card.rank > 9 && card.rank < 13) {
    var rankString = getDisplayValueForRank(card.rank);
    rankString = name + "-" + rankString;
    var pathString = pathRoot + rankString + ".png";
    return Image.asset(pathString);
  } else {
    var pathString = pathRoot + name + ".png";
    return Image.asset(pathString);
  }
}

typedef OnDragPopCardsCallback = Function(int numberOfCardsToPop);
typedef OnDragCardsToDragCallback = List<PlayingCard> Function(
    PlayingCard card);
typedef OnDragAddCardsCallback = Function(List<PlayingCard> cardsToAdd);
typedef OnDragCompleted = Function();
typedef StackUniqueId = int Function();
