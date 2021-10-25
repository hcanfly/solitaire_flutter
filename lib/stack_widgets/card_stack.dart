import 'package:flutter/foundation.dart';
import 'dart:math';
import 'package:solitaire_flutter/card.dart';

class CardStack with ChangeNotifier {
  List<PlayingCard> cards = [];

  void addCard(int value, [bool faceUp = false]) {
    cards.add(PlayingCard(value, faceUp));
    notifyListeners();
  }

  void popCards(int numberToPop) {
    for (int x = 0; x < numberToPop; x++) {
      cards.removeLast();
    }
    notifyListeners();
  }

  void removeAllCards() {
    cards.clear();

    notifyListeners();
  }

  int get length {
    return cards.length;
  }

  bool get isEmpty {
    return cards.isEmpty;
  }

  operator [](int i) => cards[i];
}

class StockStack extends CardStack {
  TalonStack? talonStack;
}

class TalonStack extends CardStack {}

class FoundationStack1 extends CardStack {}

class FoundationStack2 extends CardStack {}

class FoundationStack3 extends CardStack {}

class FoundationStack4 extends CardStack {}

class TableauStack1 extends CardStack {}

class TableauStack2 extends CardStack {}

class TableauStack3 extends CardStack {}

class TableauStack4 extends CardStack {}

class TableauStack5 extends CardStack {}

class TableauStack6 extends CardStack {}

class TableauStack7 extends CardStack {}

// Widget's keys are used for specific things in Flutter, so use this to identify a card's parent
// Used for dragging cards(s)
final _random = Random();
int next(int min, int max) => min + _random.nextInt(max - min);

int getUniqueId() {
  return next(1000, 99999);
}
