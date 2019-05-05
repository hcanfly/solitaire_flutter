enum Suit {
  spade,
  heart,
  diamond,
  club,
}

String suitName(Suit suit) {
  String retString = "";

  switch (suit) {
    case Suit.spade:
      retString = "Spade";
      break;

    case Suit.heart:
      retString = "Heart";
      break;

    case Suit.diamond:
      retString = "Diamond";
      break;

    case Suit.club:
      retString = "Club";
      break;
  }

  return retString;
}

String getDisplayValueForRank(int rank) {
  var retString = "";

  switch (rank) {
    case 0:
      retString = "A";
      break;
    case 10:
      retString = "J";
      break;
    case 11:
      retString = "Q";
      break;
    case 12:
      retString = "K";
      break;
    default:
      retString = (rank + 1).toString();
      break;
  }

  return retString;
}

enum CardColor {
  red,
  black,
}

class PlayingCard {
  Suit suit;
  int rank;
  bool faceUp;
  bool hidden;

  PlayingCard(int deckValue, [bool faceUp = false]) {
    int s = (deckValue / 13).floor();
    switch (s) {
      case 0:
        this.suit = Suit.spade;
        break;

      case 1:
        this.suit = Suit.heart;
        break;

      case 2:
        this.suit = Suit.diamond;
        break;

      case 3:
        this.suit = Suit.club;
        break;
    }

    this.rank = deckValue % 13;
    this.faceUp = faceUp;
    this.hidden = false;
  }

  CardColor get cardColor {
    if (suit == Suit.heart || suit == Suit.diamond) {
      return CardColor.red;
    } else {
      return CardColor.black;
    }
  }

  int get cardValue {
    return (suit.index * 13) + rank;
  }
}

class CardStack {
  List<PlayingCard> cards = List();

  void addCard(int value, [bool faceUp = false]) {
    cards.add(PlayingCard(value, faceUp));
  }

  void popCards(int numberToPop) {
    for (int x = 0; x < numberToPop; x++) {
      cards.removeLast();
    }
  }

  int get length {
    return cards.length;
  }

  operator [](int i) => cards[i];
}

class FoundationStack extends CardStack {}

class TableauStack extends CardStack {}

class StockStack extends CardStack {}

class TalonStack extends CardStack {}
