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
  Suit suit = Suit.club;
  int rank = 0;
  bool _faceUp = false;
  bool hidden = false;

  PlayingCard(int deckValue, [bool faceUp = false]) {
    int s = (deckValue / 13).floor();
    switch (s) {
      case 0:
        suit = Suit.spade;
        break;

      case 1:
        suit = Suit.heart;
        break;

      case 2:
        suit = Suit.diamond;
        break;

      case 3:
        suit = Suit.club;
        break;
    }

    rank = deckValue % 13;
    _faceUp = faceUp;
    hidden = false;
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

  bool get faceUp {
    return _faceUp == true;
  }

  set faceUp(bool value) {
    _faceUp = value;
  }
}
