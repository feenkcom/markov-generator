"
I examplify Markov algorithm generating random sentences.
For more documentation, I recommend you to start with ${class:MgMarkov}$.
"
Class {
	#name : #MgMarkovExamples,
	#superclass : #Object,
	#category : #'Markov-Generator'
}

{ #category : #dictionary }
MgMarkovExamples >> dictionaryGenerator [
	<gtExample>
	| aGenerator |
	aGenerator := MgMarkovDictionaryGenerator new.
	self assert: aGenerator dictionary keys isEmpty.
	^ aGenerator
]

{ #category : #words }
MgMarkovExamples >> emptyLinkedWords [
	<gtExample>
	| aWords |
	aWords := MgMarkovLinkedWords new.
	self assert: aWords numberOfWords equals: 0.
	^ aWords
]

{ #category : #sentences }
MgMarkovExamples >> firstSentence [
	^ 'We developed humane assessment to help your team to make better technical decisions and steer agile architecture.'
]

{ #category : #words }
MgMarkovExamples >> firstWord [
	<gtExample>
	^ 'We'
]

{ #category : #dictionary }
MgMarkovExamples >> generatedDictionary [
	<gtExample>
	| aGenerator aKey |
	aGenerator := self dictionaryGenerator.
	aGenerator readString: self threeSentences.
	self assert: aGenerator dictionary keys isNotEmpty.
	aKey := (aGenerator dictionary at: MgMarkovBeginKey uniqueInstance) atRandom.
	self assert: (aGenerator dictionary includesKey: aKey).
	^ aGenerator dictionary
]

{ #category : #dictionary }
MgMarkovExamples >> generatedDictionaryWithInitials [
	<gtExample>
	| aGenerator aKey |
	aGenerator := self dictionaryGenerator.
	aGenerator readString: self sentenceWithInitials.
	self assert: aGenerator dictionary keys isNotEmpty.
	aKey := (aGenerator dictionary at: MgMarkovBeginKey uniqueInstance) atRandom.
	self assert: (aGenerator dictionary includesKey: aKey).
	^ aGenerator dictionary
]

{ #category : #markov }
MgMarkovExamples >> generatedSentence [
	<gtExample>
	| aMarkov aText |
	aMarkov := self markovWithDictionary.
	aText := aMarkov generateText.
	self assert: aText isNotNil.
	self assert: aText isNotEmpty.
	^ aText
]

{ #category : #markov }
MgMarkovExamples >> markov [
	<gtExample>
	| aMarkov |
	aMarkov := MgMarkov new.
	self assert: aMarkov dictionary isNil.
	self assert: aMarkov maxWordsInSentence isNotNil.
	self assert: aMarkov maxWordsInSentence > 0.
	^ aMarkov
]

{ #category : #markov }
MgMarkovExamples >> markovWithDictionary [
	<gtExample>
	| aMarkov aDictionary |
	aMarkov := self markov.
	aDictionary := self generatedDictionary.
	aMarkov dictionary: aDictionary.
	self assert: aMarkov dictionary equals: aDictionary.
	^ aMarkov
]

{ #category : #markov }
MgMarkovExamples >> markovWithDictionaryWithInitials [
	<gtExample>
	| aMarkov aDictionary |
	aMarkov := self markov.
	aDictionary := self generatedDictionaryWithInitials.
	aMarkov dictionary: aDictionary.
	self assert: aMarkov dictionary equals: aDictionary.
	^ aMarkov
]

{ #category : #words }
MgMarkovExamples >> newWordFromExisting [
	<gtExample>
	| aFirstWords aSecondWords aFirstCollection |
	aFirstWords := self twoLinkedWords.
	aFirstCollection := aFirstWords words copy.
	aSecondWords := aFirstWords fromWord: self thirdWord.
	self assert: aFirstWords words equals: aFirstCollection.
	self assert: aFirstWords ~= aSecondWords.
	self assert: aSecondWords words first equals: aFirstWords words second.
	self assert: aSecondWords words second equals: self thirdWord.
	self assert: aFirstWords numberOfWords equals: aSecondWords numberOfWords.
	^ Array with: aFirstWords with: aSecondWords
]

{ #category : #sentences }
MgMarkovExamples >> secondSentence [
	^ 'We capture ideas as executable specifications and tell exciting stories with your systems.'
]

{ #category : #words }
MgMarkovExamples >> secondWord [
	<gtExample>
	^ 'developed'
]

{ #category : #tokenizer }
MgMarkovExamples >> sentenceTokenizer [
	<gtExample>
	| aTokenizer |
	aTokenizer := MgMarkovSentenceTokenizer new.
	^ aTokenizer
]

{ #category : #sentences }
MgMarkovExamples >> sentenceWithInitials [
	^ 'In 1958 Margulies tracked down the first magazine publication of H.G. Wells'' The Time Machine from 1894–1895, and reprinted a short excerpt from it that had been omitted by every subsequent printing.'
]

{ #category : #sentences }
MgMarkovExamples >> sentenceWithInitialsAtTheBeginning [
	^ 'H.G. Wells reprinted a short excerpt from it that had been omitted by every subsequent printing.'
]

{ #category : #sentences }
MgMarkovExamples >> thirdSentence [
	^ 'We invented moldable development and we are building the Glamorous Toolkit.'
]

{ #category : #words }
MgMarkovExamples >> thirdWord [
	<gtExample>
	^ 'moldable'
]

{ #category : #sentences }
MgMarkovExamples >> threeSentences [
	<gtExample>
	| aSentences |
	aSentences := ' ' join: { self firstSentence. self secondSentence. self thirdSentence. '' }.
	self assert: aSentences size equals: 281.
	^ aSentences
]

{ #category : #tokenizer }
MgMarkovExamples >> tokenizeSentenceWithInitials [
	<gtExample>
	| aTokenizer aSentences |
	aTokenizer := self sentenceTokenizer.
	aSentences := aTokenizer tokenizeString: self sentenceWithInitials.
	self assert: aSentences isNotNil.
	self assert: aSentences size equals: 2.
	self assert: aSentences first equals: (('.' split: self sentenceWithInitials) first, '.').
	self assert: aSentences second equals: ('.' join: ('.' split: self sentenceWithInitials) allButFirst).
	^ aSentences
]

{ #category : #tokenizer }
MgMarkovExamples >> tokenizeSentenceWithInitialsAtTheBeginning [
	<gtExample>
	| aTokenizer aSentences |
	aTokenizer := self sentenceTokenizer.
	aSentences := aTokenizer tokenizeString: self sentenceWithInitialsAtTheBeginning.
	self assert: aSentences isNotNil.
	self assert: aSentences size equals: 1.
	self assert: aSentences first equals: self sentenceWithInitialsAtTheBeginning.
	^ aSentences first
]

{ #category : #tokenizer }
MgMarkovExamples >> tokenizeThreeSentences [
	<gtExample>
	| aTokenizer aSentences |
	aTokenizer := self sentenceTokenizer.
	aSentences := aTokenizer tokenizeString: self threeSentences.
	self assert: aSentences isNotNil.
	self assert: aSentences size equals: 3.
	self assert: aSentences first equals: self firstSentence.
	self assert: aSentences second equals: self secondSentence.
	self assert: aSentences third equals: self thirdSentence.
	^ aSentences
]

{ #category : #words }
MgMarkovExamples >> twoLinkedWords [
	<gtExample>
	| aWords |
	aWords := self emptyLinkedWords.
	aWords words: self twoWords.
	self assert: aWords numberOfWords equals: 2.
	self assert: aWords words equals: self twoWords.
	^ aWords
]

{ #category : #words }
MgMarkovExamples >> twoWords [
	<gtExample>
	^ Array with: self firstWord with: self secondWord
]

{ #category : #words }
MgMarkovExamples >> twoWordsEquality [
	<gtExample>
	| aFirstWords aSecondWords |
	aFirstWords := self twoLinkedWords.
	aSecondWords := self twoLinkedWords.
	self assert: aFirstWords equals: aSecondWords.
	^ Array with: aFirstWords with: aSecondWords
]

{ #category : #words }
MgMarkovExamples >> twoWordsNotEquality [
	<gtExample>
	| aFirstWords aSecondWords |
	aFirstWords := self twoLinkedWords.
	aSecondWords := self emptyLinkedWords.
	self assert: aFirstWords ~= aSecondWords.
	^ Array with: aFirstWords with: aSecondWords
]
