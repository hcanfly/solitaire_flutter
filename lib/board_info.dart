import 'dart:math';

import 'card.dart';

// Stacks and Cards
List<TableauStack> tableauStacks = List(7);
List<FoundationStack> foundationStacks = List(4);
StockStack stockStack = StockStack();
TalonStack talonStack = TalonStack();

var _deck = List<int>(52);

void initializeDeck() {
  for (int x = 0; x < 52; x++) {
    _deck[x] = x;
  }

  for (int x = 0; x < 4; x++) {
    foundationStacks[x] = FoundationStack();
    foundationStacks[x].cards = List();
  }

  for (int x = 0; x < 7; x++) {
    tableauStacks[x] = TableauStack();
    tableauStacks[x].cards = List();
  }

  dealCards();
}

void shuffleCards() {
  _deck.shuffle();
}

void dealCards() {
  for (int x = 0; x < 7; x++) {
    tableauStacks[x].cards.clear();
  }
  for (int x = 0; x < 4; x++) {
    foundationStacks[x].cards.clear();
  }
  talonStack.cards.clear();
  stockStack.cards.clear();

  shuffleCards();

  int cardIndex = 0;
  for (int x = 0; x < 7; x++) {
    for (int y = 0; y <= x; y++) {
      tableauStacks[x].addCard(_deck[cardIndex++], x == y);
    }
  }

  for (int x = cardIndex; x < 52; x++) {
    stockStack.addCard(_deck[cardIndex++]);
  }
}

// Display, layout and utility
const gameFontFamily = "Domine";

double cardSpacing;
double cardWidth;
double cardHeight;
double itemScale = 1.0;

double scaled(num value) {
  return (value * itemScale);
}

final _random = Random();
int next(int min, int max) => min + _random.nextInt(max - min);

// Widget's keys are used for specific things in Flutter, so use this to identify a card's parent
int getUniqueId() {
  return next(1000, 99999);
}
