import 'package:flutter/material.dart';
import 'card.dart';

Widget imageAssetForCardValue(PlayingCard card) {
  var name = suitName(card.suit);
  if (card.rank > 9 && card.rank < 13) {
    var rankString = getDisplayValueForRank(card.rank);
    rankString = name + "-" + rankString;
    var pathString = "images/" + rankString + ".png";
    return Image.asset(pathString);
  } else {
    var pathString = "images/" + name + ".png";
    return Image.asset(pathString);
  }
}

typedef Null OnDragPopCardsCallback(int numberOfCardsToPop);
typedef List<PlayingCard> OnDragCardsToDragCallback(PlayingCard card);
typedef Null OnDragAddCardsCallback(List<PlayingCard> cardsToAdd);
typedef Null OnDragCompleted();
typedef int StackUniqueId();
