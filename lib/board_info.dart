import '/stack_widgets/card_stack.dart';

// Stacks and Cards

// Separate types for stack Provider to look up
TableauStack1 tableauStack1 = TableauStack1();
TableauStack2 tableauStack2 = TableauStack2();
TableauStack3 tableauStack3 = TableauStack3();
TableauStack4 tableauStack4 = TableauStack4();
TableauStack5 tableauStack5 = TableauStack5();
TableauStack6 tableauStack6 = TableauStack6();
TableauStack7 tableauStack7 = TableauStack7();
List<CardStack> _tableauStacks =
    []; // convenience wrapper so we can iterate on init and reset

FoundationStack1 foundationStack1 = FoundationStack1();
FoundationStack2 foundationStack2 = FoundationStack2();
FoundationStack3 foundationStack3 = FoundationStack3();
FoundationStack4 foundationStack4 = FoundationStack4();
List<CardStack> _foundationStacks =
    []; // convenience wrapper so we can iterate on init and reset

StockStack stockStack = StockStack();
TalonStack talonStack = TalonStack();

List<int> _deck = [];

void initializeDeck() {
  // initialize deck with card values
  for (int x = 0; x < 52; x++) {
    _deck.add(x);
  }

  _tableauStacks.add(tableauStack1);
  _tableauStacks.add(tableauStack2);
  _tableauStacks.add(tableauStack3);
  _tableauStacks.add(tableauStack4);
  _tableauStacks.add(tableauStack5);
  _tableauStacks.add(tableauStack6);
  _tableauStacks.add(tableauStack7);

  _foundationStacks.add(foundationStack1);
  _foundationStacks.add(foundationStack2);
  _foundationStacks.add(foundationStack3);
  _foundationStacks.add(foundationStack4);

  for (int x = 0; x < 4; x++) {
    _foundationStacks[x].cards = [];
  }

  for (int x = 0; x < 7; x++) {
    _tableauStacks[x].cards = [];
  }

  stockStack.talonStack = talonStack;

  dealCards();
}

void shuffleCards() {
  _deck.shuffle();
}

void dealCards() {
  for (int x = 0; x < 7; x++) {
    _tableauStacks[x].removeAllCards();
  }
  for (int x = 0; x < 4; x++) {
    _foundationStacks[x].removeAllCards();
  }

  talonStack.removeAllCards();
  stockStack.removeAllCards();

  shuffleCards();

  int cardIndex = 0;
  for (int x = 0; x < 7; x++) {
    for (int y = 0; y <= x; y++) {
      _tableauStacks[x].addCard(_deck[cardIndex++], x == y);
    }
  }

  for (int x = cardIndex; x < 52; x++) {
    stockStack.addCard(_deck[cardIndex++]);
  }
}

// Display, layout and utility
const gameFontFamily = "Domine";

double cardSpacing = 0.0;
double cardWidth = 0.0;
double cardHeight = 0.0;
double itemScale = 1.0;

double scaled(num value) {
  return (value * itemScale);
}
