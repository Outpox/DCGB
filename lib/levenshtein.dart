import 'dart:math';

abstract class StringDistance {
  int distance(String s1, String s2);
}

abstract class NormalizedStringDistance {
  /// Returns a similarity between 0.0 (exact same) and 1.0 (completely different).
  double normalizedDistance(String s1, String s2);
}

/// The Levenshtein distance, or edit distance, between two words is the
/// minimum number of single-character edits (insertions, deletions or
/// substitutions) required to change one word into the other.
class Levenshtein implements StringDistance, NormalizedStringDistance {
  @override
  int distance(String s1, String s2) {
    if (s1 == s2) {
      return 0;
    }

    if (s1.length == 0) {
      return s2.length;
    }

    if (s2.length == 0) {
      return s1.length;
    }

    List<int> v0 = new List<int>(s2.length + 1);
    List<int> v1 = new List<int>(s2.length + 1);
    List<int> vtemp;

    for (var i = 0; i < v0.length; i++) {
      v0[i] = i;
    }

    for (var i = 0; i < s1.length; i++) {
      v1[0] = i + 1;

      for (var j = 0; j < s2.length; j++) {
        int cost = 1;
        if (s1.codeUnitAt(i) == s2.codeUnitAt(j)) {
          cost = 0;
        }
        v1[j + 1] = min(v1[j] + 1, min(v0[j + 1] + 1, v0[j] + cost));
      }

      vtemp = v0;
      v0 = v1;
      v1 = vtemp;
    }

    return v0[s2.length];
  }

  @override
  double normalizedDistance(String s1, String s2) {
    int maxLength = max(s1.length, s2.length);
    if (maxLength == 0) {
      return 0.0;
    }
    return distance(s1, s2) / maxLength;
  }
}