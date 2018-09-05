class Guess {
  int index;
  String text;
  double confidence;

  Guess({int this.index, String this.text, double this.confidence});

  @override
  String toString() {
    return 'Index: $index | Confidence: $confidence | $text';
  }
}