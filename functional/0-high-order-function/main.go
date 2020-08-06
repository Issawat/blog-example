package main

import "fmt"

type words []string
type wordsFiltered func(words) words
type wordCondition func(string) bool

func main() {
	groupA := words{"the", "quick", "brown", "fox", "jumps", "over", "the", "lazy", "dog"}

	conditionA := anyConditions([]wordCondition{
		sameWordAt("over"),
		haveOddCharacter,
	})

	conditionB := allConditions([]wordCondition{
		haveAlphabet,
		haveEvenCharacter,
	})

	wordFilterABy := wordFilter(conditionA)
	wordFilterBBy := wordFilter(conditionB)

	fmt.Printf("Condition A: %+v\n", wordFilterABy(groupA))
	fmt.Printf("Condition B: %+v\n", wordFilterBBy(groupA))
}

func anyConditions(conditions []wordCondition) wordCondition {
	return func(word string) bool {
		for _, c := range conditions {
			if c(word) {
				return true
			}
		}
		return false
	}
}

func allConditions(conditions []wordCondition) wordCondition {
	return func(word string) bool {
		for _, c := range conditions {
			if !c(word) {
				return false
			}
		}
		return true
	}
}

func wordFilter(condition wordCondition) wordsFiltered {
	return func(ws words) words {
		var newWords words
		for _, word := range ws {
			if condition(word) {
				newWords = append(newWords, word)
			}
		}
		return newWords
	}
}

func haveAlphabet(word string) bool {
	for _, c := range word {
		if c == 'a' || c == 'e' || c == 'i' || c == 'o' || c == 'u' {
			return true
		}
	}
	return false
}

func haveEvenCharacter(word string) bool {
	return len(word)%2 == 0
}

func haveOddCharacter(word string) bool {
	return len(word)%2 != 0
}

func sameWordAt(wordCondition string) wordCondition {
	return func(word string) bool {
		return wordCondition == word
	}
}
