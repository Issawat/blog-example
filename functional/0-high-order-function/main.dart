typedef List<String> WordsFiltered(List<String> words);
typedef bool WordCondition(String string);

void main() {
  List<String> groupA = [
    "the",
    "quick",
    "brown",
    "fox",
    "jumps",
    "over",
    "the",
    "lazy",
    "dog"
  ];

  WordCondition conditionA = anyCondition(<WordCondition>[
		isSameWordAt("over"),
		haveOddCharacter,
  ]);

	WordCondition conditionB = allCondition(<WordCondition>[
		haveAlphabet,
		haveEvenCharacter,
  ]);

	WordsFiltered wordFilterABy = wordFilter(conditionA);
	WordsFiltered wordFilterBBy = wordFilter(conditionB);

	print("Condition A: ${wordFilterABy(groupA)}\n");
	print("Condition B: ${wordFilterBBy(groupA)}\n");
}

WordCondition anyCondition(List<WordCondition> conditions) {
    bool condition(String word) {
      for (WordCondition condition in conditions) {
        if (condition(word)) return true;
      }
      return false;
    }

    return condition;
  }

  WordCondition allCondition(List<WordCondition> conditions) {
    bool condition(String word) {
      for (WordCondition condition in conditions) {
        if (!condition(word)) return false;
      }
      return true;
    }

    return condition;
  }

  WordsFiltered wordFilter(WordCondition condition) {
    List<String> filtering(List<String> words) {
      List<String> filtered = [];
      for (String word in words) {
        if (condition(word)) filtered.add(word);
      }
      return filtered;
    }

    return filtering;
  }

  bool haveAlphabet(String word) {
    for (String c in word.split("")) {
      if (c == 'a' || c == 'e' || c == 'i' || c == 'o' || c == 'u') {
        return true;
      }
    }
    return false;
  }

  bool haveEvenCharacter(String word) {
    return word.length % 2 == 0;
  }

  bool haveOddCharacter(String word) {
    return word.length % 2 != 0;
  }

  WordCondition isSameWordAt(String inputWord) {
    bool condition(String word) {
      return inputWord == word;
    }

    return condition;
  }
